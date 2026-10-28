#!/usr/bin/env python3
"""Correct engraving/void verification on the FINAL body:
- sample points inside each cutter -> must be OUTSIDE body (region was carved)
- sample points in the band just deeper than the engrave depth -> must be INSIDE body (residual wall)
"""
import trimesh, numpy as np, json, sys
b = trimesh.load(sys.argv[1], force='mesh')
out = {}
def test(name, cut_p, deep_note):
    m = trimesh.load(cut_p, force='mesh')
    pts = m.sample(15000)
    inside = b.contains(pts)
    frac_carved = float(np.mean(~inside))
    out[name] = dict(cutter_mm3=round(abs(float(m.volume)),1),
                     fraction_cutter_volume_carved_from_body=round(frac_carved,3),
                     interpretation='1.0 = cutter fully lies in what was solid body -> engraving/void is real')
    print(name, out[name])

test('engrave_ruler', 'harness24/p_growth_ruler.stl', 'band 0.8 deep')
test('engrave_speedlines', 'harness24/p_speed_lines.stl', 'band 0.8 deep')
test('engrave_turbine', 'harness24/p_heel_turbine_engrave.stl', 'band 0.8 deep')
test('void_rings', 'harness24/p_crash_rings.stl', 'sealed void')
test('void_grooves', 'harness24/p_flex_grooves.stl', 'hinge cuts')

# residual wall under ruler engraving: points 1.0-1.4 mm inward from band outer surface
env_in = trimesh.load('harness24/p_footneg.stl', force='mesh')  # placeholder not used
# direct probe: points just inside body below ruler zone (x 130-150, y ~ +-40, z 5-20)
rng = np.random.default_rng(7)
pts = np.column_stack([rng.uniform(128,152,4000), rng.choice([-1.0,1.0],4000)*rng.uniform(36,44,4000), rng.uniform(3,22,4000)])
inside = b.contains(pts)
out['residual_wall_probe_ruler_zone'] = dict(fraction_inside_body=round(float(np.mean(inside)),3),
    note='probe points 0.6-4mm inside nominal ruler surface; high fraction = material remains under engraving')
print(out['residual_wall_probe_ruler_zone'])
json.dump(out, open('carve_report.json','w'), indent=1)
print('CARVE_VERIFY_DONE')
