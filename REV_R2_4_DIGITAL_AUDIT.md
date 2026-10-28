# REV R2.4 — DIGITAL AUDIT (Apex Stride Pro "Comfort Absolute")
Date: 2026-10-24 | Source SHA-256: c0aef889c0762a002b0809fced444d13172d2638d6ac600ca29b3ee3e83d1025 (Rev2_3.txt tail verified complete)
Tools: OpenSCAD 2021.01 (portable AppImage) · trimesh 5.2.0 · manifold3d · numpy/scipy (pip). admesh/CalculiX/FEBio/slicer: NOT AVAILABLE (no root) — logged, not stalled.

**WEAR STATUS: DIGITAL CANDIDATE — NOT CLEARED FOR HUMAN WEAR.**

| Check | Method | Result | What this establishes |
|---|---|---|---|
| F6 render clean | openscad -o *.stl, exit code | PASS | source compiles; asserts fire; echo logs captured |
| BBox sanity | trimesh bounds | PASS (R2.3) / FAIL z,width (R2.4 v1) | R2.3 325.9×91×54.1 in band. R2.4 z_min −5.5 (trim bug F12 fixed), width 102 (fit-driven, see note) |
| Watertight | trimesh | PASS (R2.3) / FAIL (R2.4 v1) | R2.4 v1 non-watertight from CGAL slivers + floaters; fixes F12/F13 applied, v2 re-render in flight at delivery |
| Mesh = 1 body | trimesh split | FAIL 15 (R2.3) / FAIL 87 (R2.4 v1) | R2.3: 14 floaters. R2.4 v1: main 99.4% + 86 fragments (9.0 cm³): bottom-trim band bug + floating pull tab → both fixed; residual slivers unverified |
| Mass | volume×1.20 | FAIL 532 g (R2.3) / **PASS 366.9 g (R2.4)** | band 340–420, target ~385 (Δ −18 g). R2.3 solver echo claimed 410 g — wrong by 122 g |
| Walls ≥1.6 / ribs ≥1.8 | ray-cast thickness + source asserts | FAIL 27.4% <1.6 (R2.3) / source PASS (R2.4) | R2.3 dense-lattice slivers; R2.4 rib grid 3.0 mm, skin 1.6, upper 2.6 |
| S1 ruler/speed/turbine | manifold3d intersect vs body | **CONFIRMED FAIL: cut 0.0 / 0.004 / 0.034 mm³** | decor sat outside body (y=±54 vs half-width 45.5; turbine rotated about origin → y=±107). F4: all decor now carved via 0.8 mm surface-band (depth bounded by construction, residual ≥1.6) |
| S2 text() headless | text probe render | PASS 77 mm³ | Liberation Sans:style=Bold renders (DejaVu absent here). As-placed cut = 0 → F5: per-side rotations (re-cut, never mirrored), band engraving |
| S3 grooves | intersect(grooves, foot cavity) | **CONFIRMED FAIL 2440 mm³ breach** | footbed z 7.25–8.91 vs groove tops z 12–15 (web negative). F6: tops 1.2/1.3/2.2/2.9 → web = 6.0 mm exactly, no breach |
| S4 resonance | f=(1/2π)√(k/m), k=162 N/mm (contract 8 mm @1295 N) | PASS 7.88 Hz | step band 2.5–3.0 Hz (ratio 2.6×). RISK: k→25 N/mm ⇒ 3.1 Hz (in band) |
| S5 venting | intersect(channel, gills) + channel∩z<0 | **CONFIRMED FAIL**: 0.0 mm³ vent, 5574 mm³ base breach | F8: channel floor clamped z≥2.5 + vent ducts channel→gills (gills = only openings) |
| S6 color split | volume(export) vs volume(body) | PASS Δ=0.0 mm³ | 443 322.8 = 443 322.8 exactly; color blocks are a pure partition |
| Heel 3-ring decoupler | intersect(rings, body) + containment sampling | **CONFIRMED FAIL: cut 0.0 mm³** | tori R=44/50/56 lay 98.8% outside the body — decoupler was fictional in R2.3. F9: rings clipped ≥1.6 mm inside skin, solid heel-pad matrix |
| Interior fit | cavity bbox | FAIL 313.8 mm (spec 290) | F3: interior rebuilt x −135..155 = **290 mm exactly**; toe room 22/16/9 mm; ball width 93 mm (see width note) |
| Load cases 400/1295/1942 N | SIMPLIFIED energy+curvature bow model | PASS (model) SF 11.9 / 3.7 / 2.5 | no FEA available; allowables 25–40 MPa tensile, >300 % elongation, SF≥2 stress / ≥3 strain for 1M cyc |
| Fatigue 50k@650 + 1M@1295 | strain-life bound | PASS (model), retention NOT COMPUTABLE | max strain 3.7 % vs 100 % 1M-cyc allow; travel retention ≥90 % = physical item 2 |
| Heel deflection @1295 N | spring model | PASS 0.20 mm (<3 mm) | ring compliance excluded (adds compliance) |
| Groove hinge @3x | full-seal curvature bound | PASS 75 % strain (SF 4.0 vs break) | overload check; 1× fatigue strain 25 % < 100 % allow |
| Comfort contact/pressure | mesh footbed area + P=F/A | PASS (model) 172 cm², peak ≈12 kPa | limits 155 cm² / 280 kPa. Heel vs R2.2 2-ring baseline: **NOT RUN** (no R2.2 geometry) |
| Contact edges r≥1.0 | construction + dihedral sampling | **NOT RUN** | slats r=2, tab sphere-hull; collar rim radius unmeasured |
| FEA / slicer | ccx / FEBio / prusa-slicer | **NOT RUN — requires tool** | not installable (no root in env) |

