# Apex Stride Pro — Rev R1.2 corrected validation and design-input fixes

**Date:** 2026-10-16  
**Baseline:** Rev R geometry with corrected M4 counterbores, corrected bladder area/pressure inputs, and a 10.1 mm heel-core roof  
**Disposition:** Digital geometry checks pass after the screw-interface and local heel-core roof corrections. **This remains a non-wearable fit/mockup and engineering-review package; structural capacity, pressure safety, and human wear are not cleared.**

## Defect 1 — M4 screw-head interference corrected

An exact OpenSCAD CSG intersection test was added for the nominal M4 screw envelopes against the actual strap and footbed geometry. The first run passed the six toe-screw-to-EVA checks but failed all six toe button-head/strap checks: the recess cutter started 0.01 mm below the strap face but was only 2.20 mm high, ending 0.01 mm short of the 2.20 mm head envelope. That left a tiny positive-volume overlap in the nominal CAD.

**Fix 1:** all three M4 button-head recess cutters in `revision/Apex_Stride_Pro_RevR.scad` now use `bridge_screw_head_depth + 0.01` cutter height. Since each cutter starts 0.01 mm below the external face, the recess into the actual strap stays 2.20 mm deep; the cutter simply reaches the intended head top plane. The authoritative and print-prep CAD were synchronized; a standalone copy of the corrected source is also provided with the deliverables. The toe screw / EVA clearances were not changed.

The exact-interface suite checks the 16 mm moving toe anchors, 18 mm heel anchors, and indexed rear-strap locking screw envelopes at EU42/EU44/EU46. It was freshly rerun against the corrected Rev R1.2 source during the live audit and passed **24/24**. Nominal cylinder models prove geometric non-interference only; they are not manufacturer CAD or physical fit tests.

## Defect 2 — heel-core roof geometry reinforced

The prior 5.5 mm local roof over the spring/bladder cavity produced 36.92 MPa at 1× and 73.84 MPa at 2× in the 20 mm-width one-way strip sensitivity. Rather than only repeating that concern, Rev R1.2 changes the actual subtraction geometry: the roof is now **10.1 mm**, cavity height **10.5 mm**, and outside sole remains **20.6 mm**. The custom bladder RFQ height target is reduced from 14 to **9 mm**, leaving 1.5 mm nominal vertical clearance; length/width/port/fold clearances still require an OEM drawing. This local reinforcement adds 5,819 mm³ (about 5.53 g) of assumed-density PA12 in the heel deck. The corresponding simple strip sensitivity falls to **10.95 MPa at 1×, 21.90 MPa at 2× and 32.85 MPa at 3×** for a 20 mm load-spread width. This materially improves the screening result but does not replace material-specific FEA or proof/fatigue testing.

## Fresh software verification results

| Check | Fresh result | What it establishes |
|---|---:|---|
| Source/package/mesh suite | 130/130 PASS | Selectors/configurations, source parity, component mesh integrity, documentation/map checks and arithmetic gates |
| Continuous heel-core cavity | 9/9 rows | Cavity ray probes, watertightness, and invariance to the optional lightening switch across EU42/44/46 |
| Adjustment sweep | 61/61 positions; 250 checks | Nominal slider/stop/bridge arithmetic only |
| Rail/stop exact CSG | 6/6 PASS | No positive-volume intersection at indexed positions for both rails across EU42/44/46 |
| M4/EVA/bridge interface CSG | 24/24 PASS (fresh R1.2 rerun) | Empty exact CSG overlap for nominated screw/head envelopes with actual strap/footbed geometry; nominal envelopes only |
| Non-wearable fit-kit mesh validation | 42/42 PASS | Current 42 indexed STLs are validated; three affected heel-deck STLs were freshly re-exported for R1.2; other selector geometry is unchanged |
| Modeled mass basis | 66 component-size rows; 3 heel-deck meshes freshly re-exported and volume-validated for R1.2 | PA12 roof-volume delta measured on current heel-deck meshes; other selector geometry unchanged |
| Assembly-file map | 72 entries, 0 missing | All mapped file paths resolve |

The adjustment sweep reports no nominal arithmetic failures. These checks do **not** model manufacturing tolerances, part deformation, fatigue, physical contact pressure, or load-rated performance.

## Recomputed modeled platform mass

| Size | Rev K modeled platform | Rev R modeled platform | Delta |
|---|---:|---:|---:|
| EU42 | 566.254 g | 575.853 g | +9.599 g |
| EU44 | 570.104 g | 579.738 g | +9.634 g |
| EU46 | 573.953 g | 583.622 g | +9.669 g |

