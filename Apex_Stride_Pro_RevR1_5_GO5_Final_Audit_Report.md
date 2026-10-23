# Apex Stride Pro — Rev R1.5 GO5 independent final audit

**Status:** Digital geometry regression passed; structural qualification remains **OPEN**. This freeze is bound to `revision/Apex_Stride_Pro_RevR.scad` SHA-256 `664f2858f85ac5eba0be335d8d0e89a64b769ca5985a37d5bf286ad4aa19d5c0`. The standalone corrected source and print-preparation source are byte-identical to it. This is not a manufacturing release and is not approved for human wear.

## GO5 conclusion

The independent final audit found and corrected a stale cross-document interface entry: the live fastener/interface schedule had retained a 1.8 mm default outsole skin and a 5.5 mm roof entry from an earlier revision even though R1.5 CAD uses a 2.5 mm standard tread skin and 10.1 mm nominal heel/forefoot roof. The active schedule now agrees with the live source. The GO5 pass also refreshed all QA labels and hashes against the final native-source hash, regenerated exports, and refreshed the active checksum manifest.

## Final-source test matrix

| Test | Fresh result | What this establishes |
|---|---:|---|
| Source/package/document regression | 130/130 PASS | Source and package invariants, selectors, file map/BOM references, export assumptions; helper script has legacy revision title but run is bound to the hash above |
| Heel-core cavity probes | 9/9 PASS | Cavity open/continuous geometry for EU42/EU44/EU46 and toggle variants |
| Kinematic/registration sweep | 61 positions; 250/250 arithmetic checks PASS | Nominal source-coordinate arithmetic; not tolerance or dynamic simulation |
| Rail/end-stop solid intersections | 6/6 PASS | No positive-volume CSG interference at tested configurations; not clearance under manufacturing tolerances |
| Bridge/fastener interface CSG | 18/18 PASS | Nominal screw-envelope and coordinate tests |
| Lock-tip/deck relief CSG | 4/4 PASS | Nominal CAD cylinder/deck clearance; actual threads, hardware and tolerances remain unverified |
| Fresh primary fit-kit exports | 42/42 PASS | Current-source EU42/EU44/EU46 fit-kit meshes |
| Fresh optional outsole-study exports | 9/9 PASS | Three optional components × three sizes; study remains experimental |
| Active mesh topology/geometry audit | 72/72 PASS after in-memory weld | 42 fit-kit + 21 upper concepts + 9 optional outsole meshes; not a physical strength test |
| Fresh native mass exports | 24/24 PASS | Geometry-derived mass estimates using assumed densities, not measured finished-shoe mass |

The raw STL files encode repeated vertices per triangle, so direct raw-facet imports did not report watertightness. The audit welded duplicate vertices and removed duplicate/degenerate faces **in an in-memory analysis copy only**; it did not rewrite the shipped STL files. The audit confirms topology under that interpretation, not slicer toolpath acceptance or manufacturing quality.

## Current geometry and estimated mass

The default outsole remains **4.0 mm external thickness**, with **1.5 mm mechanism relief** and **2.5 mm nominal residual tread skin**. The optional 3.2 mm outsole study retains **1.8 mm skin** and is not approved for wear. The heel cavity is nominally 55 × 23 × 10.5 mm with a 10.1 mm roof and 2.5 mm side web to the rail-channel envelope. These are geometric dimensions, not structural allowables.

| Size | Modeled chassis + pin | Outsole mass at assumed 1.20 g/cm³ | Modeled lower-platform subtotal |
|---|---:|---:|---:|
| EU42 | 504.199 g | 95.007 g | 599.206 g |
| EU44 | 504.199 g | 99.157 g | 603.356 g |
| EU46 | 504.199 g | 103.308 g | 607.507 g |

The subtotals exclude footbed, actual retaining ring, production fasteners, upper, spring, pneumatic bladder/tubing/fittings/regulator, adhesives and other hardware. Tread density is a placeholder; these are not measured weights.

## Recalculated 66 kg load and pressure screen

For 66 kg, one-shoe static gravitational force is `66 × 9.81 = 647.46 N`. The 1×/1.5×/2×/3× force levels are analyst-selected sensitivity cases, not a measured gait load history or standard-required load spectrum. The current 27 × 22 mm nominal bladder projection is 594 mm²; assigning the entire static load to this area requires **1.09 MPa**. At 0.40 MPa ideal pressure, calculated force assist is 237.6 N; at the provisional 0.50 MPa relief set target it is 297 N. The mechanical chassis must carry the full load when pressure is zero; the design must not rely on the bladder for structural support.

