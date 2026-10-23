# Rev R1.5 release gate — GO 3 / GO 4

**Current status: digitally verified geometry candidate; NOT cleared for human wear or production.**

## Closed in this pass
- Standard 4.0 mm outsole external envelope preserved; relief depth 1.5 mm leaves a 2.5 mm nominal tread skin.
- 42 primary fit-kit STLs and 9 optional outsole study STLs freshly exported from current source and checked.
- Current active 72-mesh set audited; all meshes pass finite/volume/winding/watertight checks after in-memory topology repair.
- R1.5 source parameter comments now correctly distinguish verified official-family information from unverified AP20-D/ARX20 selected-output assumptions.
- 79-line analytic structural/pneumatic screen generated and bound to exact current source hash.

## Still open
- Pin axial lock/impact/fatigue and retaining-ring retention; critical bridge and roof material-specific analysis.
- Exact M4×22 and M4×14 fastener SKUs and material grades.
- Exact relief/regulator models, setting capability and relief flow/transient pressure; pressure-loss safe state.
- Material-specific FEA and physical load, fatigue, impact, retention, traction, abrasion, tear and bond tests.
- Actual EVA/tread materials, densities and measured fit/tolerances.

## Latest source
`revision/Apex_Stride_Pro_RevR.scad` — SHA-256 `43a706db3ba6ce2e7d012914409b26862a64dc2da722e90b0a0b8b0ed63f7a5c`
The standalone `Apex_Stride_Pro_RevR1_5_Corrected.scad` and print-preparation source are byte-identical. Full test qualifications are in `Apex_Stride_Pro_RevR1_5_Full_Audit_Report.md`.
