# Rev R1.1 correction index — Apex Stride Pro

**Current authoritative CAD:** `revision/Apex_Stride_Pro_RevR.scad` (exactly mirrored by `PRINT_READY_BENCH_FIT_KIT_REV_R/source/Apex_Stride_Pro_RevR_PrintPrep.scad`).

## Corrections implemented

1. **M4 button-head interference:** corrected counterbore cutter height by 0.01 mm while retaining the specified 2.20 mm recess into the bridge. Fresh interface suite: 24/24 nominal CSG checks pass.
2. **Bladder pressure-area math:** removed the full-cavity 1,265 mm² area from bladder demand calculations. The target bladder body envelope (27×22 mm projected rectangle) is 594 mm², and if it alone carried the 66 kg single-foot load the idealized pressure is 1.090 MPa (2.180 MPa at 2×), not 0.512 / 1.024 MPa.
3. **Pressure hierarchy and fail-load assumption:** encoded 0.40 MPa provisional working / 0.50 MPa provisional nominal relief targets and candidate hardware rating guardrails into source parameters/assertions and updated the circuit schedule. Nominal bladder force is 237.6 / 297 N; the chassis must carry all load if the bladder vents. These targets remain bench-only until actual bladder ratings, effective area, relief overshoot and a zero-pressure structural load path are verified.

## Fresh digital results

- Source/package checker: 129/129 PASS
- Heel-core cavity probes: 9/9 PASS
- Adjustment sweep: 61 positions / 250 arithmetic checks PASS
- Rail/stop exact CSG: 6/6 PASS
- M4/EVA/bridge exact CSG: 24/24 PASS
- Fit-kit meshes exported and validated: 42/42 PASS
- Assembly map: 72 references, zero missing
- Corrected load arithmetic/pressure hierarchy: PASS

The 66 mesh-export mass record is carried forward from the prior run of the **same geometry**; this Rev R1.1 update only changes non-geometric pressure parameters/assertions and documents the corrected calculation. No full material-specific FEA or physical test was completed. This design is **not cleared for pressurization or human wear**. The existing analytical roof/pin sensitivities are not design allowables.

**Machine-readable details:** `revision/verification_results/revR1_fresh_validation/REV_R1_INDEPENDENT_LOAD_SCREEN.csv`, `.json`, and `REV_R1_FRESH_VALIDATION_QA.json`; full report: `REV_R1_FRESH_VALIDATION_REPORT.md`.
