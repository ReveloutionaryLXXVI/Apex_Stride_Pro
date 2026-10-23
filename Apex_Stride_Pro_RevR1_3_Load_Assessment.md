# Apex Stride Pro Rev R1.3 — 66 kg structural/load-path screen

**Result: NOT CLEARED FOR HUMAN WEAR.** This is source-derived calculation/sensitivity only, not finite-element analysis, a design allowable, or a physical test.

## Load arithmetic

- 66×9.81 = **647.46 N** total gravitational force.
- Ideal equal bilateral static share = **323.73 N/foot**.
- Single-support static scenario = **647.46 N**. Multipliers 1.5×, 2× and 3× are analyst-selected sensitivities; they are not measured running/gait forces or proof factors.

## Pneumatic envelope

The target bladder body is 27×22×9 mm. The projected rectangle (594 mm²) is only a first-pass area proxy; the OEM's effective pressure area may be smaller.

| Case | Force | Bladder-only pressure demand on 594 mm² |
|---|---:|---:|
| Equal bilateral static share | 323.73 N | 0.545 MPa |
| One-foot static | 647.46 N | 1.090 MPa |
| 1.5× | 971.19 N | 1.635 MPa |
| 2× | 1,294.92 N | 2.180 MPa |
| 3× | 1,942.38 N | 3.270 MPa |

The 1× case already exceeds the candidate KQ2 fitting's 1.0 MPa maximum operating rating if the bladder is treated as the sole support. This is why the circuit is modeled only as auxiliary assistance: 0.40 MPa yields 237.6 N ideal nominal force; 0.50 MPa yields 297 N. The chassis still has to carry at least 350.46 N at 1×, 997.92 N at 2× and 1,645.38 N at 3× while at nominal relief pressure—and the full load when depressurized. The custom bladder rating, effective area, pressure transients, relief performance and leakage/failsafe remain unqualified.

## Geometry updates in R1.3

The forefoot pocket roof changed from 5.5 mm to 10.1 mm, pocket width from 11 mm to 9 mm, and inter-row center web from 1 mm to 5 mm. The same simple single-cell strip stress sensitivity drops from 22.07 MPa to 5.36 MPa at 1× and from 44.15 MPa to 10.71 MPa at 2×. Entire foot load on a single cell is deliberately severe and not a real load field; it shows a relative geometric change only. The Materialise 41 MPa flexural strength is a material reference, not a design allowable.

The heel-core roof remains 10.1 mm over a 55×23×10.5 mm underside cavity, with a 2.5 mm nominal rail-channel side web. Pin beam sensitivity over the assumed 90.3 mm span is 678 MPa at 2× and 1,017 MPa at 3× at the 7.6 mm groove root, compared with a 725 MPa candidate H1150D proof reference. The actual pin load path has not been resolved, so this is a critical hold point, not a prediction that the pin will necessarily experience that stress.

## Other critical dimensions/risks

- Rail index-hole nominal top/bottom ligament: 2.75 mm; assert ≥2.7 mm. Tear-out, bearing, fatigue and tolerance stack are untested.
- Bridge head counterbore leaves 0.8 mm cap in 3 mm nominal strap; joint preload/strength needs analysis and physical testing.
- Outsole relief leaves 1.8 mm tread skin; traction, tear, abrasion and adhesive bond need tests.
- No 3D FEA solver was available. No physical proof-load, fatigue, pressure/leak, relief-transient, outsole or wearer test has occurred.

See `REV_R1_3_FULL_AUDIT_REPORT.md`, `REV_R1_3_STRUCTURAL_SCREEN.csv` and `.json` for the full load multipliers and component calculations.
