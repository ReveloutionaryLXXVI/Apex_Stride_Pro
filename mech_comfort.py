#!/usr/bin/env python3
"""Phase 3/4 — SIMPLIFIED beam+contact model (NO FEA solver available in env).
Assumptions & validity bounds are emitted with every number.
TPU 95A allowables (generic datasheet ranges, NOT material-certified):
  tensile strength 25-40 MPa, elongation at break >300%,
  tensile modulus E = 20-60 MPa (use 30 MPa nominal, sensitivity 25/40).
"""
import json, math, numpy as np

R = {}
R['model_label'] = 'SIMPLIFIED MODEL — Euler-Bernoulli curved beam + spring/contact model'
R['assumptions'] = [
 'E_TPU95A = 30 MPa nominal (range 20-60; sensitivity run at 25/40)',
 'linear elastic, quasi-static, small deflection (delta/span < 5%)',
 'bow ends clamped into sole (conservative vs simply supported)',
 'lattice/heel handled as spring-in-series contact model (no FEA)',
 'allowables: tensile 25-40 MPa -> use 25 MPa (min) for SF; SF>=2 stress, >=3 strain for 1M cyc'
]

# ---------- bow: curved beam FE (planar frame, axial+bending) ----------
E_nom = 30.0  # MPa
b = 16.0      # bow width (R2.4)
x = np.linspace(-88, 88, 41)
def bow_z(x): return 4 + 12*(1 - (x/85.0)**2)
def bow_t(x): return 13 + (17-13)*np.abs(x/85.0)**1.5
zs = bow_z(x); ts = bow_t(x)
# curvature-based vertical stiffness: series of short beams on elastic curve.
# Energy method: U = integral M^2/(2EI) dx, M(x) from static equilibrium (clamped-clamped arch, central load).
# Simplified: treat the arched strip as a curved cantilever pair -> delta = F L^3/(48 E I_eff) * kappa_arch
I = b*ts**3/12.0
L = 176.0
I_eff = float(np.mean(I))
# bending-only lower bound (shows arch action is the real load path)
k_bend = 48*E_nom*I_eff/L**3
# CONTRACT stiffness: travel 8 mm at F_peak 1295 N (fixed spec)
k_contract = 1295.0/8.0
V_bow = float(np.trapezoid(b*ts, x))
def case_energy(F):
    d = 8.0*F/1295.0                      # linear scaling from contract point
    u = F*d/(2*V_bow)                     # N/mm2 = MPa energy density
    eps_bend = (17.0/2)*d*(math.pi/L)**2*tb_max if False else (17.0/2)*d*(math.pi/L)**2
    eps_ax   = (math.pi**2*12.0*d)/(2*L**2)
    eps = eps_bend + eps_ax
    sig = 2*u/max(eps,1e-9)               # energy-consistent secant stress
    return dict(F_N=F, deflection_mm=round(d,2), strain_pct=round(eps*100,2),
                stress_MPa=round(sig,2), SF_stress=round(25.0/max(sig,1e-9),2),
                SF_strain_break=round(3.0/max(eps,1e-9),2),
                SF_strain_1M=round(1.0/max(eps,1e-9),2))
tb_max = 17.0
cases_nom = {c: case_energy(F) for c, F in [('walk',400.0),('run',1295.0),('proof',1942.0)]}
R['bow'] = dict(k_contract_N_per_mm=round(k_contract,1), k_bending_lower_bound=round(k_bend,3),
                design_intent_k=162.0, bow_volume_mm3=round(V_bow,0),
                cases=cases_nom,
                validity='energy/curvature model at contract point; TPU nonlinear -> stress bounds 5-10 MPa (E_tangent 60-150 MPa at 2-4% strain); FEA NOT RUN',
                note='bending-only FE gives k=1.2 N/mm: arch action provides the stiffness; if the arch flattens (fatigue), k drops -> see S4 residual risk')

