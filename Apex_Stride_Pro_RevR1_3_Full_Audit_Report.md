# Apex Stride Pro — Rev R1.3 full independent audit

**Audit date:** 2026-10-16  
**Disposition:** digitally validated geometry package; **NOT CLEARED FOR HUMAN WEAR**. This is not a manufacturing/safety certification.

## Executive findings

The delivered R1.2 source had eight forefoot underside lightening pockets with a **5.5 mm roof** and only a **1 mm center web** between pocket rows. Rev R1.3 changes the real CAD boolean cutters to a **10.1 mm roof**, **9 mm pocket width**, and **5 mm center web**, while keeping the exterior sole thickness at 20.6 mm and the default outsole at 4.0 mm. The native toe-carriage mesh was regenerated for all three nominal sizes. This adds approximately **8.1821 g per toe deck** at the 0.95 g/cm³ PA12 density assumption; the change is a geometry/stiffness-sensitivity improvement, not a strength proof.

The revision adds CAD assertions for the minimum forefoot roof, center-web geometry, and nominal final-index-hole to stop-lug separation. The previous rail length (155 mm) and slot length (90 mm) are retained. An exploratory rail extension was rejected after it caused a degenerate end-contact CSG result; the source and mesh set contain no such extension. The final exact rail/stop intersection suite passes **6/6**.

## Fresh verification results

| Verification | Result | Scope / limitation |
|---|---:|---|
| Source/package regression | **130/130 PASS** | OpenSCAD compile/parameter/source checks and package consistency; no structural proof |
| Core cavity | **9/9 PASS** | EU42/EU44/EU46 and lightening-toggle geometry probes; 55×23×10.5 mm cavity, 10.1 mm roof, 2.5 mm nominal web to rail channel |
| Adjustment sweep | **61 positions / 250 checks PASS** | Nominal coordinate arithmetic, rail engagement, bridge overlap and three indexed settings; no tolerance/deformation model |
| Rail/stop CSG | **6/6 PASS** | Positive-volume intersection checks for both rails at three sizes |
| Screw/EVA/bridge interfaces | **24/24 PASS** | Nominal cylindrical envelopes at both sides and all three indexed sizes; no tolerance stack or physical gauging |
| Fresh fit-kit exports | **42/42 PASS** | Native OpenSCAD export plus watertightness, winding, dimensions and bed checks |
| All active STL meshes | **72/72 PASS** | 42 fit parts + 21 upper concept meshes + 9 optional outsole studies; mesh integrity only |
| Fit-part index reconciliation | **42/42 PASS** | Stored extents and volumes agree with active meshes |
| Assembly map | **72 rows; 0 missing references** | Path resolution only |
| Native mass estimate | **24/24 component-size exports PASS** | Eight modeled components for each of EU42/EU44/EU46; density estimates, not measured mass |
| Source parity | **3/3 exact match** | Standalone source, authoritative CAD and print-prep CAD have identical bytes |

## Rev R1.3 geometry corrections

### 1. Forefoot roof and web

The old geometry made each pocket 16×11 mm in plan and cut its top to z=−5.5 mm. Rev R1.3 keeps the four longitudinal stations at x=74, 94, 114 and 134 mm but narrows each of the two transverse pocket rows to 9 mm, leaves a 5 mm central web, and places the pocket roof at z=−10.1 mm. The external deck/sole remains 20.6 mm thick. CAD assertions require a roof ≥10.0 mm, a center web ≥5.0 mm, and 2×pocket-width + web = 23 mm.

A simple one-way strip sensitivity using the same 16 mm longitudinal cell length and the deliberately severe assumption that the *entire* single-support force acts on one pocket gives about **22.07 MPa** for the old 5.5×11 mm case and **5.36 MPa** for the new 10.1×9 mm case at 1×; at 2× these scale to 44.15 and 10.71 MPa. The apparent ~4.12× reduction is comparative only. This load placement is intentionally not a realistic load field, the roof is a thick plate rather than an ideal thin strip, and the material's 41 MPa flexural-strength figure is not a design allowable. These values are not a failure prediction or safety factor.

### 2. Keep the pin/rail stop geometry tied to source coordinates

The final source coordinates give `rail_start_x = −90 mm`, `rail_end_x = 65 mm`, rail length 155 mm, and `slot_length = 90 mm`. The EU46 final index-hole center is `heel_split_x + 30 + 4×6.6667 = 31.6668 mm`, not 58.333 mm. With a Ø8.3 mm hole, its +X edge is 35.8168 mm while the lug leading face starts at 62 mm; the nominal X separation is **26.1832 mm**. A CAD assertion prevents this source-coordinate clearance from falling below 0.5 mm. Exact rail/stop CSG also passes 6/6; no rail-length change was retained.