### Manufacturer ranges independently checked

- SMC AP20-D standard relief set-pressure range is **0.05–0.8 MPa**; its alternate low-range option is 0.02–0.2 MPa. Official references: [SMC AP20-D official catalog listing](https://www.smc.com.cn/webcatalog/en-ae/modular-frl-units-pressure-control-equipment/regulators/AP20-D-E) and [AP20-D datasheet](https://static.smc.eu/pdf/AP20-D-A_EU.pdf).
- SMC ARX20 standard model regulating-pressure range is **0.05–0.85 MPa**, with standard/low-pressure variants in its catalog. Official references: [SMC ARX20 catalog PDF](https://static.smc.eu/pdf/ARX20-A_EU.pdf) and [SMC ARX20 series listing](https://www.smc.com.cn/webcatalog/en-ae/seriesList/?id=ARX-E&type=GUIDE).
- SMC KQ2 family information lists pressure up to 1 MPa: [SMC KQ2 fitting family](https://www.smcusa.com/products/connectors/fittings/one-touch-fittings/kq2-new-series/tube-to-tube~177557).
- Materialise's published PA 12 SLS material card gives density 0.95 g/cm³, tensile strength 48 MPa, tensile modulus 1,650 MPa, flexural strength 41 MPa and flexural modulus 1,500 MPa, and notes dependence on build, geometry and orientation: [Materialise PA 12 SLS](https://www.materialise.com/en/industrial/3d-printing-materials/pa12-sls).
- SMC tube rating conflict for T0425: the older [SMC Tubing.pdf](https://static.smc.eu/pdf/Tubing.pdf) states 1.5 MPa at 20 °C, while the newer [SMC EU T-series catalog](https://static.smc.eu/pdf/PPE-Gg_EU.pdf) lists 3.3 MPa at ≤20 °C, 2.3 MPa at 40 °C, and 1.65 MPa at 60 °C. These values are not silently reconciled; exact tube/document applicability and temperature derating must be confirmed with SMC. The screen keeps 1.5 MPa only as a conservative provisional input.

These product-family ranges show that the planning targets are within nominal adjustment ranges; they do not select the final order codes or establish safe system behavior. The T0425 tubing documents conflict on its 20 °C maximum operating rating, so the 1.5 MPa value is conservative planning only until SMC confirms the correct catalog/revision for the supplied tube. **Still unverified:** tubing rating/temperature derating; AP20-D exact order code/thread/options; relief flow and overshoot at the actual chamber volume; bladder manufacturer pressure/burst/cycle rating; pressure loss behavior; and fail-safe state. No pneumatic system should be pressurized until these are resolved and checked on a guarded test rig.

## Structural sensitivities and hard blockers

At the 3× analyst sensitivity load (1,942.38 N), the simplified solid 8 mm pin screen between 40.6 mm support centers gives about **392 MPa**. The severe fault assumption of 90.3 mm unsupported span at 7.6 mm groove root gives about **1,017 MPa**, above the 725 MPa candidate proof-strength reference for the proposed 17-4PH heat-treatment state. The latter is a hypothetical fault-load sensitivity, not normal pin operation; the actual axial locking force, bearing distribution, groove/ring retention and impact/fatigue loads are still undefined. The pin remains unqualified.

The simplified 20 mm-wide, 23 mm-span heel-roof strip at 3× load gives about **32.85 MPa** and 0.191 mm deflection. The forefoot short-strip sensitivity is about **16.07 MPa** for a 9 mm span/16 mm width. These strip models do not reproduce the real plate, ribs, contact patches, stress concentrations, material anisotropy or boundary conditions. Published flexural strength is not a design allowable. **No material-specific FEA was run** because a compatible solver was unavailable; no physical proof-load or durability test has been performed.

Other open items: the exact M4×22 rear-anchor and M4×14 lock fastener SKUs/grades remain unsourced; bridge cap and joint strength/preload/fatigue are not qualified; outsole compound, attachment/bondline, grip, tear, flex, abrasion and fatigue remain untested; actual footbed/tread material densities and manufactured tolerances are not selected.

## GO5 release state

**GO5 audit:** current-source checks and package-integrity rebuild passed, with the limits above. **Design freeze means source consistency only; it does not mean structural qualification or approval for wear.** Do not wear, body-load or pressurize this prototype before the open engineering and guarded physical-validation gates are closed.
