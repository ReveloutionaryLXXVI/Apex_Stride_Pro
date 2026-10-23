/*
  APEX STRIDE PRO — GROWTHFIT CAPTURED-RAIL ADJUSTABLE SHOE CONCEPT — REV R CORE-CAVITY INTEGRATION
  Rev Q preserves the tested Rev P/C3 rail and stop corrections and the Rev K 11 mm rail-head width. The split outline returns to the Rev K ±32 mm joint profile; rail centres are ±20.3 mm and bridge flanges are 23.0 mm wide. Nominal outer wall is 5.4 mm and rail-channel-to-bridge-recess web is 2.15 mm; these are geometry values only, not strength validation. The adjustable captured-rail architecture remains; 8.3 mm rail index bores and the 8.8 mm carriage passage remain distinct. The single-headed 8 mm pin with recessed DIN 471 size-8 ring is still a concept requiring actual hardware gauging and retention tests. Default outsole remains 4.0 mm; 3.2 mm mass-study remains opt-in. Material card and specified upper/footbed/cushioning inputs are integrated. Rev R adds a continuous 55×23 mm underside cavity in the fixed heel deck; Rev R1.2 thickens the heel roof and reduces the custom bladder height target to 9.0 mm; Rev R1.3 thickens the forefoot pocket roof and widens the center web, preserving the outside 20.6 mm sole thickness. This geometry is a preliminary stiffness improvement, not structural qualification; supplier-sized spring/bladder, seats/retention, pneumatic ports/line routing, and pressure-loss failsafe remain unqualified. This is not a released wearable product.

  REV R1.3 structural geometry correction: forefoot lightening-pocket roof is now 10.1 mm
  and center web is 5.0 mm (was 5.5 mm roof / 1.0 mm web). This lowers geometric flexibility
  sensitivity but remains a preliminary concept, not structural qualification.

  REVISION PATCH C3: rail lightening cavities are now split around the two Ø3.3 mm rail attachment pilots; each pilot has a solid land extending at least (pilot radius + 2.5 mm). This corrects the interrupted-thread-engagement geometry found in audit. The printable rail STLs remain solid polymer fit gauges, not metal hardware.

  SAFETY / SCOPE:
  - This is a concept chassis, NOT a validated running shoe or load-rated mechanism.
  - The default 4.0 mm outsole remains the geometry baseline; the 3.2 mm outsole is an
    optional mass study only. Do not use the thinner mode for wear.
  - Rev P uses a one-headed custom pin with a DIN 471 size-8 external retaining-ring interface.
    The CAD clip is schematic; purchase a correctly dimensioned ring and machine the actual
    groove to the ring supplier's current drawing. Do not fabricate the pin from the STL alone. The
    original 8.8 mm bore is intentionally preserved pending physical fit/tolerance review; the
    custom 8 mm pin is not interchangeable with an unspecified commercial quick-release pin.
  - Captured T-rails, stop lugs, bridge straps, pin retention, outsole and upper remain
    unvalidated for human use. Material-specific FEA and physical proof/fatigue/traction/fit
    release are still required.
  - EU labels are nominal presets only. Measure both feet and calibrate the sole outline.

  Parameters:
    eu_size = 42, 44, or 46
    width_scale = 1.00 (standard), 1.04 (wide shell), or 1.08 (extra-wide shell); measure the foot before choosing
    part = "assembly" (mechanism with telescoping straps), "assembly_fixed", individual component selectors,
           "full_mockup" (complete visualization), "pin_through" / "pin_through_solid" (single-headed retaining-ring pin),
           "pin_retaining_clip" (simplified external retaining-ring visualization),
           "pin_through_hollow" / "pin_legacy_solid" (legacy double-headed study only; not for assembly)

  Three discrete settings: EU42 / EU44 / EU46. T-rails are captured in undercut channels.
  Pins lock the size; the stop lug/groove limits travel. The performance core is not included.
*/

// ---------- USER PARAMETERS ----------
// REV R core-cavity integration candidate, derived from Rev Q; preserves captured-rail/lock architecture and prior C3 corrections. The new heel cavity is real subtractive CAD and needs structural review.
eu_size = 42;
part = "full_mockup"; // complete concept visualization with upper, footbed and continuous outsole
show_fasteners = true;
width_scale = 1.00;  // concept width shell: 1.00 regular, 1.04 wide, 1.08 extra-wide

// ---------- DESIGN PARAMETERS (mm) ----------
$fn = 36;
// Experimental candidate only: keep false for the Rev K baseline geometry.
// When true, selects the pre-existing 3.2 mm cover / 1.4 mm relief CAD study.
// Its nominal residual tread skin remains 1.8 mm, but grip, abrasion, compression,
// tear, fatigue, and retention are NOT validated. Do not use this mode for wear.
outsole_weight_study = false;
outsole_pad_thickness = outsole_weight_study ? 3.2 : 4.0;  // candidate thickness; no elastomer selected
outsole_relief_depth = outsole_weight_study ? 1.4 : 2.2; // nominal residual skin = 1.8 mm in both modes
outsole_connector_width_heel = 66.6667;
outsole_connector_width_toe = 80.8;
outsole_connector_segments = 32; // serpentine centerline sample segments
outsole_connector_developed_length = 74.0; // target geometric path length, not a material test
outsole_connector_tread_depth = 0.75;
// Rev Q removable EVA footbed target: 7 mm heel / 5 mm forefoot. Supplier compression data remains required.
footbed_heel_thickness = 7.0;
footbed_forefoot_thickness = 5.0;
footbed_edge_inset = 4.5;
footbed_lap_length = 45.0; // derived from 26.667 mm max extension + 18.333 mm minimum residual overlap
footbed_lap_halfwidth = 25.0; // 50 mm tongue leaves 2.5 mm nominal side lands within the 55 mm inset footbed at split
footbed_lap_clearance = 0.35; // geometric mockup clearance, verify after EVA die-cut/process
footbed_z = 0.15;

