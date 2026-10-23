# Apex Stride Pro — Rev R1.4 release gate

**Current state:** GO 1 load-path definition and GO 2 bridge-joint/fastener redesign are implemented in native CAD. The joint uses 23×4.5 mm straps, a 9 mm stack, ±2 mm staggered anchor centers, M4×22 rear-anchor geometry, M4×16 toe-anchor geometry and M4×14 indexed lock geometry. Rear and lock exact supplier SKUs remain unselected. Pin diameter/groove dimensions were deliberately held pending derivation of actual locking loads, retention forces and bearing distribution.

**Fresh completed digital checks:** 130/130 source/package checks; 61/61 nominal adjustment positions and 250/250 arithmetic checks; 6/6 rail-stop CSG; 18/18 bridge-fastener interface CSG/geometry guardrails; 4/4 lock-shank vs toe-deck CSG; 42/42 fit parts freshly exported; 66 fresh native mass exports. A new audit covers all 72 active meshes. There are zero missing assembly-map file paths. See `REV_R1_4_GO1_GO2_STRUCTURAL_JOINT_REPORT.md` and `revision/verification_results/revR1_4_go1_go2/`.

**Not a manufacturing release; do not wear.** No material-specific FEA or physical load, fatigue, impact, retention, traction, pressure-loss or cyclic testing has been performed. Exact M4×22/M4×14 SKUs, material certificates, actual pin/retaining ring and the pin/load-path design remain open for GO3.
