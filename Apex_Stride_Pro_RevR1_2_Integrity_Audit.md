# Apex Stride Pro Rev R1.2 — live integrity and regression audit

**Audit date:** 2026-10-16
**Source checked:** `revision/Apex_Stride_Pro_RevR.scad` (SHA-256 `305f5dd75992d3b680885d64c8b7a4d754ed39ddc4296fb962d43e794fdcd316`)

## Results from direct reruns

| Check | Live result |
|---|---:|
| OpenSCAD source compile, EU42/EU44/EU46 heel selector | PASS, all 3 exports |
| Source/package regression script | 130/130 PASS |
| Heel-core cavity probes | 9/9 PASS |
| Kinematic sweep | 61/61 positions; 250 checks; 0 reported position failures |
| Rail/stop exact CSG | 6/6 PASS (fresh standalone rerun) |
| M4/EVA/front strap/rear anchor CSG | 24/24 PASS (fresh rerun) |
| Revised heel-deck meshes | 3/3 PASS: watertight, consistently wound, one connected mesh each |
| Mesh geometry correspondence | 3/3 PASS; maximum nearest-vertex delta after print-prep translation is 0.00006086 mm |
| Load-screen formula audit | 36/36 rows independently recomputed; 0 mismatches |

The refreshed native heel-deck STL volume is approximately **116,879.767 mm³** for each size. The packaged print-prep meshes match the fresh OpenSCAD exports after the expected (+86.0 mm X, +20.6 mm Z) print-prep translation; vertex differences are only binary STL rounding. The revised roof volume increase is approximately 5,819 mm³, or about 5.53 g at the assumed 0.95 g/cm³ PA12 density.

## Package-integrity defect found and fixed

The original secondary `PRINT_READY_BENCH_FIT_KIT/SHA256SUMS.txt` listed 70 entries, of which **27 hashes did not match** the actual files delivered in the ZIP. The list has been regenerated against the delivered bytes. The top-level `REV_R_PACKAGE_MANIFEST.sha256` has also been rebuilt for the current package. The rebuilt ZIP was then re-opened and every listed top-level hash was independently checked; its ZIP CRC test also returned no bad member.

## Load and release disposition

The calculation uses 66 kg × 9.81 = **647.46 N** for the conservative single-shoe case. The target bladder footprint is 27 × 22 = **594 mm²**, so pressure demand would be **1.090 MPa** if the bladder alone carried 647.46 N—above the candidate 1.0 MPa fitting rating. The provisional 0.40 MPa / 0.50 MPa working/relief targets provide idealized bladder forces of 237.6 N / 297.0 N only; the structural path must carry the residual and the full external load if the bladder depressurizes.

The 90.3 mm whole-pin-span sensitivity is about 678.31 MPa at 2× and 1,017.47 MPa at 3× versus the candidate 725 MPa H1150D proof reference. This simple beam model is not a validated pin stress, but its small 2× margin and 3× exceedance are explicit engineering hold points.

**No material-specific FEA or physical tests were performed. This package is not cleared for human wear.** Software/mesh/checksum success does not establish load capacity, pressure transients, fatigue, retention, outsole grip or fit safety.
