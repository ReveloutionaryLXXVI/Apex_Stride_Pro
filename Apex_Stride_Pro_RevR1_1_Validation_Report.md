# Apex Stride Pro — Rev R1.1 corrected validation and design-input fixes

**Date:** 2026-10-16  
**Baseline:** Rev R geometry with corrected M4 counterbores and Rev R1.1 pneumatic area/load-path design inputs  
**Disposition:** Digital geometry checks pass after a small interface correction. **This remains a non-wearable fit/mockup and engineering-review package; structural capacity, pressure safety, and human wear are not cleared.**

## Defect 1 — M4 screw-head interference corrected

An exact OpenSCAD CSG intersection test was added for the nominal M4 screw envelopes against the actual strap and footbed geometry. The first run passed the six toe-screw-to-EVA checks but failed all six toe button-head/strap checks: the recess cutter started 0.01 mm below the strap face but was only 2.20 mm high, ending 0.01 mm short of the 2.20 mm head envelope. That left a tiny positive-volume overlap in the nominal CAD.

**Fix:** all three M4 button-head recess cutters in `revision/Apex_Stride_Pro_RevR.scad` now use `bridge_screw_head_depth + 0.01` cutter height. Since each cutter starts 0.01 mm below the external face, the recess into the actual strap stays 2.20 mm deep; the cutter simply reaches the intended head top plane. The authoritative CAD, print-prep source, and standalone CAD copy were synchronized. The toe screw / EVA clearances were not changed.

The new exact-interface suite checks the 16 mm moving toe anchors, 18 mm heel anchors, and indexed rear-strap locking screw envelopes at EU42/EU44/EU46. Latest result: **24/24 PASS, 0 FAIL**. Nominal cylinder models prove geometric non-interference only; they are not manufacturer CAD or physical fit tests.

## Defect 2 — pneumatic pressure demand corrected in the model and circuit schedule

The former screen treated the entire 55×23 mm cavity (1,265 mm²) as the pressure-effective bladder area. That was wrong: the OEM RFQ envelope for the bladder body is at most 27×22×14 mm, giving only a 594 mm² projected-rectangle proxy before seam, fold, port and load-height effects. The corrected single-foot demand if the bladder alone carried the 647.46 N load is **1.090 MPa at 1×** and **2.180 MPa at 2×**; the former figures of about 0.512 MPa and 1.024 MPa are superseded.

**Actual design-input correction:** the editable CAD now includes explicit 0.40 MPa provisional working and 0.50 MPa provisional nominal-relief targets, candidate circuit pressure ratings, and assertions that reject out-of-hierarchy values or a mistaken cavity/bladder sizing relationship. The component schedule and the load-screen CSV/JSON were recalculated. At the maximum target projected area these setpoints correspond to 237.6 N / 297 N nominal assistance; therefore the structural chassis must carry the residual and the complete load with the bladder vented. This prevents the design arithmetic from treating the bladder as a sole supporting spring. The targets are provisional bench design inputs, not permission to pressurize: final bladder rating/force-area data, relief-flow/overshoot and fail-vent behavior remain required.

## Fresh software verification results

| Check | Fresh result | What it establishes |
|---|---:|---|
| Source/package/mesh suite | 129/129 PASS | Selectors/configurations, source parity, component mesh integrity, documentation/map checks and arithmetic gates |
| Continuous heel-core cavity | 9/9 rows | Cavity ray probes, watertightness, and invariance to the optional lightening switch across EU42/44/46 |
| Adjustment sweep | 61/61 positions; 250 checks | Nominal slider/stop/bridge arithmetic only |
| Rail/stop exact CSG | 6/6 PASS | No positive-volume intersection at indexed positions for both rails across EU42/44/46 |
| New M4/EVA/bridge interface CSG | 24/24 PASS | Empty exact CSG overlap for nominated screw/head envelopes with actual strap/footbed geometry |
| Non-wearable fit-kit STL export | 42/42 PASS | Watertight/winding/finite-volume/plate-orientation mesh checks |
| Verified native mesh mass basis | 66 exports (from the prior geometry-identical Rev R1 run; R1.1 changes are non-geometric) | CAD mesh volumes multiplied by explicitly assumed material densities; excludes important real parts |
| Assembly-file map | 72 entries, 0 missing | All mapped file paths resolve |

