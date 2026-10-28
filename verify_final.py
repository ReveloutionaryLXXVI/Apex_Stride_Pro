#!/usr/bin/env python3
"""Final R2.4 verification pass — runs on the newest body + export meshes."""
import trimesh, numpy as np, json, sys, os
from trimesh import boolean

body_p = sys.argv[1] if len(sys.argv) > 1 else 'r24/body_R24_v3.stl'
exp_p  = sys.argv[2] if len(sys.argv) > 2 else 'r24/Apex_Stride_Pro_RevR2_4_L.stl'
b = trimesh.load(body_p, force='mesh')
V = {}
comps = b.split(only_watertight=False)
vols = sorted([abs(float(c.volume)) for c in comps], reverse=True)
V['body'] = dict(path=body_p, volume_mm3=round(float(b.volume),1), mass_g=round(float(b.volume)/1000*1.2,1),
                 watertight=bool(b.is_watertight), winding_ok=bool(b.is_winding_consistent),
                 components=len(comps), comp_vols_top=[round(v,1) for v in vols[:8]],
                 bbox=b.bounds.round(2).tolist())
print('BODY:', json.dumps(V['body']))

def cut_volume(cut_p, name):
    m = trimesh.load(cut_p, force='mesh')
    cv = abs(float(m.volume))
    v = None
    if b.is_watertight:
        try:
            r = boolean.intersection([m, b], engine='manifold')
            v = 0.0 if (r is None or r.is_empty) else abs(float(r.volume))
        except Exception:
            v = None
    if v is None:  # fallback: containment sampling
        pts = m.sample(20000)
        inside = b.contains(pts)
        v = cv * float(np.mean(inside))
    V[name] = dict(cutter_mm3=round(cv,1), cut_mm3=round(v,3))
    print(f'{name}: cutter {cv:.1f} -> CUTS {v:.3f} mm3')

for name, f in [('S1_ruler','harness24/p_growth_ruler.stl'), ('S1_speedlines','harness24/p_speed_lines.stl'),
                ('S1_turbine','harness24/p_heel_turbine_engrave.stl'), ('rings','harness24/p_crash_rings.stl'),
                ('grooves','harness24/p_flex_grooves.stl')]:
    cut_volume(f, name)

fn = trimesh.load('harness24/p_footneg.stl', force='mesh')
fg = trimesh.load('harness24/p_flex_grooves.stl', force='mesh')
if b.is_watertight:
    r = boolean.intersection([fg, fn], engine='manifold')
    V['S3_groove_x_footcavity_mm3'] = 0.0 if (r is None or r.is_empty) else round(abs(float(r.volume)),3)
else:
    pts = fg.sample(20000); V['S3_groove_x_footcavity_mm3'] = round(abs(float(fg.volume))*float(np.mean(fn.contains(pts))),2)
print('S3 groove x footcavity:', V['S3_groove_x_footcavity_mm3'], 'mm3 (PASS = 0)')

webs = {}
for x in [72, 94, 114, 128]:
    locs,_,_ = b.ray.intersects_location(ray_origins=np.array([[x,0,80.0]]), ray_directions=np.array([[0,0,-1.0]]))
    l2,_,_ = fn.ray.intersects_location(ray_origins=np.array([[x,0,80.0]]), ray_directions=np.array([[0,0,-1.0]]))
    fb = float(np.min(l2[:,2])) if len(l2) else float('nan')
    zs = np.sort(locs[:,2])[::-1]
    webs[str(x)] = dict(footbed_z=round(fb,2), hits=[round(float(z),2) for z in zs[:8]])
V['groove_web'] = webs
print('grooves:', json.dumps(webs))

pts, fidx = trimesh.sample.sample_surface(b, 5000)
n = b.face_normals[fidx]; o = pts - n*1e-4
locs, ridx, _ = b.ray.intersects_location(ray_origins=o, ray_directions=-n, multiple_hits=False)
d = np.linalg.norm(locs-o[ridx],axis=1); d = d[d>0.05]
V['thickness'] = dict(min=round(float(d.min()),2), p5=round(float(np.percentile(d,5)),2),
                      median=round(float(np.median(d)),2), frac_lt_1p6=round(float((d<1.6).mean()),3))
print('thickness:', V['thickness'])

if os.path.exists(exp_p):
    e = trimesh.load(exp_p, force='mesh')
    V['S6_export'] = dict(path=exp_p, volume_mm3=round(float(e.volume),1), mass_g=round(float(e.volume)/1000*1.2,1),
                          components=len(e.split(only_watertight=False)),
                          delta_vs_body_mm3=round(float(e.volume)-float(b.volume),3))
    print('S6 export:', json.dumps(V['S6_export']))
json.dump(V, open('verify_final.json','w'), indent=1)
print('VERIFY_FINAL_DONE')