## Iteration log
|#|Defect (measured)|Fix|Re-verify|
|---|---|---|---|
|1|Lattice diamonds ~95 % solid → 532 g|F1 true rib grid (rib 3.0 mm), kept() corrected|366.9 g PASS|
|2|skin 1.5 mm < 1.6 wall floor|F2 skin 1.6, upper wall 2.6|assert PASS|
|3|All decor cut 0 mm³|F4 conformal 0.8 mm band engravers|construction-bounded; mesh re-verify in flight|
|4|Numerals misplaced; mirror risk|F5 per-side re-cut rotations|font oracle PASS|
|5|Grooves breached footbed (2440 mm³)|F6 groove tops = footbed − 6 mm|web 6.0 mm by construction|
|6|Bow floated in channel (loose body)|F7 bow ±88 embedded, channel ±82|in flight|
|7|Channel breached base; no gill vent|F8 floor clamp + vent ducts|in flight|
|8|3 rings cut nothing (outside body)|F9 rings clipped interior + heel pad|in flight|
|9|Interior 313.8 mm; width 75.8 mm impossible for foot|F3 interior 290 mm, ball 93 mm|22/16/9 by construction|
|10|Pull tab sharp rims + floated 12 mm above heel|F10 sphere hull; F13 anchor z=28|in flight|
|11|Bottom trim left z<0 material (z_min −5.5)|F12 trim all z<0|in flight|

## Notes & honest deltas
- **Width note:** R2.4 outer width 102 mm exceeds the 88–100 mm sanity band by 2 mm. Required: a 267 mm foot needs ≥98 mm ball width; R2.3's 91 mm outer / 75.8 mm interior could not physically contain the foot. Customer contract specifies length/toe-room only. Interior 93 mm ball + TPU give ≈ 98–100 mm fit.
- **Targets (recomputed, never tuned):** mass 366.9 g vs ~385 target (Δ −18 g, band PASS). Gain/speed from R2.3 solver formula with measured mass: gain ≈ 9.3–9.6 % (target 9.6), speed 12.0→13.2 | 15.0→16.4 | 17.1→18.7 (model formula retained; deltas within ±0.1 km/h — treat as ESTIMATE, no metabolics measured).
- **L/R pair:** design is y-symmetric; ruler numerals are cut per side with per-side rotations (never mirrored) in both files ⇒ L/R meshes identical by construction. S2 satisfied by construction, not by mirroring.

## Residual risks (top 5)
1. Component count / watertight of R2.4 **unverified** after F12/F13 (v2 render in flight at delivery). Do not print before `mesh check: 1 component, watertight` passes on `r24/body_R24_v2.stl`.
2. Resonance migration: bow fatigue toward k≈25 N/mm drops f_n to ~3.1 Hz — inside the 2.5–3.0 Hz step band. Physical item 2 (50k@650 N then 1M@1295 N, ≥90 % travel) is safety-critical for the growth plate.
3. Bow arch action = the only stiff load path (bending-only k = 1.2 N/mm). No FEA available to bound arch flattening; proof test item 1 (1942 N × 60 s × 3, <5 % set) must confirm.
4. Collar/entry rim contact edge radius unmeasured (r≥1.0 requirement UNVERIFIED).
5. Heel pressure vs R2.2 2-ring baseline NOT RUN (no R2.2 geometry provided).

## Physical protocol (verbatim — required before any human wear)
1. Static proof 1942 N × 60 s × 3 cycles, <5 % set | 2. Bow fatigue 50k@650 N then 1M@1295 N (≥90 % travel) | 3. Heel-ring dye-penetrant (no cracks) | 4. Wet traction ≥0.5 mu | 5. Dye 50k flex | 6. Fit 22/16/9 mm + ruler legible | 7. 10 min indoor walk (ANY heel pain = stop) | 8. 20–30 min soft jog | 9. 45 min mixed | 10. Full training + weekly heel check + clinician OK.

## FINAL RAPID-ITERATION ADDENDUM (22:19-22:49 sprint)
v3 -> v4 -> v5 loop driven after the first delivery. Measured on body_R24_v4.stl (watertight PASS):
| Check | v4 result |
|---|---|
| watertight | PASS |
| components | FAIL 24 (main 98.5%; 5524mm3 loose body = R2.3 dome -> F22 removed, v5 in flight) |
| mass | FAIL 441.7 g (band 420) -> trims applied (domes out, bow_w 12, accordion 96x16, upper_t 3.8), v5 in flight |
| groove web >=6 mm | PASS 6.4-9.9 mm at x=72/94/114/128 |
| groove footbed breach | PASS 0.0 mm3 |
| bow survival | PASS (F17 channel = shell around bow; F18 footbed raised over arch) |
| collar rim r>=1.0 | FAIL (dihedral 22-81 deg) — heat-roll/liner-lip finish required |
| bbox | 321 x 106 x 57 mm (width note as before) |

Methodology correction (honesty): cutter-vs-final-body intersection is zero BY CONSTRUCTION after
subtraction; engraving/void verification must use containment sampling (carve_verify.py). The R2.3
"cut 0.0" findings rest on geometric proof (cutters at y=+-54 / blades at y=+-107 vs body +-45.5),
which stands.

VERDICT: closest honest state = DIGITAL CANDIDATE. Mass + component-count final numbers pending
the v5 render; collar rim radius fails the r>=1.0 comfort item with a defined physical mitigation.
No software pass can clear this shoe for human wear — the 10-box protocol below does that.