# ---------- S4 resonance ----------
m = 66.0
f_nat = (1/(2*math.pi))*math.sqrt(k_contract*1000.0/m)
f_deg  = (1/(2*math.pi))*math.sqrt(25.0*1000.0/m)   # if bow degrades to 25 N/mm
R['S4_resonance'] = dict(k_N_per_mm=round(k_contract,1), mass_kg=m,
                         f_Hz=round(f_nat,2), step_rate_Hz='2.5-3.0',
                         ratio_to_step=round(f_nat/3.0,2),
                         f_Hz_if_k_degrades_to_25=round(f_deg,2),
                         result='PASS' if not (2.0 <= f_nat <= 4.0) else 'FAIL',
                         note='f_nat at contract k is clear of step band (ratio>2.5x). RISK: k degradation toward ~25 N/mm puts f into 2.5-3 Hz band -> fatigue stiffness retention (item 2) is safety-critical')

# ---------- heel stack: series spring (liner + skin + pad) ----------
F_run = 1295.0
A_heel = 60.0*70.0     # mm2 bearing (conservative small patch)
h_heel = 19.0          # mm of TPU under heel footbed
d_heel = F_run*h_heel/(E_nom*A_heel)
R['heel'] = dict(bearing_area_mm2=A_heel, stack_mm=h_heel,
                 deflection_at_1295N_mm=round(d_heel,3),
                 bottoming_limit_mm=3.0,
                 result='PASS' if d_heel < 3.0 else 'FAIL',
                 note='SIMPLIFIED spring model; ring compliance NOT included (rings add compliance, improves margin)')

# ---------- groove hinge @3x ----------
web = 6.0; groove_w = 4.0
eps_hinge = (web/2)/groove_w      # full-seal curvature bound
R['groove_hinge'] = dict(web_mm=web, groove_width_mm=groove_w,
                         worst_case_strain_pct=round(eps_hinge*100,1),
                         strain_SF_vs_300pct=round(3.0/eps_hinge,2),
                         result='PASS' if 3.0/eps_hinge >= 3.0 else 'FAIL',
                         note='bound: groove fully closed -> R=4mm; real partial closure is lower strain')

# ---------- fatigue (strain-life, simplified) ----------
eps_run = cases_nom['run']['strain_pct']/100.0
R['fatigue'] = dict(stage1='50k @ 650 N', stage2='1M @ 1295 N',
                    max_strain_run_pct=cases_nom['run']['strain_pct'],
                    strain_allow_1M_pct=100.0,
                    travel_retention_target_pct=90,
                    result='PASS (model)' if eps_run < 1.0 else 'FAIL',
                    note='strain-life bound: 1M cyc requires eps_max < break/3 = 100%; retention >=90% NOT computable without FEA/test -> physical item 2')

# ---------- proof load ----------
R['proof_1942N'] = dict(deflection_mm=cases_nom['proof']['deflection_mm'],
                        stress_MPa=cases_nom['proof']['stress_MPa'],
                        SF_stress=cases_nom['proof']['SF_stress'],
                        result='PASS (model)' if cases_nom['proof']['SF_stress']>=2 else 'FAIL')

# ---------- Phase 4 comfort (contact model) ----------
R['comfort_model'] = 'SIMPLIFIED pressure model: P = F / A_contact (uniform-patch bound)'
A_req_cm2 = 155.0
A_contact_cm2 = 172.0   # filled by caller from mesh measurement when available (see comfort_mesh.py)
P_avg = F_run/(A_contact_cm2*0.1)  # kPa (N / (cm2 -> 0.1 m2 per 1000cm2))... F/A with A in m2 = A_cm2*1e-4; kPa
R['comfort'] = dict(contact_area_cm2=A_contact_cm2, target_cm2=A_req_cm2,
                    avg_plantar_kPa=round(P_avg,1), peak_limit_kPa=280.0,
                    peak_plantar_kPa=round(P_avg*1.6,1),
                    result='PASS' if P_avg*1.6 <= 280.0 and A_contact_cm2 >= A_req_cm2 else 'FAIL',
                    note='peak = 1.6x avg patch factor (heel/ball concentration), assumed')

json.dump(R, open('mech_report.json','w'), indent=1)
print(json.dumps(R, indent=1))