// Candidate material-card inputs (not used as strength allowables or production certification).
pa12_density_kg_m3 = 950;
pa12_tensile_modulus_mpa = 1650;
pa12_tensile_strength_mpa = 48; // tensile strength, NOT yield strength
pa12_flexural_strength_mpa = 41;
pa12_flexural_modulus_mpa = 1500;
pa12_elongation_percent = 20;
pa12_shore_d = 75;
pa12_hdt_c = 86;
tpu95a_modulus_xy_mpa = 67;
tpu95a_modulus_z_mpa = 56;
tpu95a_break_xy_mpa = 23.7;
tpu95a_break_z_mpa = 6.4;
pneumatic_tube_od_mm = 4.0; // only if selected fitting matches OD and rated pressure
// Rev R1.4 GO1+GO2: chassis must carry full design load with zero pneumatic assist; bladder is auxiliary only. Bridge straps, staggered joints and M4 stack redesigned together. Pin is an axial slider lock, not the primary vertical support.
core_spring_reserve_length_mm = 24.0;
core_separator_length_mm = 3.0;
core_bladder_reserve_length_mm = 28.0;
bladder_target_body_length_mm = 27.0; // RFQ limit excluding only a supplier-justified port
bladder_target_body_width_mm = 22.0;
bladder_target_body_height_mm = 9.0; // Rev R1.2 compact bladder envelope allows a 10.1 mm PA12 roof
pneumatic_working_pressure_target_mpa = 0.40; // provisional bench target only; not an approved operating pressure
pneumatic_relief_setpoint_target_mpa = 0.50; // provisional AP20-D-family setting; verify relief flow/overshoot
pneumatic_candidate_fitting_max_working_mpa = 1.00; // SMC KQ2 family; surge must remain below this rating
pneumatic_candidate_tube_max_working_mpa = 1.50; // SMC T0425 at 20 C, temperature derating applies
pneumatic_candidate_relief_family_max_set_mpa = 0.80; // SMC AP20-D family; exact variant not ordered
pneumatic_candidate_regulator_max_output_mpa = 0.85; // SMC ARX20 family
heel_core_envelope_length = 55.0; // Rev R: continuous fixed-deck cavity length; supplier component fit still to be confirmed
heel_core_envelope_width = 23.0; // Rev R: continuous cavity width; retain >=2 mm nominal web to rail channels
heel_core_envelope_height = 10.5; // Rev R1.2 cavity depth: 20.6 mm sole - 10.1 mm roof
heel_core_roof_thickness_mm = 10.1; // increased from 5.5 mm to reduce under-deck bending sensitivity
heel_core_roof_z = -heel_core_roof_thickness_mm;
heel_core_envelope_x0 = -125.0;
vent_hole_d = 2.4;
mm_per_eu_size = 6.6667;    // nominal increment; calibrate against actual last/foot length
sole_thickness = 20.6;  // leaves a 4.1 mm nominal roof above 16.1 mm rail plus vertical fit allowance
sole_bottom_z = -sole_thickness; // top surface z=0; outsole plane tracks deck thickness
heel_core_envelope_z0 = sole_bottom_z;
heel_split_x = -25.0;      // joint line at EU42
rail_y = 20.3;        // Current Rev Q nominal rail centerline; verify production fit with measured parts
rail_head_width = 11.0;  // Rev K baseline transverse head width restored; pin-axis bearing length, not side ligament
rail_stem_width = 6.5;
rail_neck_height = 2.3;
rail_height = 16.1;          // 13.8 mm T-head + 2.3 mm neck; Ø8.3 index bore leaves 2.75 mm nominal vertical ligament
rail_z = sole_bottom_z; // rail bottom remains flush with outsole plane
rail_start_x = heel_split_x - 65.0;
rail_end_x   = heel_split_x + 90.0;
rail_length = rail_end_x - rail_start_x;
slot_length = 90.0;         // toe and bridge guide channels reach the end of the rail
bridge_overlap = 45.0; // overlap geometry target; front strap remains supported across all indexed settings
bridge_flange_width = 23.0; // Current bridge flange width; nominal screw edge distance 4.1 mm
bridge_flange_thickness = 4.5; // Rev R1.4 GO2: each machined 6061-T6 candidate strap; fit STL remains a nonwearable mockup
bridge_stack_depth = 9.0; // coordinated two-layer 4.5 mm bridge stack recessed into outsole-side decks
bridge_pair_stagger_mm = 2.0; // stagger +/-2 mm in X so paired Ø7.9 head recesses do not share one weak section
bridge_rear_anchor_screw_length_mm = 22.0; // under-head length; source/grade/availability must be confirmed before procurement
bridge_toe_anchor_screw_length_mm = 16.0; // under-head length; 0.25 mm nominal footbed clearance
bridge_lock_screw_length_mm = 14.0; // under-head length; engages captured M4 nut in 9 mm stack
bridge_lock_tip_relief_depth_mm = 1.65; // through-roof tip relief above each captured lock nut
bridge_fit_clearance = 0.35;
bridge_rear_start = 40.0; // behind split, mm
bridge_rear_end = 90.0; // ahead of split, mm
bridge_front_start = 25.0; // front strap extends behind split
bridge_front_end = 60.0; // and ahead of split, relative to moving toe
bridge_lock_x = 50.0; // indexed locking screw position relative to split, clear of cross-pin tunnel
bridge_lock_hole_d = 4.8;
bridge_lock_nut_af = 7.0; // Standard ISO 4032 M4 hex nut across-flats; trap adds 0.35 mm clearance
bridge_lock_nut_depth = 3.45; // 3.2 mm nut height plus 0.25 mm fit/retention clearance
lightening_enabled = true;
// Rev R1.3 local forefoot reinforcement: increase pocket roof to 10.1 mm.
lightening_roof_thickness_mm = 10.1;
lightening_roof_z = -lightening_roof_thickness_mm;
lightening_pocket_width_mm = 9.0;
lightening_pocket_outer_halfwidth_mm = 11.5;
lightening_pocket_center_web_mm = 5.0;
rail_weight_relief = true; // study option: enclosed rail cavities outside pin-hole neighborhoods
rail_relief_sidewall_mm = 2.5; // nominal walls around each rail cavity; NOT a structural allowable
rail_relief_end_margin_mm = 2.0; // retain material at ends and stop-lug region // leave >=5.5 mm continuous top skin away from rail channels and bosses
upper_wall_height = 22.0; // non-structural fit-envelope mockup only
upper_wall_thickness = 3.0;
upper_vamp_width_scale = 1.45; // broaden the top vamp so its side edges meet the modeled upper sidewall envelope
bridge_screw_y = 5.0; // paired with 23.0 mm bridge flanges for 4.1 mm nominal hole-to-edge distance
bridge_nut_af = 7.35; // ISO 4032 M4 nut AF 7.0 mm + 0.35 mm pocket clearance
bridge_nut_pocket_depth = 3.6; // 3.2 mm ISO M4 nut + 0.4 mm recess; mates to M4x22 heel-anchor thread length
bridge_screw_head_d = 7.9; // Ø7.6 mm Würth ISO 7380-1 button head + 0.3 mm diametral clearance
bridge_screw_head_depth = 2.2; // matches Ø7.6 × 2.2 mm sourced button-head geometry; R1.4 leaves a 2.3 mm cap
lock_pin_d = 8.0;           // nominal custom pin shaft; Rev P fit target: Ø8.00 -0.02/0.00 mm, subject to drawing approval
lock_hole_d = 8.8;           // toe-carriage side-boss passage; intentionally larger than rail indexing holes
rail_index_hole_d = 8.3;     // nominal rail index holes; proposed finish Ø8.30 +0.05/0.00 mm, measure/gauge all aligned holes
pin_head_d = 12.0;           // single handle-side head, seated in the +Y counterbore
pin_counterbore_d = 12.4;   // handle-side head pocket
pin_head_depth = 3.0;
pin_core_bore_d = 4.0;      // legacy custom hollow-pin study option only
pin_entry_y = 45.0;          // nominal 90 mm span between side faces at y=+/-45 mm
pin_tail_extension = 0.30;   // 0.3 mm pin-tip projection; positions ring 0.35 mm below the far-side face
pin_keeper_counterbore_d = 15.2; // candidate recess: 14.7 mm ring envelope + 0.25 mm radial clearance
pin_keeper_recess_depth = 1.5;
pin_keeper_clip_od = 14.7;  // standard-reference clearance envelope for 8 mm external retaining ring
pin_keeper_clip_thickness = 0.8; // DIN 471 size-8 reference thickness
pin_groove_root_d = 7.6;    // DIN 471 size-8 reference groove diameter
pin_groove_width = 0.9;     // DIN 471 size-8 reference groove width
pin_groove_end_margin = 0.6; // DIN 471 size-8 reference minimum end margin
pin_groove_center_y = -pin_entry_y-pin_tail_extension+pin_groove_end_margin+pin_groove_width/2; // -44.25 mm for the recessed-ring arrangement
lock_z = rail_z + rail_neck_height + (rail_height - rail_neck_height)/2;
fit_clearance = 0.80;   // lateral clearance per side for printed prototype parts
fit_clearance_vertical = 0.40;
bolt_hole_d = 4.8;          // Clearance-hole placeholder for deck/bridge plates; not a hardware spec
rail_mount_pilot_d = 3.3; // Candidate M4x0.7 tap-drill pilot in metal rails; verify with approved thread/material drawing

assert(eu_size == 42 || eu_size == 44 || eu_size == 46,
       "Choose eu_size = 42, 44, or 46 for this prototype.");
assert(width_scale == 1.00 || width_scale == 1.04 || width_scale == 1.08,
       "Choose width_scale = 1.00, 1.04, or 1.08; these are concept presets, not standardized widths.");
assert(outsole_pad_thickness >= 3.0, "Outsole layer must be at least 3.0 mm in this concept model.");
assert(footbed_heel_thickness >= 6.0 && footbed_heel_thickness <= 8.0, "Heel EVA footbed target must remain in the 6-8 mm supplier-confirmed range.");
assert(footbed_forefoot_thickness >= 4.0 && footbed_forefoot_thickness <= 6.0, "Forefoot EVA footbed target must remain in the 4-6 mm supplier-confirmed range.");
assert(footbed_lap_length >= (4*mm_per_eu_size)+18.0, "Footbed sliding lap is too short to preserve overlap at EU46 extension.");
assert(outsole_pad_thickness-outsole_relief_depth >= 1.79, "Relief leaves less than 1.8 mm nominal tread skin.");
assert((rail_height-rail_neck_height-rail_index_hole_d)/2 >= 2.7,
       "Rail index hole leaves less than 2.7 mm nominal top/bottom rail-head ligament.");
assert(rail_end_x-3.0-(heel_split_x+30+4*mm_per_eu_size+rail_index_hole_d/2) >= 0.5,
       "Stop-lug leading face must clear the final indexed-hole envelope by at least 0.5 mm in X.");
assert(rail_mount_pilot_d >= 3.2 && rail_mount_pilot_d <= 3.4,
       "Rail attachment pilot must remain a documented M4 tap-drill candidate; verify thread and material before manufacture.");
assert(heel_core_envelope_length > 0 && heel_core_envelope_width > 0 && heel_core_envelope_height > 0,
       "Heel core cavity envelope dimensions must be positive.");
assert(heel_core_envelope_x0 + heel_core_envelope_length < heel_split_x,
       "Heel core cavity must stay inside the fixed heel deck, behind the moving split.");
assert(heel_core_roof_z < 0 && heel_core_roof_thickness_mm >= 10.0,
       "Rev R1.2 heel core roof must remain at least 10.0 mm thick until load validation is complete.");
