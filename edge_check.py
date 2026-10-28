#!/usr/bin/env python3
"""Contact-edge check proxy: facet-dihedral sampling on contact zones.
A tessellated mesh cannot give analytic fillet radii; we measure the dihedral
angle across sharp convex edges in contact zones (collar rim, gill rims, tab).
Blunt dihedral >= 150 deg is treated as effectively r>=1.0 for TPU flex."""
import trimesh, numpy as np, json, sys
b = trimesh.load(sys.argv[1] if len(sys.argv) > 1 else 'r24/body_R24_v3.stl', force='mesh')
adj = b.face_adjacency
ang = np.degrees(b.face_adjacency_angles)          # 0 = coplanar
centers = b.triangles_center[adj].mean(axis=1)
convex = b.face_adjacency_convex
zones = {
  'collar_rim (z>36, x<20)':   (centers[:,2] > 36) & (centers[:,0] < 20),
  'gill_side_rim (|y|>40)':    np.abs(centers[:,1]) > 40,
  'pull_tab (x<-140, z>30)':   (centers[:,0] < -140) & (centers[:,2] > 30),
}
out = {}
for name, mask in zones.items():
    m = mask & convex & (ang > 20)     # sharp convex edges only
    if m.sum() == 0:
        out[name] = dict(sharp_convex_edges=0, note='no sharp convex edge facets found in zone')
    else:
        out[name] = dict(sharp_convex_edges=int(m.sum()),
                         dihedral_min_deg=round(float((180-ang[m]).min()),1),
                         dihedral_median_deg=round(float(np.median(180-ang[m])),1),
                         note='dihedral = interior angle between facets; <150 deg = sharp edge, radius unproven')
print(json.dumps(out, indent=1))
json.dump(out, open('edge_report.json','w'), indent=1)
