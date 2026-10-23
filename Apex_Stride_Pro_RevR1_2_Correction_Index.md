# Rev R1.2 correction index — 2026-10-16

## Defects corrected in the deliverable

1. **M4 head/recess clash:** corrected the three counterbore cutter heights by +0.01 mm so they reach the nominal 2.2 mm screw-head envelope; the intended recess depth into the bridge remains 2.2 mm. Synchronized authoritative and print-prep CAD. The exact interface suite was freshly rerun against the corrected Rev R1.2 source and passed 24/24.
2. **Pneumatic pressure arithmetic:** replaced the incorrect use of the 55×23 mm whole cavity (1,265 mm²) as bladder effective area with the maximum projected target body rectangle of 27×22 mm (594 mm²). A 647.46 N one-shoe load would demand 1.090 MPa at 1× if the bladder alone supported it, exceeding the candidate fitting rating. Bladder is now bounded as an auxiliary-force target at 0.40 MPa working / 0.50 MPa nominal relief, not the main body-load path.
3. **Heel-deck roof geometry:** changed the real CAD subtraction to a 10.1 mm roof and 10.5 mm underside cavity while keeping the 20.6 mm external sole thickness and 55×23 mm cavity footprint; the 9 mm target bladder height leaves 1.5 mm nominal height clearance. Three EU-size heel-deck meshes were freshly exported, mesh-validated, and mass-reconciled. This adds approximately 5,819 mm³ or 5.53 g per heel deck assuming 0.95 g/cm³ PA12.

## Checks and disposition

- Nine core-cavity probes pass; cavity dimensions 55×23×10.5 mm; roof 10.1 mm; nominal rail-channel web 2.5 mm.
- Independent corrected load screen returns PASS for its arithmetic and nominal parameter hierarchy only; it explicitly reports that bladder-only load demand exceeds the fitting rating.
- The source/package regression was freshly executed against the released R1.2 tree and passed 130/130. The 9 cavity probes, 61-position/250-check kinematic sweep, 6 rail-stop CSG intersections, and 24 screw-interface CSG intersections also passed in live reruns.
- A full native mass audit from unchanged geometry had 66 verified component-size entries. For R1.2, the three modified heel-deck meshes were re-exported and their actual volume/mass deltas reconciled into the prior 66-entry basis; this is **not** represented as 66 fresh STL exports.
- This remains **not cleared for human wear**: no material-specific FEA, mesh-converged/contact analysis, supplier-confirmed bladder fit/rating, pressure-transient proof, load proof, fatigue, retention, traction or human-wear test has been performed.

## Live package audit correction

A secondary `PRINT_READY_BENCH_FIT_KIT/SHA256SUMS.txt` was found to contain 27 stale file hashes. Its 70 entries have now been regenerated against the actual delivered member bytes. The top-level `REV_R_PACKAGE_MANIFEST.sha256` was rebuilt and independently verified against every listed file. See `REV_R1_2_LIVE_INTEGRITY_AUDIT.md`.