assert(lightening_roof_z < 0 && lightening_roof_thickness_mm >= 10.0,
       "Rev R1.3 forefoot lightening-pocket roof must remain at least 10.0 mm thick pending load validation.");
assert(lightening_pocket_width_mm > 0 && lightening_pocket_outer_halfwidth_mm > 0 && lightening_pocket_center_web_mm >= 5.0,
       "Forefoot lightening pockets require positive width and at least a 5 mm center web.");
assert(abs(2*lightening_pocket_width_mm + lightening_pocket_center_web_mm - 2*lightening_pocket_outer_halfwidth_mm) < 0.001,
       "Forefoot pocket width + center web must exactly match the nominal sole half-width envelope.");
assert(abs(sole_thickness - heel_core_envelope_height - heel_core_roof_thickness_mm) < 0.001,
       "Heel core cavity depth and roof thickness must sum to the external sole thickness.");
assert(heel_core_envelope_height <= heel_core_roof_z - sole_bottom_z + 0.05,
       "Heel core cavity exceeds its dedicated roof plane and would breach the roof.");
assert(abs(core_spring_reserve_length_mm + core_separator_length_mm + core_bladder_reserve_length_mm - heel_core_envelope_length) < 0.001,
       "Spring reserve + separator + bladder reserve must exactly match the 55 mm core cavity length.");
assert(bladder_target_body_length_mm <= core_bladder_reserve_length_mm &&
       bladder_target_body_width_mm <= heel_core_envelope_width &&
       bladder_target_body_height_mm <= heel_core_envelope_height - 1.0,
       "Target bladder body envelope exceeds its nominal CAD reserve; do not assume port/seams fit.");
assert(pneumatic_working_pressure_target_mpa > 0 &&
       pneumatic_working_pressure_target_mpa < pneumatic_relief_setpoint_target_mpa,
       "Provisional pneumatic working target must be positive and below relief setpoint target.");
assert(pneumatic_relief_setpoint_target_mpa <= pneumatic_candidate_relief_family_max_set_mpa &&
       pneumatic_relief_setpoint_target_mpa < pneumatic_candidate_regulator_max_output_mpa &&
       pneumatic_relief_setpoint_target_mpa < pneumatic_candidate_fitting_max_working_mpa &&
       pneumatic_relief_setpoint_target_mpa < pneumatic_candidate_tube_max_working_mpa,
       "Provisional relief setpoint exceeds a candidate circuit component's range/rating.");
assert(pneumatic_candidate_fitting_max_working_mpa - pneumatic_relief_setpoint_target_mpa >= 0.40,
       "Preserve at least 0.40 MPa nominal relief-to-fitting rating margin pending surge verification.");
assert(rail_y - (rail_head_width/2 + fit_clearance) - heel_core_envelope_width/2 >= 2.0,
       "Heel core cavity leaves less than 2.0 mm nominal side web to the rail-channel envelope.");
assert(rail_head_width >= 11.0,
       "Do not reduce transverse rail bearing length below the Rev K baseline without material-specific bearing/tear-out analysis.");
assert(rail_index_hole_d-lock_pin_d >= 0.25 && rail_index_hole_d-lock_pin_d <= 0.40,
       "Nominal diametral pin-to-rail-hole clearance must remain between 0.25 and 0.40 mm; verify manufacturing tolerances.");
assert(rail_y-(rail_head_width/2+fit_clearance)-(bridge_flange_width/2+bridge_fit_clearance) >= 2.0,
       "Rail channel to bridge recess leaves less than 2.0 mm nominal deck web.");
assert(32.0*width_scale-(rail_y+rail_head_width/2+fit_clearance) >= 5.2,
       "Nominal deck outer wall at the rail channel must remain at least 5.2 mm.");
assert(bridge_flange_width/2-bridge_screw_y-bolt_hole_d/2 >= 4.0,
       "Bridge strap leaves less than 4.0 mm nominal edge distance from an M4 clearance hole to the flange edge.");
assert(bridge_flange_thickness-bridge_screw_head_depth >= 2.3,
       "R1.4 bridge strap must retain at least a 2.3 mm cap behind the M4 button-head recess.");
assert(abs(bridge_stack_depth-2*bridge_flange_thickness) < 0.001,
       "Bridge pocket stack depth must equal two strap layers with no nominal step.");
assert(sqrt(pow(2*bridge_pair_stagger_mm,2)+pow(2*bridge_screw_y,2)) >= bridge_screw_head_d+1.0,
       "Staggered screw-head recesses overlap or lack 1 mm nominal separation.");
assert(bridge_pair_stagger_mm >= 1.5 && bridge_pair_stagger_mm <= 2.5,
       "Bridge screw pair stagger must remain in its 1.5–2.5 mm validated geometry window.");
assert(bridge_lock_tip_relief_depth_mm >= bridge_lock_screw_length_mm-bridge_stack_depth-bridge_lock_nut_depth+0.10,
       "Lock-screw tip relief is too shallow for nominal screw projection above the M4 nut.");
assert(bridge_toe_anchor_screw_length_mm <= (0-sole_bottom_z-bridge_flange_thickness)+footbed_z-0.20,
       "Toe anchor screw projects into the moving forefoot footbed clearance envelope.");
assert(lock_hole_d >= lock_pin_d && lock_hole_d <= 8.8,
       "Carriage pin passage must preserve the baseline nominal range and leave no less than nominal shaft diameter clearance.");
assert(pin_counterbore_d >= pin_head_d+0.4,
       "Pin head pocket must leave at least 0.20 mm radial nominal clearance.");
assert(pin_keeper_counterbore_d >= pin_keeper_clip_od+0.5,
       "Retaining-ring recess must leave at least 0.25 mm radial nominal clearance.");
assert(pin_keeper_recess_depth >= pin_entry_y+pin_groove_center_y+pin_keeper_clip_thickness/2+0.2,
       "Retaining-ring recess is too shallow for the positioned ring plus 0.20 mm floor clearance.");
assert(pin_groove_width >= pin_keeper_clip_thickness+0.1,
       "Pin groove width must provide at least 0.10 mm total nominal axial clearance for the ring.");
assert((18.0-pin_keeper_counterbore_d)/2 >= 1.3,
       "Retaining-ring recess leaves less than 1.3 mm nominal wall in the local 18 mm boss.");
assert(sole_thickness-rail_height-fit_clearance_vertical >= 4.0,
       "Captured rail channel leaves less than 4.0 mm nominal deck roof.");
extension = (eu_size - 42) * mm_per_eu_size;

// ---------- PLANFORM PROFILES ----------
module heel_profile_2d() {
  scale([1, width_scale]) polygon(points=[
    [-147,   0], [-144,  18], [-137,  27], [-124,  32],
    [-104,  35], [ -82,  36], [ -60,  35], [ -42,  33],
    [heel_split_x, 32], [heel_split_x,-32],
    [ -42, -33], [ -60, -35], [ -82, -36], [-104, -35],
    [-124, -32], [-137, -27], [-144, -18]
  ]);
}

module toe_profile_2d() {
  scale([1, width_scale]) polygon(points=[
    [heel_split_x,-32], [-10,-39], [ 15,-46], [ 45,-49],
    [ 72,-48], [100,-42], [122,-32], [138,-19], [147,-5],
    [147,  5], [138, 19], [122, 32], [100, 42], [ 72, 48],
    [ 45, 49], [ 15, 46], [-10, 39], [heel_split_x,32]
  ]);
}

// Rev G telescoping bridge recesses: the rear strap sits at z=sole_bottom_z and the
// moving front strap stacks above it. The pair is centered between rails. Rev P provides a 2.15 mm nominal deck web
// between the expanded rail-channel cut and the bridge-recess cut at the narrow split. This is concept geometry;
// final widths/clearance depend on chosen rail material, process, and measured tolerances.
// Undercut/T-slot guide channel. The narrow underside throat passes the rail stem;
// the wider inner cavity captures the rail head against pull-out. The rail must be
// assembled by sliding it in from an open end. It is not a load-rated retention design.
module underside_rail_channels(x0, x1) {
  for (yy=[-rail_y,rail_y]) {
    // Narrow throat around the rail stem, opening through the outsole underside
    translate([x0, yy-(rail_stem_width+2*fit_clearance)/2,
               rail_z-fit_clearance_vertical])
      cube([x1-x0, rail_stem_width+2*fit_clearance,
            rail_neck_height+2*fit_clearance_vertical]);
    // Wide cavity around the rail head, overlapping the throat for a clean cut
    translate([x0, yy-(rail_head_width+2*fit_clearance)/2,
               rail_z+rail_neck_height-fit_clearance_vertical])
      cube([x1-x0, rail_head_width+2*fit_clearance,
            rail_height-rail_neck_height+2*fit_clearance_vertical]);
  }
}