These figures are partial model estimates—not measured finished-shoe mass. They exclude EVA/footbed mass, actual retaining ring, production fasteners, upper, return spring, bladder, tubing/fittings/regulator, adhesive and other unmodeled parts. Outsole mass assumes an illustrative 1.20 g/cm³ density. The modeled mass-reduction target remains unmet.

## 66 kg structural / pneumatic screen

The full 66 kg gravitational load is **647.46 N** (`66 × 9.81`). The load-screen multipliers intentionally assign that entire load to **one shoe** as a conservative single-support sensitivity case; they do not use the average two-foot stance. The ideal equal bilateral static share is **323.73 N per foot** (which would mean half the listed force/stress/pressure values before any multiplier if that were the chosen load case). The 1.5×/2×/3× cases are analyst sensitivities, not measured gait loads or safety factors.

- **Pneumatics — corrected calculation:** the previous screen wrongly used the 1,265 mm² *whole cavity* area as bladder area. The specified RFQ bladder body target is ≤27×22×9 mm, so its maximum target projected rectangle is only **594 mm²** before the effective pressure area is confirmed. If the bladder alone carried the full 647.46 N single-shoe load, pressure demand is 1.090 MPa at 1×, 1.635 MPa at 1.5×, 2.180 MPa at 2× and 3.270 MPa at 3× (the bilateral static share is 0.545 MPa). This cannot be handled by the candidate KQ2 fittings rated 1.0 MPa. **Corrective design input:** treat the bladder as an auxiliary-force element with a 0.40 MPa provisional working target and 0.50 MPa nominal relief-setpoint target. The nominal force is 237.6 N at working target and 297 N at relief target; the chassis must carry the remainder and withstand the complete external load with the bladder depressurized. Setpoints remain provisional until the bladder's working/burst/cycle rating and actual effective area are known and relief-flow/overshoot tests show chamber transients remain below every component rating.
- **Cavity roof, corrected geometry:** Rev R1.2 thickens the local PA12 roof from 5.5 to 10.1 mm by reducing the custom bladder body height target to 9.0 mm; the outside sole thickness remains 20.6 mm, cavity depth is 10.5 mm, and target vertical clearance is 1.5 mm. The same one-way strip sensitivity at 20 mm load-spread width falls from 36.92 to about 10.95 MPa at 1×, 21.90 MPa at 2× and 32.85 MPa at 3×, versus a 41 MPa published flexural-strength reference. This is only an analytical geometry sensitivity—not 3D FEA, a design allowable or fatigue proof. Supplier must confirm a finished 9 mm-high bladder and effective area.
- **Pin:** the simple point-load beam screen depends strongly on assumed effective span: 40.6 mm rail-center spacing gives 152.49 MPa at 1× and 457.47 MPa at 3×; using a 90.3 mm whole-pin span gives 339.16 MPa at 1×, 678.31 MPa at 2× and 1,017.47 MPa at 3×. The 2× estimate is within about 6.4% of the 725 MPa candidate H1150D proof reference, and the 3× estimate exceeds it. The true support/load distribution is unresolved; neither is a validated pin stress. This is a material comparison, not a design allowable or fatigue limit, and it remains a release blocker pending a justified load path/material analysis.

No compatible FEA solver/workflow was found or run in this environment. No material-specific 3D FEA, mesh convergence/contact analysis, tolerance/strain simulation, pressure/leak/burst test, static proof load, impact/fatigue cycle, pin/ring retention test, outsole bond/slip test, sewn upper fit test, or human-wear test was performed. The CSV/JSON load screen records all scenarios and limitations at `revision/verification_results/revR1_fresh_validation/`. The latest live rerun evidence is stored under `revision/verification_results/revR1_fresh_validation/live_audit/`.

## Release decision

**Digital source/mesh checks: PASS, including fresh R1.2 reruns of 24/24 interface CSG and 6/6 rail-stop CSG tests. Structural qualification and human wear: NOT CLEARED.** Keep the shoe non-wearable until the production material/process and exact hardware are fixed, the load/contact path is independently analyzed with approved allowables, the bladder/circuit has rated hardware and fail-safe dump behavior, and appropriate guarded physical proof/fatigue/fit/traction tests pass.

Reproduce the validation with the source scripts under `revision/tools/`; the current report and machine-readable QA summary are `REV_R1_FRESH_VALIDATION_REPORT.md` and `revision/verification_results/revR1_fresh_validation/REV_R1_FRESH_VALIDATION_QA.json`.
