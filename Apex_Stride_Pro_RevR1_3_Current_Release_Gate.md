# Apex Stride Pro — current release gate (Rev R1.3)

**Disposition: NOT CLEARED FOR HUMAN WEAR.** Start with `REV_R1_3_FULL_AUDIT_REPORT.md`.

## Digitally verified against final source

- 130/130 source/package regression checks; three source copies byte-identical.
- 9/9 cavity probes; 61/61 adjustment positions, 250/250 coordinate checks.
- 6/6 exact rail/stop CSG; 24/24 screw/EVA/bridge-interface CSG.
- 42/42 fit-kit parts freshly exported; 72/72 current STL meshes pass independent mesh checks.
- 42 fit-kit index rows reconciled to actual extents and volumes; 72 assembly-map rows, no missing paths.
- 24 native OpenSCAD mass exports pass; values are assumed-density estimates and omit major components.

## Rev R1.3 geometry correction

Forefoot lightening-pocket roof 5.5→10.1 mm, pocket width 11→9 mm, center web 1→5 mm. External 20.6 mm deck/sole thickness is preserved. Full details and source hashes are in `REV_R1_3_CORRECTION_INDEX.md` and `REV_R1_3_QA.json`.

## Remaining release gates

No material-specific 3D FEA was run and no physical proof-load, fatigue, impact, pin/retention, pressure/leak/relief-transient, outsole traction/tear/bond, sewn-upper retention, physical fit or human-use trial was performed. The 90.3 mm pin beam sensitivity is 678 MPa at 2× and 1,017 MPa at 3× against a candidate 725 MPa proof reference, subject to unresolved load path. The bridge counterbore leaves a 0.8 mm cap; its joint strength and preload remain unqualified. At 0.50 MPa the small target bladder contributes only 297 N nominally; chassis must carry the residual and the full load with no pressure.

**Do not wear or body-load this design.** Supplier material conditions, tolerances and physical qualification must be independently reviewed and completed before any wearable trial.