module bridge_recess_heel() {
  translate([heel_split_x-bridge_rear_start-bridge_fit_clearance,
             -(bridge_flange_width/2+bridge_fit_clearance), sole_bottom_z-0.01])
    cube([bridge_rear_start+bridge_fit_clearance,
          bridge_flange_width+2*bridge_fit_clearance, bridge_stack_depth+0.01]);
}
module bridge_recess_toe() {
  translate([heel_split_x-0.01,
             -(bridge_flange_width/2+bridge_fit_clearance), sole_bottom_z-0.01])
    cube([bridge_rear_end+bridge_fit_clearance,
          bridge_flange_width+2*bridge_fit_clearance, bridge_stack_depth+0.01]);
}
module bridge_nut_traps(xpos) {
  // +/-2 mm X-stagger prevents aligned counterbores from forming a 0.8 mm weak section.
  for (yy=[-bridge_screw_y,bridge_screw_y])
    translate([xpos+(yy<0 ? -bridge_pair_stagger_mm : bridge_pair_stagger_mm), yy, -bridge_nut_pocket_depth])
      linear_extrude(height=bridge_nut_pocket_depth+0.01)
        circle(d=bridge_nut_af/cos(30), $fn=6);
}
module bridge_lock_nut_traps() {
  // Captive M4-nut envelopes and tip-clearance bores in the moving toe deck.
  // The 1.65 mm Ø4.8 reliefs prevent M4x14 tips bearing on the nut-pocket roof.
  for (yy=[-bridge_screw_y,bridge_screw_y]) {
    xx = heel_split_x+bridge_lock_x+(yy<0 ? -bridge_pair_stagger_mm : bridge_pair_stagger_mm);
    translate([xx, yy, sole_bottom_z+bridge_stack_depth-0.01])
      linear_extrude(height=bridge_lock_nut_depth+0.01)
        circle(d=(bridge_lock_nut_af+0.35)/cos(30), $fn=6);
    translate([xx, yy, sole_bottom_z+bridge_stack_depth+bridge_lock_nut_depth-0.02])
      cylinder(h=bridge_lock_tip_relief_depth_mm+0.02, d=bolt_hole_d, $fn=48);
  }
}
module heel_core_cavity() {
  // REV R INTEGRATION FIX: replace the eight separated pocket cells and intervening ribs
  // with one continuous 55×23 mm cavity at the already-defined core reserve envelope.
  // The cavity opens at the underside for assembly before the outsole is bonded/retained.
  // Rev R1.2 thickens the local roof to 10.1 mm; analytical sensitivity is improved, not certified.
  // Do not scale or move the core without rechecking deck roof, channel web and stop/split clearance.
  translate([heel_core_envelope_x0, -heel_core_envelope_width/2, sole_bottom_z-0.01])
    cube([heel_core_envelope_length, heel_core_envelope_width,
          heel_core_roof_z - sole_bottom_z + 0.02]);
}
module toe_lightening_pockets() {
  // Rev R1.3: reinforce the forefoot roof to 10.1 mm and widen the central web
  // between the two underside pocket rows from 1 mm to 5 mm. These remain
  // geometry-only improvements; the deck is not structurally qualified.
  if (lightening_enabled)
    for (xx=[74,94,114,134]) {
      translate([xx,-lightening_pocket_outer_halfwidth_mm,sole_bottom_z-0.01])
        cube([16,lightening_pocket_width_mm,lightening_roof_z-sole_bottom_z+0.02]);
      translate([xx,lightening_pocket_center_web_mm/2,sole_bottom_z-0.01])
        cube([16,lightening_pocket_width_mm,lightening_roof_z-sole_bottom_z+0.02]);
    }
}
// ---------- HEEL MODULE ----------
module heel_deck() {
  difference() {
    translate([0,0,sole_bottom_z])
      linear_extrude(height=sole_thickness) heel_profile_2d();

    // Always reserve the spring/bladder installation cavity (independent of optional lightening).
    // The current cavity is not a pressure vessel and is not proof that supplier components fit.
    heel_core_cavity();

    // Captive undercut channels for the T-head rails under the heel/midfoot region; 0.5 mm
    // extra relief before the rail end avoids edge rubbing at the rail/channel entrance
    underside_rail_channels(rail_start_x-0.5, heel_split_x+0.01);

    // Bridge insert flange pocket
    bridge_recess_heel();

    // Bridge flange bolt holes; heads are recessed on the outsole side and M4 nuts sit in deck traps
    for (yy=[-bridge_screw_y,bridge_screw_y])
      translate([heel_split_x-10+(yy<0 ? -bridge_pair_stagger_mm : bridge_pair_stagger_mm), yy, sole_bottom_z-1])
        cylinder(h=sole_thickness+2, d=bolt_hole_d);
    bridge_nut_traps(heel_split_x-10);

    // Rail attachment holes; top counterbores are shallow for flush hardware
    for (yy=[-rail_y,rail_y])
      for (xx=[heel_split_x-60, heel_split_x-40]) {
        translate([xx, yy, sole_bottom_z-1])
          cylinder(h=sole_thickness+2, d=bolt_hole_d);
        translate([xx, yy, -2.2]) cylinder(h=2.4, d=8.0); // 2.2 mm counterbore from top surface plus 0.2 mm breakout
      }
  }
}

// ---------- TOE CARRIAGE ----------
module toe_deck_local() {
  // Reference-position geometry; translated by extension for a selected size.
  difference() {
    // Base sole plus locally enlarged pin bosses. The +Y side seats the pin head;
    // the -Y side has room for a recessed retaining ring and snap-ring access.
    union() {
      translate([0,0,sole_bottom_z])
        linear_extrude(height=sole_thickness) toe_profile_2d();
      translate([heel_split_x+30-9, 39.5, lock_z-9.0])
        cube([18, pin_entry_y-39.5, 18.0]);
      translate([heel_split_x+30-9, -pin_entry_y, lock_z-9.0])
        cube([18, pin_entry_y-39.5, 18.0]);
    }

    // Pocketed central deck zones; deliberately excluded from rails, cross-pin, and bridge.
    toe_lightening_pockets();

    // Longitudinal underside guide channels for both rails
    underside_rail_channels(heel_split_x-0.5, heel_split_x+slot_length+1.0);

    // Full-width 8.8 mm nominal pin tunnel preserved from the Rev K architecture.
    // The +Y side seats the single pin head; the -Y side has a shallow, larger pocket
    // for the external retaining ring (the ring must sit flush or below the shoe side face).
    translate([heel_split_x+30, -pin_entry_y, lock_z])
      rotate([-90,0,0]) cylinder(h=2*pin_entry_y, d=lock_hole_d);
    translate([heel_split_x+30, pin_entry_y, lock_z])
      rotate([90,0,0]) cylinder(h=pin_head_depth+0.2, d=pin_counterbore_d);
    translate([heel_split_x+30, -pin_entry_y, lock_z])
      rotate([-90,0,0]) cylinder(h=pin_keeper_recess_depth, d=pin_keeper_counterbore_d);

    // Secondary over-extension stop grooves. A small inward-facing lug on each fixed
    // rail travels in this slot. At EU46, the lug contacts the closed end; the indexed
    // lock pins remain mandatory for locking the chosen size during use.
    for (yy=[-rail_y,rail_y]) {
      translate([rail_end_x-3.0-4*mm_per_eu_size,
                 (yy > 0) ? yy-rail_head_width/2-2.5-fit_clearance : yy+rail_head_width/2-0.5-fit_clearance,
                 rail_z+rail_neck_height+0.5])
        cube([3.0+4*mm_per_eu_size+0.3, 3.0+2*fit_clearance,
              rail_height-rail_neck_height-1.0]);
    }

    // Bridge flange pocket in the toe-side overlap (moves with the toe module)
    bridge_recess_toe();

    // Bridge through-holes and recessed M4 hex-nut traps on the footbed side
    for (yy=[-bridge_screw_y,bridge_screw_y])
      translate([heel_split_x+10+(yy<0 ? -bridge_pair_stagger_mm : bridge_pair_stagger_mm), yy, sole_bottom_z-1])
        cylinder(h=sole_thickness+2, d=bolt_hole_d);
    bridge_nut_traps(heel_split_x+10);

    // Captive lock-nut access pockets are clear of the full-width cross-pin tunnel.
    bridge_lock_nut_traps();
  }
}

