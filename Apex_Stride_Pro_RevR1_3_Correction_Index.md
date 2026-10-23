# Rev R1.3 correction index — 2026-10-16

## Actual CAD corrections in this revision

1. **Forefoot lightening-pocket roof:** replaced the old z=−5.5 mm pocket ceiling with a 10.1 mm roof. This is a real change to `toe_lightening_pockets()` and the 42 regenerated fit-kit meshes.
2. **Forefoot inter-pocket web:** reduced each underside pocket row from 11 mm to 9 mm wide, leaving a 5 mm center web instead of 1 mm. Source assertions now enforce the minimum roof, minimum web, and full-width relation (2×9+5=23 mm).
3. **Nominal stop-clearance guard:** added a source assertion ensuring the last EU46 indexed-hole envelope and stop-lug leading face remain separated by at least 0.5 mm from their defined CAD coordinates. The final rail length and guide slot remain at the existing baseline values (155 mm rail, 90 mm slot). An exploratory rail extension was reverted after CSG revealed a degenerate channel-end contact; it is not present in this release.
4. **Retained prior fixes:** the M4 button-head/recess 0.01 mm clash correction, corrected 594 mm² bladder footprint arithmetic, and 10.1 mm heel-core roof/9 mm bladder height are inherited from R1.2. These are not newly claimed as R1.3 modifications.

## Reproducible verification

- Source/package suite: 130/130 PASS.
- Cavity geometry: 9/9 PASS.
- Kinematic sweep: 61/61 positions and 250/250 checks PASS.
- Rail/stop exact CSG: 6/6 PASS against final source.
- M4 screw/EVA/bridge interface exact CSG: 24/24 PASS against final source.
- Active STL audit: 72/72 pass (42 fit-kit, 21 upper concepts, 9 optional outsole studies); all 42 fit index extents/volumes reconcile to their actual meshes.
- Native mass audit: 24/24 exports valid (8 components × 3 nominal sizes); current geometry-derived mass table is in `REV_R1_3_MASS_SUMMARY.json` and `.csv`.
- All three source copies are byte-identical. Main package and active fit-kit manifests are rebuilt for the final archive.

## Not corrected / still a gate

The 3 mm bridge straps have a 2.2 mm head counterbore leaving a nominal 0.8 mm cap. The load-bearing joint and screw preload have not been analyzed or physically tested; changing strap stack depth without reworking screw length, nut traps and EVA interface could introduce new defects. The rail-hole ligament, pin bending, pneumatic load sharing, outsole skin, fatigue and material-specific stress remain engineering gates. No FEA or physical test was completed. Do not wear/body-load the concept.
