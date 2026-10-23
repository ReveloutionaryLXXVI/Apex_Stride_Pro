# Apex Stride Pro — Rev R1.5 GO 3 + GO 4 Full Audit

**Status:** digitally checked engineering candidate; **not a manufacturing release and not approved for human wear**. This report is bound to native CAD SHA-256 `43a706db3ba6ce2e7d012914409b26862a64dc2da722e90b0a0b8b0ed63f7a5c` for `revision/Apex_Stride_Pro_RevR.scad`. The print-preparation CAD and standalone corrected source were checked byte-identical to that source.

## Executive result

GO 3 and GO 4 were completed as far as the available CAD and analytical tools support. The actual standard outsole CAD was changed so the nominal residual tread skin increases from **1.8 mm to 2.5 mm**, while the external outsole thickness stays **4.0 mm**. The optional 3.2 mm lightweight study remains unchanged at **1.8 mm skin** and is still marked experimental/not approved for wear. All 42 standard fit-kit meshes were freshly re-exported from R1.5; all nine optional study meshes were also freshly re-exported. A fresh audit of all 72 active STL meshes passed after in-memory topology cleanup.

The correction is real but limited: it improves nominal geometry, not traction, material strength, adhesive bonding, tear, abrasion, or fatigue life. The pin, bridge, heel/forefoot chassis and pneumatic load path remain analytically screened, not structurally qualified.

## GO 3 — structural and pneumatic screening

### Body-load cases

For the requested 66 kg load, the one-shoe static gravitational force is:

`66 kg × 9.81 m/s² = 647.46 N`.

The 1×, 1.5×, 2× and 3× cases (647.46, 971.19, 1,294.92 and 1,942.38 N) are transparent analyst-selected sensitivities—not measured gait peaks and not a standards-defined load spectrum. With pressure at zero, the chassis must support the full load in each case. The current bladder envelope is 27 × 22 mm (594 mm² nominal projected area); assigning the entire static force to it gives **1.09 MPa**, higher than the SMC KQ2 family’s published 1 MPa operating pressure. The current provisional 0.50 MPa relief target would yield only 297 N ideal static assistance, leaving 350.46 N for the chassis at 1×, but pressure assistance must not be credited when sizing the mechanical load path.

The selected AP20-D relief and ARX20 regulator variants are not ordered. The numeric maximum relief-set and regulator-output values in the CAD are now explicitly labeled **planning assumptions, not verified product limits**: SMC’s AP20-D page says it relieves pressure spikes and exposes a selectable set-pressure configuration, but the exact selected configuration/flow and setting range need confirmation; the ARX20 page confirms compatible primary supply pressure, not the assumed maximum output range. The R1.5 screen therefore marks those two product selection items **UNVERIFIED**, not passed. Do not commission the circuit until exact SKUs, allowable pressures, relief flow, pressure overshoot and pressure-loss behavior are established.

### Pin, rail and bridge sensitivities

At the 3× sensitivity load, a simplified point-load beam model gives about **392 MPa** for a solid 8 mm pin between rail support centerlines 40.6 mm apart. The severe fault sensitivity using a 90.3 mm unsupported span at the 7.6 mm groove root gives about **1,017 MPa**, above the 725 MPa proof-strength reference used for a candidate 17-4PH H1150D pin. This unsupported-span case is not normal operation—the pin is intended as an axial adjustment lock, not a vertical chassis member—but it shows that losing rail bearing support or misrouting force cannot be ignored. The true axial lock load, pin contact, groove/ring retention, material condition, fatigue and impact loads remain unspecified; the pin has not been qualified.

For the revised 4.5 mm bridge strap and 2.2 mm-deep screw-head recess, nominal cap thickness is 2.3 mm. The separated/staggered recesses have a nominal edge gap of 2.87 mm; coordinate and CSG checks previously passed for the current geometry. At 3× load, assigning the full one-shoe force through a single net-cap section produces a simple nominal axial screen of about 55.9 MPa and 111.9 MPa with an arbitrary ×2 concentration sensitivity. These are not allowable stresses or a validated notch factor, and do not include fastener preload, eccentric bending, bearing, fatigue or actual contact distribution. The exact M4×22 rear-anchor and M4×14 lock screw SKUs are still TBD.

### Heel and forefoot roof sensitivity

The heel roof remains 10.1 mm and the forefoot pocket roof remains 10.1 mm with a 5 mm central web. An intentionally crude 20 mm-wide, simply-supported 23 mm-span roof-strip model at 3× load gives approximately **32.85 MPa** and **0.191 mm** midspan deflection for the heel strip. The Materialise PA 12 SLS published card lists 41 MPa flexural strength and 1,500 MPa flexural modulus, but Materialise explicitly states actual results may vary with build conditions and part geometry/orientation. A 32.85 MPa beam-strip estimate is not an adequate safety margin or a prediction of the actual deck stress: the plate/rib geometry, actual load footprint, contact, print orientation, conditioned material properties and stress concentrations are absent. The forefoot short-strip sensitivity is about 16.07 MPa at 3× under its stated 9 mm span/16 mm width assumption. Material-specific structural analysis and physical proof testing remain mandatory.