// ---------- FIXED SIDE RAILS ----------
// Rev P: stop-slot start corrected to eliminate maximum-extension interference. C1 rail-width correction remains: the prior 15 mm head width was justified by incorrect side-ligament arithmetic.
// The index-hole cylinder axis is Y, so rail_head_width is axial pin-bearing length, not a side-ligament dimension.
// Restore the Rev K 11 mm head-width baseline; the Ø8.3 mm bore leaves (13.8-8.3)/2 = 2.75 mm nominal
// top/bottom ligament in the vertical head section. Pin bearing, tear-out, material strength and fatigue remain
// unvalidated; do not narrow below the baseline without analysis. The carriage passage remains Ø8.8 mm.
// In a later physical build, substitute suitable metal bars with machined lock holes.
module side_rail_local(yy) {
  difference() {
    // T profile: a narrow lower stem and a wide upper head. It slides longitudinally
    // into the undercut channel and resists vertical pull-out geometrically.
    union() {
      translate([rail_start_x, yy-rail_stem_width/2, rail_z])
        cube([rail_length, rail_stem_width, rail_neck_height]);
      translate([rail_start_x, yy-rail_head_width/2, rail_z+rail_neck_height])
        cube([rail_length, rail_head_width, rail_height-rail_neck_height]);
      // Inner-facing endpoint lug; rides in the toe's stop groove and limits extension.
      translate([rail_end_x-3.0,
                 (yy > 0) ? yy-rail_head_width/2-2.5 : yy+rail_head_width/2-0.5,
                 rail_z+rail_neck_height+0.8])
        cube([3.0, 3.0, 2.0]);
    }

    // Three aligned Ø8.3 mm nominal index holes: proposed finish Ø8.30 +0.05/0.00 mm for an Ø8 mm pin.
    for (ee=[0, 2*mm_per_eu_size, 4*mm_per_eu_size])
      translate([heel_split_x+30+ee, yy+rail_head_width/2,
                 lock_z])
        rotate([90,0,0]) cylinder(h=rail_head_width, d=rail_index_hole_d);

    // Rev K mass-relief cavities are kept away from every indexed pin-hole neighborhood.
    // Each modeled cavity has nominal 2.5 mm side/top/bottom walls. The cavity geometry
    // is not a rated rail section and requires material-specific FEA and physical tests.
    if (rail_weight_relief) {
      // Pin-index holes and M4 rail-attachment tapped holes both need solid material around them.
      // The previous relief cavity crossed the two attachment pilots at x=split-60 and split-40,
      // leaving the nominal screw engagement interrupted by a void. C3 keeps a sidewall-sized
      // solid land (hole radius + rail_relief_sidewall_mm) around each attachment pilot.
      x_hole_first = heel_split_x + 30;
      x_hole_last = heel_split_x + 30 + 4*mm_per_eu_size;
      x_mount_1 = heel_split_x - 60;
      x_mount_2 = heel_split_x - 40;
      mount_keepout = rail_mount_pilot_d/2 + rail_relief_sidewall_mm;
      cavity_y = rail_head_width - 2*rail_relief_sidewall_mm;
      cavity_z = (rail_height-rail_neck_height) - 2*rail_relief_sidewall_mm;
      cavity_x0 = rail_start_x + rail_relief_end_margin_mm;
      cavity_x1 = x_hole_first - rail_index_hole_d/2 - rail_relief_sidewall_mm;
      cavity_x2 = x_hole_last + rail_index_hole_d/2 + rail_relief_sidewall_mm;
      cavity_x3 = rail_end_x - rail_relief_end_margin_mm;
      // Relief segment between the two attachment pilots, with full solid lands at both ends.
      cavity_a0 = max(cavity_x0, x_mount_1 + mount_keepout);
      cavity_a1 = min(cavity_x1, x_mount_2 - mount_keepout);
      // Main pre-index cavity begins only after the second attachment-pilot keepout.
      cavity_b0 = max(cavity_x0, x_mount_2 + mount_keepout);
      cavity_b1 = cavity_x1;
      if (cavity_a1 > cavity_a0)
        translate([cavity_a0, yy-cavity_y/2, rail_z+rail_neck_height+rail_relief_sidewall_mm])
          cube([cavity_a1-cavity_a0, cavity_y, cavity_z]);
      if (cavity_b1 > cavity_b0)
        translate([cavity_b0, yy-cavity_y/2, rail_z+rail_neck_height+rail_relief_sidewall_mm])
          cube([cavity_b1-cavity_b0, cavity_y, cavity_z]);
      // Post-index relief remains away from all indexed holes and the stop end.
      if (cavity_x3 > cavity_x2)
        translate([cavity_x2, yy-cavity_y/2, rail_z+rail_neck_height+rail_relief_sidewall_mm])
          cube([cavity_x3-cavity_x2, cavity_y, cavity_z]);
    }

    // Candidate Ø3.3 mm M4x0.7 tap-drill pilots for screws entering from the footbed side.
    // The relieved rail cavity is now excluded from 2.5 mm solid lands around both pilot locations.
    // Thread form, engagement, fastener grade/length, torque and tap specification remain unapproved.
    for (xx=[heel_split_x-60, heel_split_x-40])
      translate([xx, yy, rail_z-0.01]) cylinder(h=rail_height+0.02, d=rail_mount_pilot_d);
  }
}

// ---------- REV G TELESCOPING BRIDGE STRAPS ----------
// Rear strap is fixed to the heel deck and contains three pairs of indexed holes.
// Front strap is fixed to the moving toe carriage and carries one pair of clearance holes.
// At EU42/EU44/EU46, its holes align with the corresponding rear-strap pair. During
// adjustment, remove the two underside lock screws, slide the toe, then reinstall them.
// Captive M4 nut pockets travel with the toe deck. This provides a conceptual adjustable
// bridge load path; plate alloy, edge distances, fastener engagement and strength remain
// unvalidated and must be engineered before any physical load or human use.
module bridge_rear_strap() {
  difference() {
    translate([heel_split_x-bridge_rear_start, -bridge_flange_width/2, sole_bottom_z])
      cube([bridge_rear_start+bridge_rear_end, bridge_flange_width, bridge_flange_thickness]);

    // Heel anchor bolt pair.
    for (yy=[-bridge_screw_y,bridge_screw_y]) {
      anchor_x = heel_split_x-10+(yy<0 ? -bridge_pair_stagger_mm : bridge_pair_stagger_mm);
      translate([anchor_x, yy, sole_bottom_z-0.1])
        cylinder(h=bridge_flange_thickness+0.2, d=bolt_hole_d);
      translate([anchor_x, yy, sole_bottom_z-0.01])
        cylinder(h=bridge_screw_head_depth+0.01, d=bridge_screw_head_d);
    }

    // Three indexed pairs for EU42 / EU44 / EU46.
    for (ee=[0,2*mm_per_eu_size,4*mm_per_eu_size])
      for (yy=[-bridge_screw_y,bridge_screw_y]) {
        lock_x = heel_split_x+bridge_lock_x+ee+(yy<0 ? -bridge_pair_stagger_mm : bridge_pair_stagger_mm);
        translate([lock_x, yy, sole_bottom_z-0.1])
          cylinder(h=bridge_flange_thickness+0.2, d=bridge_lock_hole_d);
        translate([lock_x, yy, sole_bottom_z-0.01])
          cylinder(h=bridge_screw_head_depth+0.01, d=bridge_screw_head_d);
      }
  }
}
module bridge_front_strap() {
  difference() {
    translate([heel_split_x-bridge_front_start, -bridge_flange_width/2,
               sole_bottom_z+bridge_flange_thickness])
      cube([bridge_front_start+bridge_front_end, bridge_flange_width, bridge_flange_thickness]);

    // Toe anchor pair, bolted into the moving toe deck's captive nuts.
    // Source-matched M4 button-head relief follows extension. The cutter begins 0.01 mm below the face,
    // so its height is head depth + 0.01 mm to give the full 2.2 mm pocket without head interference.
    for (yy=[-bridge_screw_y,bridge_screw_y]) {
      anchor_x = heel_split_x+10+(yy<0 ? -bridge_pair_stagger_mm : bridge_pair_stagger_mm);
      translate([anchor_x, yy, sole_bottom_z+bridge_flange_thickness-0.1])
        cylinder(h=bridge_flange_thickness+0.2, d=bolt_hole_d);
      translate([anchor_x, yy, sole_bottom_z+bridge_flange_thickness-0.01])
        cylinder(h=bridge_screw_head_depth+0.01, d=bridge_screw_head_d);
    }

    // Locking pair aligns with one rear-strap index at each size.
    for (yy=[-bridge_screw_y,bridge_screw_y]) {
      lock_x = heel_split_x+bridge_lock_x+(yy<0 ? -bridge_pair_stagger_mm : bridge_pair_stagger_mm);
      translate([lock_x, yy, sole_bottom_z+bridge_flange_thickness-0.1])
        cylinder(h=bridge_flange_thickness+0.2, d=bridge_lock_hole_d);
    }
  }
}
module bridge_insert() {
  union() {
    bridge_rear_strap();
    translate([extension,0,0]) bridge_front_strap();
  }
}

