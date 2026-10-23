# Rev R1.4 GO 1 + GO 2 — QA summary

## Results from final-source runs

| Check | Result | Scope |
|---|---:|---|
| Source/package compile and reference suite | 130/130 PASS | 42 fit-kit index entries, 21 upper concept STLs, 9 optional outsole STLs, 72 active assembly-map rows, zero missing paths |
| Kinematic sweep | 61/61 PASS; 250/250 arithmetic checks | Nominal geometry only; no manufacturing tolerance simulation |
| Rail/stop solid intersections | 6/6 PASS | CGAL positive-volume interference check; intended stop contact remains |
| Bridge joint / fastener interface | 18/18 PASS | 12 CSG tests + six coordinate/geometry guardrails |
| M4×14 lock shank vs deck | 4/4 PASS | Nominal cylindrical shank/relief CSG, no actual threads or nuts |
| Fit-kit exports | 42/42 | Fresh fit/mockup STL exports; not load-bearing production parts |
| Mass export | 66 geometry/material variants | Density-card estimates, not measured finished mass |
| Active STL topology audit | 72/72 pass after processing | Raw facets are welded/processed for topology; the audit does not rewrite STL bytes |

## 66 kg structural and pneumatic arithmetic

- Static one-foot gravitational load: 66 kg × 9.81 m/s² = **647.46 N**.
- Equal bilateral static share: **323.73 N per foot**.
- Target bladder body envelope: 27×22 mm = **594 mm²** nominal projection. If it alone carries the full static load, simplified pressure demand is **1.09 MPa**, above the candidate fitting's 1.0 MPa maximum operating rating.
- At the provisional 0.50 MPa relief target, ideal bladder force is **297 N**; residual chassis force is **350.46 N** at 1× static. The structural design case is still **647.46 N at zero pressure**. The 1.5×, 2× and 3× levels in the CSV are analyst-selected sensitivities, not a certified gait-load standard.
- Bridge strap thickness is 4.5 mm; head recess depth 2.2 mm; nominal cap is **2.3 mm**. Pair stagger is ±2 mm longitudinally, with a **2.87 mm nominal gap** between Ø7.9 mm head recess envelopes.
- Toe M4×16 nominal tip z=−0.1 mm vs footbed underside z=+0.15 mm gives **0.25 mm nominal clearance**. Lock M4×14 tip projects 1.55 mm past the pocket top into 1.65 mm relief, for **0.10 mm nominal axial clearance**.
- Pin sensitivity remains a gate: Ø8 mm shaft, Ø7.6 mm retaining groove root, 40.6 mm rail support span. A hypothetical 3× central point load over 40.6 mm gives ~392 MPa; a 90.3 mm unsupported groove-root scenario gives ~1,018 MPa. These are simplified sensitivities, not predictions of the actual joint stress. Real lock forces/contact distribution have not been measured.

## Mass estimate by shoe size

| Size | Modeled lower platform + pin + outsole placeholder |
|---|---:|
| EU42 | 595.10 g |
| EU44 | 598.98 g |
| EU46 | 602.87 g |

Outsole density is an illustrative 1.20 g/cm³. Actual footbeds, ring, production fasteners, upper, spring, bladder, tube, fittings, pressure control and adhesive are excluded. This is not complete-shoe mass.

## Release decision

GO 1 load path and GO 2 bridge/screw redesign are implemented and digitally checked. The Ø8/Ø7.6-groove custom pin geometry was not changed because the actual longitudinal locking loads, impact loads, bearing distribution and retention requirements remain unspecified; changing pin size without resolving those inputs could break rail clearances without demonstrating a safer design. Exact M4×22 and M4×14 SKUs are TBD. Material-specific FEA and all physical proof/cycle tests are not run. The package is **not released for manufacturing or human wear**.