The adjustment sweep reports no nominal arithmetic failures. These checks do **not** model manufacturing tolerances, part deformation, fatigue, physical contact pressure, or load-rated performance.

## Verified modeled platform mass (geometry unchanged by the Rev R1.1 pressure-input correction)

| Size | Rev K modeled platform | Rev R modeled platform | Delta |
|---|---:|---:|---:|
| EU42 | 566.254 g | 570.325 g | +4.071 g |
| EU44 | 570.104 g | 574.210 g | +4.106 g |
| EU46 | 573.953 g | 578.094 g | +4.141 g |

These figures are partial model estimates—not measured finished-shoe mass. They exclude EVA/footbed mass, actual retaining ring, production fasteners, upper, return spring, bladder, tubing/fittings/regulator, adhesive and other unmodeled parts. Outsole mass assumes an illustrative 1.20 g/cm³ density. The modeled mass-reduction target remains unmet.

## 66 kg structural / pneumatic screen

The full 66 kg gravitational load is **647.46 N** (`66 × 9.81`). The load-screen multipliers intentionally assign that entire load to **one shoe** as a conservative single-support sensitivity case; they do not use the average two-foot stance. The ideal equal bilateral static share is **323.73 N per foot** (which would mean half the listed force/stress/pressure values before any multiplier if that were the chosen load case). The 1.5×/2×/3× cases are analyst sensitivities, not measured gait loads or safety factors.

- **Pneumatics — corrected calculation:** the previous screen wrongly used the 1,265 mm² *whole cavity* area as bladder area. The specified RFQ bladder body is ≤27×22×14 mm, so its maximum target projected rectangle is only **594 mm²** before the effective pressure area is confirmed. If the bladder alone carried the full 647.46 N single-shoe load, pressure demand is 1.090 MPa at 1×, 1.635 MPa at 1.5×, 2.180 MPa at 2× and 3.270 MPa at 3× (the bilateral static share is 0.545 MPa). This cannot be handled by the candidate KQ2 fittings rated 1.0 MPa. **Corrective design input:** treat the bladder as an auxiliary-force element with a 0.40 MPa provisional working target and 0.50 MPa nominal relief-setpoint target. The nominal force is 237.6 N at working target and 297 N at relief target; the chassis must carry the remainder and withstand the complete external load with the bladder depressurized. Setpoints remain provisional until the bladder's working/burst/cycle rating and actual effective area are known and relief-flow/overshoot tests show chamber transients remain below every component rating.
- **Cavity roof:** the 5.5 mm PA12 roof's one-way strip screen is sensitive to assumed load-spread width. At 20 mm spread width it estimates 36.92 MPa at 1×, 73.84 MPa at 2× and 110.76 MPa at 3×, compared with a 41 MPa published flexural-strength reference. The formula is not a 3D stress solution and 41 MPa is not a design allowable.
- **Pin:** the simple point-load beam screen depends strongly on assumed effective span: 40.6 mm rail-center spacing gives 152.49 MPa at 1× and 457.47 MPa at 3×; using a 90.3 mm whole-pin span gives 339.16 MPa at 1× and 1,017.47 MPa at 3×. The true support/load distribution is unresolved; neither is a validated pin stress. A 725 MPa candidate H1150D proof reference is just a material comparison, not a design allowable or fatigue limit.

No compatible FEA solver/workflow was found or run in this environment. No material-specific 3D FEA, mesh convergence/contact analysis, tolerance/strain simulation, pressure/leak/burst test, static proof load, impact/fatigue cycle, pin/ring retention test, outsole bond/slip test, sewn upper fit test, or human-wear test was performed. The CSV/JSON load screen records all scenarios and limitations at `revision/verification_results/revR1_fresh_validation/`.

## Release decision

**Digital source/mesh/interface checks: PASS after the 0.01 mm cutter correction. Structural qualification and human wear: NOT CLEARED.** Keep the shoe non-wearable until the production material/process and exact hardware are fixed, the load/contact path is independently analyzed with approved allowables, the bladder/circuit has rated hardware and fail-safe dump behavior, and appropriate guarded physical proof/fatigue/fit/traction tests pass.

Reproduce the validation with the source scripts under `revision/tools/`; the current report and machine-readable QA summary are `REV_R1_FRESH_VALIDATION_REPORT.md` and `revision/verification_results/revR1_fresh_validation/REV_R1_FRESH_VALIDATION_QA.json`.