// Non-structural fit envelope for early visualization only. It is not a textile pattern,
// last, breathable mesh model, or validated foot-clearance model. Sidewalls + two arch bands.
module upper_footprint_2d() {
  union() {
    heel_profile_2d();
    translate([extension,0,0]) toe_profile_2d();
    translate([heel_split_x-1,-32*width_scale])
      square([extension+2,64*width_scale]);
  }
}
module upper_arch_strap(xc) {
  // Soft-looking round-ended strap envelope; actual strap webbing/Velcro is a separate part.
  hull() {
    for (pt=[[-39,7],[-36,14],[-27,21],[0,25],[27,21],[36,14],[39,7]])
      translate([xc,pt[0]*width_scale,pt[1]]) sphere(r=2.0,$fn=12);
  }
}
module upper_wall_shell() {
  difference() {
    linear_extrude(height=upper_wall_height) upper_footprint_2d();
    translate([0,0,-0.1])
      linear_extrude(height=upper_wall_height+0.2)
        offset(delta=-upper_wall_thickness) upper_footprint_2d();
  }
}
module upper_fit_mockup() {
  union() {
    upper_wall_shell();
    upper_arch_strap(30+extension);
    upper_arch_strap(68+extension);
  }
}

// ---------- REV O SINGLE-HEADED LOCKING PIN + RETAINING RING ----------
// The earlier two-headed pin could not be removed through the assembled bores. Rev P
// uses a single 12 mm head at +Y and a standard-size external retaining-ring groove at -Y.
// Reference DIN 471 size-8 dimensions: groove root Ø7.6 mm, width 0.9 mm, ring thickness
// 0.8 mm, minimum end margin 0.6 mm; the referenced clearance envelope is Ø14.7 mm. Confirm
// every dimension and retention capacity against the purchased ring maker's current drawing.
// Component-closure patch: fastener dimensions matched to sourced Würth M4 button-head screws and ISO 4032 M4 nuts. The mesh remains a schematic assembly model, not a machining file or material strength proof.
module cross_pin_through() {
  difference() {
    union() {
      // Shaft spans the 90 mm side-face distance and projects 0.65 mm at the clip side.
      translate([0,pin_entry_y,0]) rotate([90,0,0])
        cylinder(h=2*pin_entry_y+pin_tail_extension, d=lock_pin_d);
      // Single +Y head seats in the 12.4 mm × 3 mm counterbore.
      translate([0,pin_entry_y,0]) rotate([90,0,0])
        cylinder(h=pin_head_depth, d=pin_head_d);
    }
    // Circumferential groove sized to the standard 8 mm shaft retaining-ring reference.
    translate([0,pin_groove_center_y+pin_groove_width/2,0]) rotate([90,0,0])
      difference() {
        cylinder(h=pin_groove_width, d=lock_pin_d+0.2, $fn=48);
        cylinder(h=pin_groove_width+0.02, d=pin_groove_root_d, $fn=48);
      }
  }
}
module external_retaining_ring_8mm() {
  // Simplified C-ring in the XZ plane; lugs/plier holes are omitted from this visualization.
  // Do not manufacture it from the mesh; use a catalog DIN 471 size-8 ring.
  rotate([90,0,0]) linear_extrude(height=pin_keeper_clip_thickness)
    difference() {
      circle(d=pin_keeper_clip_od, $fn=64);
      circle(d=pin_groove_root_d, $fn=48);
      polygon(points=[[0,-2.5],[16,-5.8],[16,5.8],[0,2.5]]);
    }
}
module positioned_pin(ee) {
  translate([heel_split_x+30+ee, 0, lock_z]) cross_pin_through();
}
module positioned_retaining_ring(ee) {
  translate([heel_split_x+30+ee,pin_groove_center_y+pin_keeper_clip_thickness/2,lock_z])
    external_retaining_ring_8mm();
}

// Retained legacy custom pin model for comparison only. It must NOT be used in Rev O
// assembly: oversized heads at both ends make it non-removable through the assembled bores.
module legacy_cross_pin(hollow=false) {
  if (hollow) {
    difference() {
      union() {
        translate([0, pin_entry_y, 0]) rotate([90,0,0]) cylinder(h=2*pin_entry_y, d=lock_pin_d);
        translate([0, pin_entry_y, 0]) rotate([90,0,0]) cylinder(h=pin_head_depth, d=pin_head_d);
        translate([0, -pin_entry_y, 0]) rotate([-90,0,0]) cylinder(h=pin_head_depth, d=pin_head_d);
      }
      translate([0, pin_entry_y-pin_head_depth, 0]) rotate([90,0,0])
        cylinder(h=2*(pin_entry_y-pin_head_depth), d=pin_core_bore_d);
    }
  } else {
    union() {
      translate([0, pin_entry_y, 0]) rotate([90,0,0]) cylinder(h=2*pin_entry_y, d=lock_pin_d);
      translate([0, pin_entry_y, 0]) rotate([90,0,0]) cylinder(h=pin_head_depth, d=pin_head_d);
      translate([0, -pin_entry_y, 0]) rotate([-90,0,0]) cylinder(h=pin_head_depth, d=pin_head_d);
    }
  }
}
module positioned_legacy_pin(ee, hollow=false) {
  translate([heel_split_x+30+ee,0,lock_z]) legacy_cross_pin(hollow);
}

// ---------- REV H CONTINUOUS OUTSOLE SYSTEM ----------
// Heel/toe tread pads are cut off 20 mm either side of the sliding joint.
// A planar serpentine TPU-like connector bridges the gap. Its centreline
// developed length is held at a target geometric 74 mm across the 40–66.7 mm
// span range by changing the lateral wave amplitude. This is kinematic CAD,
// not a validated material strain/fatigue model or ready-to-print rubber spec.
function revh_connector_span() = 40 + extension + 0.5;
function revh_connector_amp() = sqrt(max(0,
    pow(outsole_connector_developed_length/outsole_connector_segments,2) -
    pow(revh_connector_span()/outsole_connector_segments,2)));
function revh_connector_wave(i) = (i % 4 == 1) ? revh_connector_amp() :
                                  ((i % 4 == 3) ? -revh_connector_amp() : 0);
function revh_connector_width(i) = (outsole_connector_width_heel +
    (outsole_connector_width_toe-outsole_connector_width_heel)*i/outsole_connector_segments)*width_scale;
