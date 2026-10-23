# Rev R1.3 package integrity note

This note is part of the corrected Rev R1.3 package. The authoritative CAD source SHA-256 is `c1b2d584d5fb5b0a27cd7bd47441af1bc030ace74b1f03661eb44fa369cb3d56` and matches the print-preparation and standalone source byte-for-byte.

The package root manifest is `REV_R_PACKAGE_MANIFEST.sha256`; it enumerates every other file in the package root tree. The active fit-kit manifest is `PRINT_READY_BENCH_FIT_KIT_REV_R/SHA256SUMS_REV_R1_3.txt`; it enumerates each file in that kit except the manifest itself. The enclosing ZIP archive is separately tested for CRC integrity after creation.

Checksums establish byte integrity only; they do not prove design strength, material conformance, or wear safety. See `REV_R1_3_FULL_AUDIT_REPORT.md` for scope and outstanding structural gates.
