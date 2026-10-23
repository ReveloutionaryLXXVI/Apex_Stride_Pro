# Apex Stride Pro — Complete Progress Archive

This archive collects the Apex Stride Pro project artifacts currently present in the working directory: revision CAD sources, prior engineering-package ZIPs, reports, QA JSON/CSV files, mesh audits, load/structural screens, progress/work folders, and the isolated R1.6 screw CSG result.

## Revision/source status
- **Latest standalone CAD source actually present in the working directory:** `Apex_Stride_Pro_RevR1_5_Corrected.scad` (Rev R1.5).
- **Latest packaged complete revision actually present:** `Apex_Stride_Pro_RevR1_5_GO5_Final_Checked_Engineering_Package.zip`.
- **R1.6/R1.7 in-progress changes discussed in the current chat:** include deeper rail-channel roof, revised rail axis/wall, thicker bridge straps, coordinated screw engagement, solid rails as default, and provisional pneumatic target reduced to 0.25 MPa. However, no standalone R1.6/R1.7 `.scad` or complete R1.6/R1.7 ZIP was present in the working directory at packaging time. The archive therefore preserves all saved progress and includes this status rather than falsely labeling R1.5 files as the unfinished newer revision.

## Safety/release status
This is an engineering development archive, **not a release for human wear**. The available checks are digital geometry, consistency, and simplified analytical screens. Material-specific FEA and physical proof-load, fatigue, impact, retention, pneumatic failure/flow, traction, and wear qualification are not complete.

## Integrity
`ARCHIVE_SHA256_MANIFEST.txt` lists SHA-256 hashes for every file included in this ZIP except the manifest itself. Existing revision ZIPs are retained as historical artifacts.