## GO 4 — integrated geometry and export verification

| Check | Result | Scope/qualification |
|---|---:|---|
| Prior source/package test suite | 130/130 PASS on geometry-identical R1.5 source before comment-only pneumatic parameter clarifications | Repeat attempt after comments timed out; final source was separately compiled during fresh exports of all selectors |
| Continuous heel-cavity checks | 9/9 PASS | Native OpenSCAD probes for EU42/EU44/EU46 and toggles |
| Adjustment positions/arithmetic | 61 positions, 250/250 checks PASS | Nominal geometry only; no tolerance, material or dynamic simulation |
| Rail/stop solid intersection | 6/6 PASS on the R1.5 geometry before comment-only parameter-label changes | A later combined replay timed out; note geometry was unchanged by those comment-only edits |
| Bridge/fastener interface CSG | 18/18 PASS | Nominal screw-envelope and coordinate checks; no strength conclusion |
| Lock-tip/deck CSG | 4/4 PASS | Nominal geometry only |
| Standard fit-kit meshes fresh exported | 42/42 PASS | Size variants EU42/EU44/EU46; normalized orientation, 220 × 220 mm XY envelope, volume/finite geometry checks |
| Optional outsole study meshes fresh exported | 9/9 PASS | Three components × three sizes; remains experimental, not for wear |
| Full active STL audit | 72/72 pass after topology processing | 42 fit-kit + 21 upper concepts + 9 optional studies; raw unprocessed imports had coincident duplicate vertices, so they were not watertight before welding in the audit copy. Delivered STL bytes were not modified by the audit itself |
| Standard/optional tread skin | 2.5 mm / 1.8 mm | CAD geometry measurements only |
| Latest source/print-prep/standalone parity | Byte-identical | SHA-256 in report header |

A fresh 130-test regression replay timed out after the independent source edits to two comments clarifying product-rating uncertainty; because those edits did not affect geometry, the earlier R1.5 geometric results remain applicable, and all 42 standard plus nine optional selectors were freshly compiled/exported against the final source hash. The final report does not claim the timed-out replay completed.

## R1.5 modeled mass sensitivity

| Size | Chassis + pin candidate estimate | Outsole aggregate volume | Outsole mass at assumed 1.20 g/cm³ | Modeled lower platform total |
|---|---:|---:|---:|---:|
| EU42 | 504.199 g | 79,172.629 mm³ | 95.007 g | 599.206 g |
| EU44 | 504.199 g | 82,631.155 mm³ | 99.157 g | 603.356 g |
| EU46 | 504.199 g | 86,089.626 mm³ | 103.308 g | 607.507 g |

These are geometry-derived estimates, not measured weights. The outsole mass uses a placeholder 1.20 g/cm³ because no tread compound was selected. The platform subtotal excludes footbed mass (density not selected), the actual retaining ring, production fasteners, upper, spring, pneumatic bladder/tubing/fittings/regulator, adhesive, and other hardware. Relative to the R1.4 modeled totals, the local outsole skin change adds approximately 4.107 g / 4.372 g / 4.638 g by size under that placeholder density assumption.

## Technical sources and their limits

- Materialise, [PA 12 (SLS) for laser sintering](https://www.materialise.com/en/industrial/3d-printing-materials/pa12-sls): published 0.95 g/cm³ density, 48 MPa tensile strength, 1,650 MPa tensile modulus, 41 MPa flexural strength, and 1,500 MPa flexural modulus. The supplier notes that actual results vary with build conditions, geometry and orientation. These values are not an allowable-stress certificate for this part.
- SMC, [KQ2 one-touch fittings](https://www.smcusa.com/products/connectors/fittings/one-touch-fittings/kq2-new-series/tube-to-tube~177557): published pressure range up to 1 MPa; exact fitting SKU and transient rating still need confirmation.
- SMC, [AP20-D modular relief valve](https://www.smcusa.com/products/ap20-d-modular-type-relief-valve~178371): describes relief of line pressure/spikes and a configurable set-pressure choice; exact selected setting range, flow capacity and final SKU remain unverified.
- SMC, [ARX20 piston regulator](https://www.smcusa.com/products/airline-equipment/pressure-regulators/air-regulators/arx20~15886): confirms up to 2.0 MPa primary supply compatibility; it does not verify the 0.85 MPa assumed maximum output used as a planning parameter. The exact output variant remains TBD.

## Release conclusion

**Digital GO 3/GO 4 status: geometry/export regression passed within the limitations above. Structural qualification: OPEN.** No suitable FEA solver was available, so no FEA was run. No physical static/proof load, impact, pin retention, fatigue, pressure-relief flow/overshoot, pressure-loss, outsole traction/abrasion/tear/bonding, or human fit/wear tests were conducted. Do not wear or body-load this CAD/mockup release. GO 5 must close the unresolved material-specific structural analysis, exact fastener/pneumatic SKUs, and a guarded physical test plan before manufacturing release.
