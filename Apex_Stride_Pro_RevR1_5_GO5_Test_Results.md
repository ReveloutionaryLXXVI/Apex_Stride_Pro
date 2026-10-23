# Rev R1.5 — GO5 final independent verification record

Source of truth: `revision/Apex_Stride_Pro_RevR.scad`

SHA-256: `664f2858f85ac5eba0be335d8d0e89a64b769ca5985a37d5bf286ad4aa19d5c0`

All three current CAD sources (native, print-prep, standalone) match that hash exactly.

| Check | Result | Scope/limit |
|---|---:|---|
| Source/package/document regression | PASS 130/130 | Helper retains a legacy Rev R1.4 title; it ran on the exact current source and synchronized print-prep copy. |
| Heel-core cavity probes | PASS 9/9 | Geometry only. |
| Kinematic/registration sweep | PASS 250/250 over 61 positions | Source-coordinate arithmetic, not dynamic or tolerance analysis. |
| Rail/end-stop exact CSG | PASS 6/6 | The listed nominal configurations. |
| Bridge/fastener interface CSG | PASS 18/18 | Nominal envelopes and coordinate guardrails. |
| Lock-tip/deck CSG | PASS 4/4 | Nominal cylinder clearance, not thread engagement or actual fastener certification. |
| Fit-kit mesh exports | PASS 42/42 | Fresh native exports across EU42/EU44/EU46. |
| Optional outsole study exports | PASS 9/9 | Study-only geometry, not wear-qualified. |
| Native mass audit | PASS 24/24 | Mesh-volume × assumed density, not measured mass. |
| Active mesh audit | PASS 72/72 after in-memory weld/cleanup | 42 fit kit + 21 upper concept + 9 outsole study. Delivered STL byte files were not rewritten during this audit. |
| Structural guardrails | 14/18 PASS; 0 FAIL; 4 UNVERIFIED | Four unverified supplier/system gates are listed below. |
| Archive/manifest | See external integrity receipt | ZIP test and every manifest entry checked against packed bytes. |

Unverified structural/pneumatic gates: (1) T0425 tube pressure rating vs temperature / conflicting manufacturer document revisions; (2) final AP20-D order code, port/thread/options; (3) relief flow and overshoot at the real chamber volume; (4) finished bladder pressure/burst/cycle rating and pressure-loss safe state.

The 66 kg static one-shoe force is 647.46 N. At the provisional 0.50 MPa pressure-relief target, the idealized bladder force estimate is 297 N, but the chassis must carry the entire 647.46 N at zero pressure. These calculations are screening values only.

No material-specific FEA and no physical proof-load, fatigue, impact, retention, pneumatic, traction, abrasion or wearer test were performed. This is a digitally frozen engineering candidate, not a qualified manufacturing release; do not wear or body-load it.