function revh_connector_x0() = heel_split_x - 20;
function revh_connector_x1() = heel_split_x + extension + 20;
module revh_heel_pad_blank() {
    translate([0,0,sole_bottom_z-outsole_pad_thickness])
        linear_extrude(height=outsole_pad_thickness) heel_profile_2d();
}
module revh_toe_pad_blank() {
    translate([extension,0,sole_bottom_z-outsole_pad_thickness])
        linear_extrude(height=outsole_pad_thickness) toe_profile_2d();
}
module outsole_heel_pad() {
    difference() {
        intersection() {
            revh_heel_pad_blank();
            translate([-200,-100,sole_bottom_z-outsole_pad_thickness-1])
                cube([heel_split_x-20+200,200,outsole_pad_thickness+2]);
        }
        // Top-side relief channels leave 1.8 mm of tread skin below fixed rails/bridge.
        // This prevents the removable outsole from pinching the mechanism in nominal CAD.
        for (yy=[-rail_y,rail_y])
            translate([rail_start_x-0.5, yy-(rail_stem_width+2*fit_clearance)/2,
                       sole_bottom_z-outsole_relief_depth])
                cube([heel_split_x-20-(rail_start_x-0.5)+0.6,
                      rail_stem_width+2*fit_clearance,outsole_relief_depth+0.1]);
        translate([heel_split_x-40,-(bridge_flange_width/2+bridge_fit_clearance),sole_bottom_z-outsole_relief_depth])
            cube([20.6,bridge_flange_width+2*bridge_fit_clearance,outsole_relief_depth+0.1]);
        // Shallow transverse tread sipes leave >3 mm nominal material away from reliefs.
        for (xx=[-138,-126,-114,-102,-90,-78,-66])
            translate([xx,-100,sole_bottom_z-outsole_pad_thickness-0.1])
                rotate([0,0,25]) cube([0.9,200,0.85]);
    }
}
module outsole_toe_pad() {
    difference() {
        intersection() {
            revh_toe_pad_blank();
            translate([heel_split_x+extension+20,-100,sole_bottom_z-outsole_pad_thickness-1])
                cube([250,200,outsole_pad_thickness+2]);
        }
        // Moving-carriage rail relief and bridge-strap relief, cut from the pad top.
        xrail0 = max(heel_split_x+extension+20, rail_start_x);
        xrail1 = min(heel_split_x+extension+20+250, rail_end_x);
        for (yy=[-rail_y,rail_y])
            translate([xrail0, yy-(rail_stem_width+2*fit_clearance)/2, sole_bottom_z-outsole_relief_depth])
                cube([max(0.1,xrail1-xrail0),rail_stem_width+2*fit_clearance,outsole_relief_depth+0.1]);
        xbridge0 = heel_split_x+extension+20;
        xbridge1 = min(heel_split_x+extension+60, heel_split_x+extension+20+250);
        translate([xbridge0,-(bridge_flange_width/2+bridge_fit_clearance),sole_bottom_z-outsole_relief_depth])
            cube([max(0.1,xbridge1-xbridge0),bridge_flange_width+2*bridge_fit_clearance,outsole_relief_depth+0.1]);
        for (i=[0:10]) {
            xx = heel_split_x + extension + 32 + 9*i;
            translate([xx,-100,sole_bottom_z-outsole_pad_thickness-0.1])
                rotate([0,0,-25]) cube([0.9,200,0.85]);
        }
    }
}
module revh_connector_2d() {
    x0 = revh_connector_x0()-0.25; // 0.25 mm overlap ensures a boolean-connected assembly
    x1 = revh_connector_x1()+0.25;
    span = x1-x0;
    polygon(points=concat(
        [for (i=[0:outsole_connector_segments])
            [x0+span*i/outsole_connector_segments,
             revh_connector_wave(i)+revh_connector_width(i)/2]],
        [for (i=[outsole_connector_segments:-1:0])
            [x0+span*i/outsole_connector_segments,
             revh_connector_wave(i)-revh_connector_width(i)/2]]
    ));
}
module outsole_flex_connector() {
    difference() {
        translate([0,0,sole_bottom_z-outsole_pad_thickness])
            linear_extrude(height=outsole_pad_thickness) revh_connector_2d();
        // Fine grooves are cut from the ground side only; they do not sever the strip.
        // Relief around the two rails and twin bridge straps. The ground-facing
        // skin stays continuous, but is only 1.8 mm thick in these channels.
        for (yy=[-rail_y,rail_y])
            translate([revh_connector_x0()-0.3, yy-(rail_stem_width+2*fit_clearance)/2,
                       sole_bottom_z-outsole_relief_depth])
                cube([revh_connector_span()+0.6,rail_stem_width+2*fit_clearance,outsole_relief_depth+0.1]);
        translate([revh_connector_x0()-0.3,-(bridge_flange_width/2+bridge_fit_clearance),sole_bottom_z-outsole_relief_depth])
            cube([revh_connector_span()+0.6,bridge_flange_width+2*bridge_fit_clearance,outsole_relief_depth+0.1]);
        for (i=[1:15]) {
            gx = revh_connector_x0() + (revh_connector_x1()-revh_connector_x0())*i/16;
            translate([gx,-100,sole_bottom_z-outsole_pad_thickness-0.1])
                cube([0.65,200,outsole_connector_tread_depth+0.1]);
        }
    }
}
module outsole_assembly() {
    union() {
        outsole_heel_pad();
        outsole_toe_pad();
        outsole_flex_connector();
    }
}

// ---------- REV H FOOTBED + UPPER DETAILS ----------
// Shells and strap shapes are visualization geometry. They are not textile patterns,
// ventilation/thermal testing, fit-validated lasts, or actual Velcro hardware.
// Rev Q removable EVA inserts: heel is 7 mm, forefoot 5 mm. A rear tongue on the moving
// forefoot insert slides in a bottom pocket in the heel insert. The 45 mm tongue exceeds the
// maximum 26.667 mm size extension by 18.333 mm, preserving coverage at EU46. Foam properties,
// friction, seam wear and compression-set still need supplier confirmation and bench cycling.
module footbed_heel_piece() {
  difference() {
    translate([0,0,footbed_z])
      linear_extrude(height=footbed_heel_thickness)
        offset(delta=-footbed_edge_inset) heel_profile_2d();
    // Underside sliding pocket: leave a nominal 1.75 mm top skin above the 5.25 mm pocket.
    // The moving EVA tongue is 5.0 mm thick and leaves 0.25 mm nominal vertical clearance.
    translate([heel_split_x-footbed_lap_length-footbed_lap_clearance,
               -footbed_lap_halfwidth-footbed_lap_clearance, footbed_z-0.10])
      cube([footbed_lap_length+2*footbed_lap_clearance,
            2*(footbed_lap_halfwidth+footbed_lap_clearance), footbed_forefoot_thickness+0.25+0.10]);
  }
}
module footbed_toe_piece() {
  // Rev R1.4 M4x16 toe-anchor: bearing face is z=sole_bottom+4.5 mm; tip is z=-0.1 mm.
  // The footbed underside starts at z=+0.15 mm, retaining 0.25 mm nominal clearance.
  translate([extension,0,footbed_z])
    linear_extrude(height=footbed_forefoot_thickness)
      offset(delta=-footbed_edge_inset) toe_profile_2d();
}
module footbed_toe_lap_tongue() {
  translate([extension,0,footbed_z])
    linear_extrude(height=footbed_forefoot_thickness)
      polygon(points=[
        [heel_split_x-footbed_lap_length, -footbed_lap_halfwidth],
        [heel_split_x, -footbed_lap_halfwidth],
        [heel_split_x, footbed_lap_halfwidth],
        [heel_split_x-footbed_lap_length, footbed_lap_halfwidth]
      ]);
}
module footbed_insert() {
  union() {
    footbed_heel_piece();
    footbed_toe_piece();
    footbed_toe_lap_tongue();
  }
}

