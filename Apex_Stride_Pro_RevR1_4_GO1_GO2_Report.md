# Apex Stride Pro — Rev R1.4 GO 1 + GO 2 structural-load-path and joint redesign

**Status:** digital design revision and analytical screening only. This is not a manufacturing release and is not cleared for human wear. GO 1 defines the intended load path and load cases; GO 2 makes coordinated changes to the bridge joint and screws. No physical qualification or material-specific FEA was available in this environment.

## GO 1 — Intended load path and governing cases

The pneumatic bladder is now explicitly auxiliary; it is not credited as a structural body-load member. The chassis must support load with zero pressure. The intended vertical path is foot/footbed → heel/toe deck and captured mechanical interfaces → outsole/ground contacts. Across the adjustable heel/toe split, longitudinal adjustment loads are resisted by the overlapping bridge straps and their two indexed lock fasteners; the captured T rails constrain deck separation and guide sliding; the transverse pin is the axial position lock and must not be treated as the sole vertical support. This intended path still requires physical load-path confirmation.

For 66 kg at 9.81 m/s², one-foot static force is **647.46 N**; ideal bilateral static share is **323.73 N per foot**. The 1.5×, 2× and 3× values (**971.19, 1,294.92 and 1,942.38 N**) are analyst-selected sensitivity levels, not measured gait forces or claimed standards. Final qualification loads must be selected by the responsible engineer for the intended use. The zero-pressure case carries the full chosen external load through the mechanical structure.

The target bladder footprint is 27×22 mm = 594 mm². The idealized bladder-only pressure demand is 1.090 MPa at 1×, 2.180 MPa at 2× and 3.270 MPa at 3×. At the provisional 0.50 MPa relief target, maximum ideal force is 297 N, leaving 350.46 N of chassis support at 1×, 997.92 N at 2×, and 1,645.38 N at 3×. Actual bladder effective area and force sharing are unverified. Set load-bearing calculations to zero pressure; do not use pressure as a safety margin.

## GO 2 — Implemented bridge and fastener revision

- Both machined-metal candidate straps are **23×4.5 mm**; the recessed stack is **9.0 mm** (two layers), matched to the CAD underside pocket depth. Printed STLs remain fit gauges only.
- Button-head counterbores remain Ø7.9×2.2 mm; remaining strap cap is now **2.3 mm**, up from 0.8 mm. This removes the obvious thin-cap geometry defect but is not an allowable.
- Paired fasteners are staggered ±2.0 mm in X at y=±5 mm. Center separation is sqrt(4²+10²)=10.770 mm, giving **2.870 mm nominal edge gap** between Ø7.9 mm head recesses instead of aligned overlapping sections. The same stagger is applied to the deck through-holes, nut pockets and both strap layers.
- Rear fixed anchors: M4×22 mm under-head length (supplier/SKU unselected); estimated tip z=+1.4 mm into the pre-existing footbed lap pocket. The old M4×18 candidate is rejected for engagement.
- Moving toe anchors remain M4×16 mm under-head length; on the revised bearing plane z=−16.1 mm, the nominal tip is z=−0.1 mm and footbed underside z=+0.15 mm, yielding **0.25 mm nominal clearance**. The obsolete EVA tip reliefs were removed.
- Indexed bridge locks: M4×14 mm under-head length (supplier/SKU unselected). The 3.2 mm nut is fully engaged; nominal tip projection above its pocket is 1.55 mm into a 1.65 mm Ø4.8 mm tip relief, leaving 0.10 mm nominal axial clearance.
- Assertions prevent strap-cap thickness, stack-depth mismatch, screw-pair head-envelope overlap, inadequate stagger and insufficient lock-tip relief from regressing silently.
- Rail/pin geometry was kept unchanged: the pin is a custom Ø8 mm shaft with Ø7.6×0.9 mm retaining-ring groove and size-8 external clip. It is not an off-the-shelf pin drawing. The prior “90 mm free beam” screen is not the intended normal load path: the rail bores support the pin at ±20.3 mm. Nonetheless, if rail support is lost or body load bears on the pin, bending/impact can be severe. The cross-pin requires material certificate, dimensional drawing, retention/fatigue analysis and physical testing.

## Independent screening arithmetic

The pair of strap recesses has a staggered section; a simple net-cap area estimate at one recess is (23−7.9)×(4.5−2.2)=**34.73 mm²**. If the full one-foot 3× sensitivity load of 1,942.38 N were assigned as pure axial force to one critical cap section, average net-section stress would be **55.9 MPa**; a hypothetical stress-concentration multiplier of 2 yields **111.9 MPa**. This is only a sensitivity, not a validated force direction, actual stress field, fatigue allowable, or joint proof. The 6061-T6 strength figure is not used as a certified design allowable. The hardware product/SKU and actual metal material/temper are still unselected.

For the cross-pin, two rail bearing centerlines are ±20.3 mm (40.6 mm support-center span), while the carriage side passage is 90 mm. A hypothetical simply-supported midspan point load on the Ø8 mm portion over 40.6 mm gives bending stress of about **392 MPa at 3×** the 66 kg force; treating the pin as a 90.3 mm unsupported beam at the Ø7.6 mm groove root gives about **1,018 MPa at 3×**. The latter is a fault/sensitivity case, not the nominal supported geometry. The rail and pin loads in operation are not yet measured, and these calculations do not validate yield, fatigue, impact, ring retention, or rail-hole bearing.

Conditional 3× direct-shear screens, if the entire 1,942.38 N were placed on the pin, give average double-shear stress ≈21.4 MPa (Ø7.6 mm root area, two planes), per-rail projected bearing stress ≈11.6 MPa (half load over 7.6×11 mm), and a simple rail-edge tear-out average ≈16.1 MPa using 2.75 mm vertical ligament and 11 mm bearing length. This does not establish a design allowable and excludes notch factors, shock, wear, tolerance and cyclic load.

## GO 1/2 test status

- OpenSCAD native compilation: core and interface selectors compiled successfully with the revised assertions.
- Fit-kit regeneration: 42/42 parts freshly exported; both bridge strap mesh envelopes are 130×23×4.5 mm and 85×23×4.5 mm, watertight and finite.
- Remaining regression results are recorded in `revision/verification_results/revR1_4_go1_go2/`; report only fresh runs as fresh passes.
- This is not FEA. No suitable solver was available; no physical loading was run. No human wear is allowed based on these results.

## Remaining gates after GO 1 + GO 2

1. Confirm exact M4×22 and M4×14 fastener SKUs/grades and actual thread length, head profile, nut lot, torque and anti-loosening. Those SKUs are currently **TBD**, so the revised stack is geometrically compatible but not procurement-closed.
2. Obtain certified material/process data for PA12 SLS chassis and certified 6061-T6 bridge/rails; update allowables for print orientation, lot, holes and fatigue.
3. Run material-specific FEA / independent hand analysis with realistic contacts and load cases; follow with guarded proof, impact, cyclic locking, pressure-loss, outsole and retention tests.
4. Verify the assembled shoe physically in each size; fit STLs/geometry checks do not qualify production hardware.