## Independent 66 kg load and component screens

- Weight force: 66 kg × 9.81 m/s² = **647.46 N**. Equal two-foot static share is 323.73 N; one-foot static and the 1.5×/2×/3× cases below are sensitivity cases, not measured gait loads or acceptance factors.
- The 27×22 mm target bladder rectangle is **594 mm²**. If the bladder alone carried 647.46 N, the idealized demand would be **1.090 MPa**; 2× and 3× become 2.180 and 3.270 MPa. These exceed the candidate fitting's 1.0 MPa maximum working rating, even before allowance for effective area smaller than the body rectangle.
- At the provisional 0.40 MPa working / 0.50 MPa relief targets, nominal bladder force is just **237.6 N / 297 N**. The chassis must carry at least 350.46 N at 1× and 997.92 N at 2× with nominal relief active, and the **full external load if the circuit loses pressure**. The pressure targets are not approved for use; the custom bladder has no confirmed OEM working/burst/cycle rating, and relief transient/overshoot has not been measured.
- Heel-core roof: 10.1 mm, cavity 55×23×10.5 mm, nominal side web to rail channel 2.5 mm. One-way strip stress sensitivities are included in `REV_R1_3_STRUCTURAL_SCREEN.csv`; they are not 3D FEA or design allowables.
- Rail index holes: nominal top/bottom head ligament **2.75 mm** from (16.1−2.3−8.3)/2; the source asserts ≥2.7 mm. This does not resolve bearing, tear-out, fatigue, material condition or manufacturing tolerances.
- Pin: a point-load beam screen using Ø7.6 mm groove-root diameter gives **678 MPa** at 2× and **1,017 MPa** at 3× over an assumed 90.3 mm span, compared with a 725 MPa candidate H1150D proof-strength reference. This full-span condition may not be the actual load path, but it is a serious conditional hold point; actual pin/rail/chassis load sharing must be established rather than assuming the pin is safe.
- Bridge strap counterbore: 3.0 mm strap minus 2.2 mm head pocket leaves **0.8 mm** of material behind the head pocket. This joint has not been strength/preload qualified and remains a hold point; changing stack height or screw length without a full interface redesign would create new compatibility risks.
- Outsole mechanism relief leaves a nominal **1.8 mm tread skin** in a 4.0 mm pad. Tear, abrasion, traction and bonding still require physical testing.

## Mass estimate (geometry-derived; not finished-shoe mass)

| Size | Modeled rigid chassis + locking pin | Outsole at placeholder 1.20 g/cm³ | Modeled lower platform subtotal |
|---|---:|---:|---:|
| EU42 | 493.135 g | 90.900 g | 584.035 g |
| EU44 | 493.135 g | 94.785 g | 587.920 g |
| EU46 | 493.135 g | 98.670 g | 591.804 g |

The model excludes footbed mass (EVA density/grade not selected), actual retaining ring, all production fasteners, upper, spring, bladder, tubing/valves/regulator and adhesives. The outsole density is only a placeholder; no finished-shoe weight has been measured.

## Engineering limitations and release gates

No compatible 3D FEA solver/workflow was found in the available environment (checked `ccx`, CalculiX, Gmsh, FreeCAD, Abaqus, Code_Aster and Python FEA modules); **no material-specific FEA was run**. No physical static/eccentric proof load, fatigue, impact, pin/retaining-ring retention, pneumatic pressure/leak/relief transient, outsole traction/tear/bond, sewn-upper retention, or human wear testing was performed. Actual manufactured material properties and tolerances remain unqualified. The current package is only a corrected non-wearable engineering/fit kit.

**Do not wear or body-load this design.** Clear it only after supplier drawings/rating closure, material-specific structural analysis with a resolved load path, independent engineering review, and guarded physical qualification. The 130/130 CAD/package checks do not prove strength or safety.

## Reference material notes

- Materialise PA12 SLS material card: https://www.materialise.com/en/industrial/3d-printing-materials/pa12-sls (published candidate properties; actual process/orientation/conditioning matters).
- SMC KQ2 fitting catalog: https://static.smc.eu/pdf/KQ2-Dd_EU.pdf (candidate max operating pressure reference; actual ordered variant must be confirmed).
- 17-4PH reference material information: https://www.langleyalloys.com/materials/stainless/17-4-ph/ (candidate condition reference only; pin lot/product not selected).
- Würth ISO 7380-1 M4 button-head data: https://eshop.wurth.ae/Product-categories/ISO-7380-1-stainless-steel-A4-plain/38903511180204.cyid/3890.cgid/en/US/AED/ (nominal head dimensions and manufacturer limited-load note; selected fastener/joint must be reviewed).