// Non-manufacturing visualization of the reserved 55×23×10.5 mm core envelope.
// Rev R makes the matching cavity real subtractive geometry in heel_deck(). These colored
// split zones remain size placeholders only—not spring/bladder geometry, selected components,
// seats/retainers, routing, or pressure-rated parts. Do not export as a physical component.
module heel_core_envelope_study() {
  color([0.10,0.50,0.95,0.32])
    translate([heel_core_envelope_x0,-heel_core_envelope_width/2,heel_core_envelope_z0])
      cube([heel_core_envelope_length,heel_core_envelope_width,heel_core_envelope_height]);
  // Schematic split only: 24 mm spring reserve, 3 mm nominal separator, 28 mm bladder reserve.
  // These bounding zones must be replaced by supplier geometry and verified mounting/ports.
  color([0.15,0.72,0.38,0.42])
    translate([heel_core_envelope_x0,-heel_core_envelope_width/2,heel_core_envelope_z0])
      cube([24,heel_core_envelope_width,heel_core_envelope_height]);
  color([0.95,0.58,0.12,0.42])
    translate([heel_core_envelope_x0+27,-heel_core_envelope_width/2,heel_core_envelope_z0])
      cube([28,heel_core_envelope_width,heel_core_envelope_height]);
}
module toe_vamp_outer() {
  // Broaden the textile/vamp envelope so it overlaps the sidewall zone; the width
  // preset scales it laterally. This is an upper-envelope mockup, not a sewn pattern.
  scale([1,upper_vamp_width_scale*width_scale,1])
    hull() {
      translate([36,-25,7]) scale([13,7,8]) sphere(r=1,$fn=20);
      translate([36, 25,7]) scale([13,7,8]) sphere(r=1,$fn=20);
      translate([65,-28,10]) scale([18,6,9]) sphere(r=1,$fn=20);
      translate([65, 28,10]) scale([18,6,9]) sphere(r=1,$fn=20);
      translate([95,-23,9]) scale([16,8,7]) sphere(r=1,$fn=20);
      translate([95, 23,9]) scale([16,8,7]) sphere(r=1,$fn=20);
      translate([121,-14,6]) scale([12,8,5]) sphere(r=1,$fn=20);
      translate([121, 14,6]) scale([12,8,5]) sphere(r=1,$fn=20);
      translate([136,-7,4]) scale([9,7,4]) sphere(r=1,$fn=20);
      translate([136, 7,4]) scale([9,7,4]) sphere(r=1,$fn=20);
    }
}
module toe_vamp_inner() {
  scale([1,upper_vamp_width_scale*width_scale,1])
    hull() {
      translate([36,-25,6]) scale([11,5,7]) sphere(r=1,$fn=20);
      translate([36, 25,6]) scale([11,5,7]) sphere(r=1,$fn=20);
      translate([65,-28,9]) scale([16,4.5,7.5]) sphere(r=1,$fn=20);
      translate([65, 28,9]) scale([16,4.5,7.5]) sphere(r=1,$fn=20);
      translate([95,-23,8]) scale([14,6.5,5.5]) sphere(r=1,$fn=20);
      translate([95, 23,8]) scale([14,6.5,5.5]) sphere(r=1,$fn=20);
      translate([121,-14,5]) scale([10,6.5,3.6]) sphere(r=1,$fn=20);
      translate([121, 14,5]) scale([10,6.5,3.6]) sphere(r=1,$fn=20);
      translate([136,-7,3.5]) scale([7,5,3]) sphere(r=1,$fn=20);
      translate([136, 7,3.5]) scale([7,5,3]) sphere(r=1,$fn=20);
    }
}
module toe_vamp_shell() {
  difference() {
    toe_vamp_outer();
    toe_vamp_inner();
    // Expanded breathable-zone sample; hole size/pitch still need tear testing.
    for (xx=[68,78,88,98,108])
      for (yy=[-18,-9,0,9,18])
        translate([xx,yy*upper_vamp_width_scale*width_scale,-3])
          cylinder(h=28,d=vent_hole_d,$fn=12);
  }
}
module heel_counter_outer() {
    hull() {
        translate([-134,-18,9]) scale([10,9,12]) sphere(r=1,$fn=20);
        translate([-134, 18,9]) scale([10,9,12]) sphere(r=1,$fn=20);
        translate([-112,-25,10]) scale([12,6,10]) sphere(r=1,$fn=20);
        translate([-112, 25,10]) scale([12,6,10]) sphere(r=1,$fn=20);
    }
}
module heel_counter_inner() {
    hull() {
        translate([-134,-18,8]) scale([8,7,10]) sphere(r=1,$fn=20);
        translate([-134, 18,8]) scale([8,7,10]) sphere(r=1,$fn=20);
        translate([-112,-25,9]) scale([10,4.5,8]) sphere(r=1,$fn=20);
        translate([-112, 25,9]) scale([10,4.5,8]) sphere(r=1,$fn=20);
    }
}
module heel_counter_shell() {
    scale([1,width_scale,1])
      difference() { heel_counter_outer(); heel_counter_inner(); }
}
module maroon_lateral_overlays() {
    // Side reinforcements follow the selected width envelope.
    for (side=[-1,1])
        hull() {
            translate([-82,side*27*width_scale,10]) scale([17,3,5]) sphere(r=1,$fn=16);
            translate([-48,side*31*width_scale,15]) scale([22,3,5]) sphere(r=1,$fn=16);
            translate([-15,side*31*width_scale,14]) scale([16,3,4]) sphere(r=1,$fn=16);
        }
}
module velcro_cross_strap(xc, halfspan=42, zc=17) {
    // Broad instep bridge intentionally overlaps the sidewall envelope at both ends;
    // the CAD patch is not actual hook-and-loop/webbing or a tested anchor.
    hull() {
        translate([xc,-halfspan,zc]) scale([10,3.1,1.6]) sphere(r=1,$fn=16);
        translate([xc, halfspan,zc]) scale([10,3.1,1.6]) sphere(r=1,$fn=16);
    }
}
module upper_strap_anchor_patch(xc, y_center, zc=16.8) {
    hull() {
        translate([xc-7,y_center-0.6,zc]) scale([7,2.2,2.5]) sphere(r=1,$fn=16);
        translate([xc+7,y_center+0.6,zc]) scale([7,2.2,2.5]) sphere(r=1,$fn=16);
    }
}
module upper_strap_anchor_doublers() {
    for (side=[-1,1]) {
        upper_strap_anchor_patch(15+extension*0.25, side*44*width_scale);
        upper_strap_anchor_patch(48+extension*0.35, side*47*width_scale);
    }
}
module upper_velcro_straps() {
    union() {
        velcro_cross_strap(15+extension*0.25,42*width_scale,17);
        velcro_cross_strap(48+extension*0.35,45*width_scale,18);
    }
}
module instep_tongue() {
    hull() {
        translate([4+extension*0.20,0,12]) scale([13,15,2]) sphere(r=1,$fn=16);
        translate([43+extension*0.35,0,16]) scale([19,17,2.2]) sphere(r=1,$fn=16);
    }
}
module upper_complete_mockup() {
    // White sidewall/midsole-facing shell + separate vamp/counter, overlays and Velcro bands.
    color([0.92,0.91,0.88,0.88]) upper_wall_shell();
    color([0.94,0.93,0.90]) translate([extension,0,0]) toe_vamp_shell();
    color([0.30,0.035,0.12]) heel_counter_shell();
    color([0.30,0.035,0.12]) maroon_lateral_overlays();
    color([0.92,0.90,0.86]) instep_tongue();
    color([0.30,0.035,0.12]) upper_velcro_straps();
    color([0.30,0.035,0.12]) upper_strap_anchor_doublers();
}

// ---------- FULL ASSEMBLY ----------
module assembly(show_lock_pin=true, show_upper=false) {
  color([0.92,0.92,0.90]) heel_deck();
  color([0.95,0.95,0.93]) translate([extension,0,0]) toe_deck_local();
  color([0.18,0.18,0.20]) bridge_rear_strap();
  color([0.30,0.30,0.32]) translate([extension,0,0]) bridge_front_strap();
  color([0.28,0.28,0.30]) side_rail_local(-rail_y);
  color([0.28,0.28,0.30]) side_rail_local(rail_y);
  if (show_fasteners && show_lock_pin) {
    color([0.34,0.05,0.13]) positioned_pin(extension);
    color([0.18,0.18,0.20]) positioned_retaining_ring(extension);
  }
  if (show_upper) color([0.48,0.10,0.22,0.35]) upper_fit_mockup();
}

// ---------- EXPORT SELECTOR ----------
if (part == "assembly") {
  assembly(true, false);
} else if (part == "assembly_fixed") {
  assembly(true, false);
} else if (part == "heel") {
  heel_deck();
} else if (part == "toe") {
  translate([extension,0,0]) toe_deck_local();
} else if (part == "toe_local") {
  // Local-coordinate copy for articulated simulation: toe front edge starts at x=0.
  translate([-heel_split_x,0,0]) toe_deck_local();
} else if (part == "bridge") {
  bridge_insert();
} else if (part == "bridge_rear") {
  bridge_rear_strap();
} else if (part == "bridge_front") {
  translate([extension,0,0]) bridge_front_strap();
} else if (part == "upper_mockup") {
  upper_fit_mockup();
} else if (part == "upper_complete_mockup") {
  upper_complete_mockup();
} else if (part == "upper_wall_shell") {
  upper_wall_shell();
} else if (part == "upper_lateral_overlays") {
  maroon_lateral_overlays();
} else if (part == "upper_velcro_straps") {
  upper_velcro_straps();
} else if (part == "upper_strap_anchor_doublers") {
  upper_strap_anchor_doublers();
} else if (part == "upper_tongue") {
  instep_tongue();
} else if (part == "footbed_insert") {
  footbed_insert();
} else if (part == "footbed_heel_piece") {
  footbed_heel_piece();
} else if (part == "footbed_toe_piece") {
  footbed_toe_piece();
} else if (part == "footbed_toe_lap_tongue") {
  footbed_toe_lap_tongue();
} else if (part == "heel_core_envelope_study") {
  heel_core_envelope_study();
} else if (part == "toe_vamp_shell") {
  translate([extension,0,0]) toe_vamp_shell();
} else if (part == "heel_counter_shell") {
  heel_counter_shell();
} else if (part == "outsole_heel_pad") {
  outsole_heel_pad();
} else if (part == "outsole_toe_pad") {
  outsole_toe_pad();
} else if (part == "outsole_flex_connector") {
  outsole_flex_connector();
} else if (part == "outsole_assembly") {
  outsole_assembly();
} else if (part == "full_mockup") {
  assembly(true, false);
  color([0.22,0.21,0.21]) outsole_assembly();
  color([0.94,0.93,0.90]) footbed_insert();
  upper_complete_mockup();
} else if (part == "rail_left") {
  side_rail_local(-rail_y);
} else if (part == "rail_right") {
  side_rail_local(rail_y);
} else if (part == "pin_through") {
  positioned_pin(extension);
} else if (part == "pin_through_hollow") {
  // Legacy hollow custom-pin mass study only; not used in Rev P assembly.
  positioned_legacy_pin(extension, true);
} else if (part == "pin_through_solid") {
  positioned_pin(extension);
} else if (part == "pin_retaining_clip") {
  positioned_retaining_ring(extension);
} else if (part == "pin_legacy_solid") {
  positioned_legacy_pin(extension, false);
} else {
  echo("Unknown part selector. Use assembly, assembly_fixed, heel, toe, toe_local, bridge, bridge_rear, bridge_front, upper_mockup, upper_complete_mockup, upper_wall_shell, upper_lateral_overlays, upper_velcro_straps, upper_strap_anchor_doublers, upper_tongue, footbed_insert, footbed_heel_piece, footbed_toe_piece, footbed_toe_lap_tongue, heel_core_envelope_study, toe_vamp_shell, heel_counter_shell, outsole_heel_pad, outsole_toe_pad, outsole_flex_connector, outsole_assembly, full_mockup, rail_left, rail_right, pin_through, pin_through_solid, pin_retaining_clip, pin_legacy_solid, or pin_through_hollow (legacy only).");
}
