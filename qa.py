#!/usr/bin/env python3
"""R2.3/R2.4 digital QA — mesh metrics + suspect tests S1..S6 (trimesh + manifold3d).
All geometry facts come from the rendered STLs; nothing is assumed."""
import json, sys, math, numpy as np, trimesh
from trimesh import boolean

ENG = 'manifold'
def load(p):
    m = trimesh.load(p, force='mesh')
    return m

def vol(m):
    return float(m.volume)

def inter_vol(a, b):
    try:
        r = boolean.intersection([a, b], engine=ENG)
        if r is None or r.is_empty: return 0.0, None
        return abs(float(r.volume)), r
    except Exception as e:
        return float('nan'), str(e)

def bbox_str(m):
    return [[round(v,2) for v in m.bounds[0]], [round(v,2) for v in m.bounds[1]]]

R = {}
body = load('harness/t_body.stl')
base = load('baseline.stl')
R['body_volume_mm3'] = round(vol(body), 1)
R['body_area_mm2'] = round(float(body.area), 1)
R['body_watertight'] = bool(body.is_watertight)
R['body_winding_ok'] = bool(body.is_winding_consistent)
comps = body.split(only_watertight=False)
R['body_components'] = len(comps)
R['body_comp_volumes_mm3'] = [round(abs(float(c.volume)),1) for c in sorted(comps, key=lambda c: -abs(float(c.volume)))][:8]
R['body_bbox'] = bbox_str(body)
R['body_mass_g_rho120'] = round(vol(body)/1000.0*1.20, 1)

R['export_volume_mm3'] = round(vol(base), 1)
R['export_watertight'] = bool(base.is_watertight)
R['export_components'] = len(base.split(only_watertight=False))
R['S6_export_vs_body_delta_mm3'] = round(vol(base) - vol(body), 3)
R['S6_export_vs_body_delta_pct'] = round((vol(base)-vol(body))/max(vol(body),1)*100, 5)
R['export_mass_g_rho120'] = round(vol(base)/1000.0*1.20, 1)
R['export_bbox'] = bbox_str(base)

# ---- S1: decor cutters vs body (do they cut anything?) ----
for name, f in [('S1_ruler','harness/t_ruler.stl'), ('S1_speedlines','harness/t_speedlines.stl'),
                ('S1_turbine','harness/t_turbine.stl'), ('S2_text_asplaced','harness/t_text.stl')]:
    try:
        cut = load(f)
        R[name+'_cutter_volume_mm3'] = round(vol(cut), 1)
        v, r = inter_vol(cut, body)
        R[name+'_cut_volume_mm3'] = round(v, 3) if v==v else v
        if isinstance(r, type(None)) or hasattr(r,'bounds'):
            R[name+'_cut_bbox'] = bbox_str(r) if (r is not None and not getattr(r,'is_empty',True)) else None
    except Exception as e:
        R[name+'_error'] = str(e)

# S2: does text() render at all headless?
try:
    oracle = load('harness/t_text_oracle.stl')
    R['S2_text_oracle_volume_mm3'] = round(vol(oracle), 2)
    R['S2_font_renders'] = bool(vol(oracle) > 1.0)
except Exception as e:
    R['S2_oracle_error'] = str(e)

# ---- S3: flex grooves breach footbed? ----
try:
    fg = load('harness/t_flexgrooves.stl')
    fn = load('harness/t_footneg.stl')
    v, r = inter_vol(fg, fn)
    R['S3_groove_x_footnegative_mm3'] = round(v, 3) if v==v else v
    # per-groove: top of groove cut vs footbed z at y=0
    sec = []
    for x in [72, 94, 114, 128]:
        # groove cutter bbox in z near this x
        b = fg.bounds
        # sample: vertical ray at (x,0) through footneg mesh -> footbed z (lowest z of cavity at y=0)
        locs, idx_r, idx_t = fn.ray.intersects_location(ray_origins=np.array([[x,0,60.0]]),
                                                        ray_directions=np.array([[0,0,-1.0]]))
        fb = float(np.min(locs[:,2])) if len(locs) else float('nan')
        # groove cut: ray down through body later; here cutter top z near y=0
        sub = fg.slice_plane(plane_origin=[0,0,0], plane_normal=[0,0,1])
        sec.append((x, fb))
    R['S3_footbed_z_at_grooves_mm'] = {str(x): round(z,2) for x,z in sec}
except Exception as e:
    R['S3_error'] = str(e)

# ---- S5: bow channel vents ----
try:
    bc = load('harness/t_bowchan.stl')
    gl = load('harness/t_gills.stl')
    v1, _ = inter_vol(bc, gl)
    R['S5_channel_x_gills_mm3'] = round(v1, 3) if v1==v1 else v1
    # channel vs bottom slab z<-0.01: does the channel open through the base?
    slab = trimesh.creation.box(extents=[400,240,20], transform=trimesh.transformations.translation_matrix([0,0,-10.01]))
    v2, _ = inter_vol(bc, slab)
    R['S5_channel_below_z0_mm3'] = round(v2, 2) if v2==v2 else v2
    R['S5_channel_bbox'] = bbox_str(bc)
    R['S5_gills_bbox'] = bbox_str(gl)
except Exception as e:
    R['S5_error'] = str(e)

# ---- S4 input: nothing to compute here (analytic in mech script) ----

# ---- rings: voids open to outside? sample ring cutter pts outside body ----
try:
    rg = load('harness/t_rings.stl')
    pts = rg.sample(4000)
    inside = body.contains(pts)
    frac_out = float(np.mean(~inside))
    R['rings_cutter_volume_mm3'] = round(vol(rg), 1)
    R['rings_sample_fraction_outside_body'] = round(frac_out, 4)
    v, r = inter_vol(rg, body)
    R['rings_cut_volume_mm3'] = round(v, 2) if v==v else v
except Exception as e:
    R['rings_error'] = str(e)

# ---- thickness audit: ray-cast wall thickness along -normal ----
try:
    pts, fidx = trimesh.sample.sample_surface(body, 6000)
    n = body.face_normals[fidx]
    origins = pts - n*1e-4
    dirs = -n
    locs, ray_idx, tri_idx = body.ray.intersects_location(ray_origins=origins, ray_directions=dirs, multiple_hits=False)
    d = np.linalg.norm(locs - origins[ray_idx], axis=1)
    d = d[d > 0.05]
    R['thickness_samples'] = int(len(d))
    R['thickness_min_mm'] = round(float(np.min(d)), 3)
    R['thickness_p1_mm'] = round(float(np.percentile(d,1)), 3)
    R['thickness_p5_mm'] = round(float(np.percentile(d,5)), 3)
    R['thickness_median_mm'] = round(float(np.median(d)), 3)
    R['thickness_frac_below_1p6'] = round(float(np.mean(d < 1.6)), 4)
    R['thickness_frac_below_1p8'] = round(float(np.mean(d < 1.8)), 4)
except Exception as e:
    R['thickness_error'] = str(e)

# ---- overhang audit ----
try:
    nz = body.face_normals[:,2]
    areas = body.area_faces
    bad = nz < -math.sin(math.radians(45))   # steeper than 45 deg from vertical
    R['overhang_area_mm2_gt45'] = round(float(areas[bad].sum()), 1)
    R['overhang_frac_of_surface'] = round(float(areas[bad].sum()/areas.sum()), 4)
    down = nz < -0.99
    R['flat_down_area_mm2'] = round(float(areas[down].sum()), 1)
except Exception as e:
    R['overhang_error'] = str(e)

json.dump(R, open('qa_report.json','w'), indent=1)
print(json.dumps(R, indent=1))
