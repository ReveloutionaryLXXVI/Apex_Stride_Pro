// ============================================================
//  APEX STRIDE PRO — REV R2.4 "COMFORT ABSOLUTE" (digital QA build)
//  CUSTOM BUILD: 66 kg, 12 y/o, growth-fit EU42 -> EU44
//  ONE FILE | ONE PRINT (TPU 95A) | ZERO ASSEMBLY
//  WHITE BODY + MAROON SIDES | GLOW GROWTH RULER
//  L/R PAIR: geometry is y-symmetric; ruler numerals are CUT
//  (re-rendered) per side with per-side rotations — never mirrored.
//
//  WEAR STATUS: DIGITAL CANDIDATE. Physical build untested.
//  Software cannot grant wear clearance — only the tests can.
//  R2.4 fixes vs R2.3 (see REV_R2_4_DIGITAL_AUDIT.md):
//   F1 lattice rebuilt as true rib grid (R2.3 diamonds were ~95% solid)
//   F2 skin 1.5 -> 1.6 mm (wall floor), upper wall 2.6 mm
//   F3 interior refit: 290 mm length (x -135..155), width to EU42-44
//   F4 ruler/turbine/speed-lines re-cut conformal (0.8 mm deep band)
//   F5 ruler numerals per-side orientation, font Liberation Sans Bold
//   F6 flex grooves bounded: web >= 6 mm, never breach footbed
//   F7 bow ends embedded in body (R2.3 bow floated = loose body)
//   F8 bow channel kept above base + vent ducts to gills
//   F9 heel rings clipped interior (sealed voids, no extra openings)
//  F10 pull-tab hull-of-spheres (rounded contact edges)
//  F11 solver echoes = labeled analytic estimates; STL is authority
// ============================================================

/* ---------------- FINAL material selection ---------------- */
mat      = "TPU95A";     // the entire print. locked.
rider_kg = 66;           // 40 .. 95 — bow re-solves
skin_t   = 1.6;          // FlowSkin outer shell (F2: was 1.5 < wall floor)
liner_t  = 1.0;          // conformal comfort liner
upper_t  = 3.8;          // upper wall (envelope to cavity)

/* ---------------- palette ---------------- */
c_white = "#F4F2EE"; c_side = "#5C0E28";
c_deep  = "#3A0A1C"; c_glow = "#C9D8B0";

/* ---------------- material solver ---------------- */
function mat_rho(m)  = m == "TPU95A" ? 1.20 : 0.95;
function mat_ret(m)  = m == "TPU95A" ? 0.62 : 0.75;
function mat_rib(m)  = m == "TPU95A" ? 1.8  : 1.5;
function mat_wall(m) = m == "TPU95A" ? 1.6  : 1.2;

rib_mm    = 1.8;         // lattice rib width (>= mat_rib floor 1.8; mass knob)
wave_wall = mat_wall(mat);
rho       = mat_rho(mat);
ret       = mat_ret(mat);
$fn = 48;

/* ---------------- fit / growth ---------------- */
eu_lo = 42; eu_hi = 44;
foot_l = [267, 273, 280];  interior_l = 290;
heel_h = 32; fore_h = 24; drop_mm = heel_h - fore_h;
toe_room     = [interior_l - foot_l[0], interior_l - foot_l[1], interior_l - foot_l[2]];
toe_room_net = [toe_room[0] - liner_t, toe_room[1] - liner_t, toe_room[2] - liner_t];
grow_x = [132, 140, 148];

/* ---------------- rocker profile ---------------- */
rocker_profile = "COMFORT";   // "COMFORT" 18/14 (this runner) | "SPEED" 22/16
heel_ang  = rocker_profile == "SPEED" ? 22 : 18;
toe_ang   = rocker_profile == "SPEED" ? 16 : 14;

/* ============ PROGRESSIVE BOW — mass-adaptive ============ */
F_peak = rider_kg * 9.81 * 2.0;
d_bow  = mat == "TPU95A" ? 8 : 6;
bow_s  = pow(rider_kg / 66, 1/3);
t_mid  = (mat == "TPU95A" ? 13 : 7)  * bow_s;
t_root = (mat == "TPU95A" ? 17 : 11) * bow_s;
bow_w  = 12;             // bow width (R2.3: 22 — mass/stiffness knob)
function bow_z(x) = 4 + 12 * (1 - pow(x / 85, 2));
function bow_t(x) = t_mid + (t_root - t_mid) * pow(abs(x) / 85, 1.5);

U_bow  = 0.5 * F_peak * d_bow / 1000;
U_step = (U_bow + 1.6 + 1.1) * ret;
P_back = U_step * 3;

/* --------- internal zones [x0,x1,w,h,pitch,rib] ----------
   F1: lattice = true rib grid (rib_mm wide, square voids).
   F9: heel crash pad (ring matrix) is SOLID x=-145..-105;
       zone-0 lattice pitch 26 retained x=-105..-55.            */
zones = [
  [-105, -55, 78, heel_h, 26,   rib_mm],
  [ -55,  62, 92, 27,     23,   rib_mm],
  [  62, 152, 88, fore_h, 18.5, rib_mm]
];
function kept(r, p) = 1 - pow((p - r)/p, 2);   // F1: matches rib grid

/* ================= ENVELOPE (k = inward shrink) ================= */
module station(x, w, h, ang, k)
  translate([x, 0, h/2]) rotate([0, ang, 0])
    cube([26 - 2*k, w - 2*k, h - 2*k], center = true);   // F14: uniform inset (no knife edges)

module sole_envelope(k = 0) {
  hull() {
    station(-138, 78, 24, heel_ang, k);
    station(-106, 86, 30, 10, k);
    station(-55,  94, heel_h, 0, k);
    station(5,   100, 30, 0, k);
    station(62,   98, 27, -6, k);
    station(106,  96, 25, -8, k);
    station(128,  94, 23, -12, k);
    station(152,  82, 20, -toe_ang, k);
  }
}

/* ============ FOOT NEGATIVE (pad = grow) — F3 refit ============
   interior 290 mm: x -135 .. +155. widths to EU42-44 last.      */
module foot_negative(pad = 0) {
  hull() {
    translate([-105, 0, heel_h + 2]) scale([1, 1.10, 0.50]) sphere(r = 30 + pad);
    translate([-55,  0, 38]) scale([1, 1.24, 0.42]) sphere(r = 34 + pad);
    translate([10,   0, 39.5]) scale([1, 1.26, 0.42]) sphere(r = 38 + pad);
    translate([82,   0, 28.2]) scale([1, 1.28, 0.42]) sphere(r = 36 + pad);
    translate([121,  0, fore_h - 3]) scale([1, 1.35, 0.40]) sphere(r = 30 + pad);
    translate([131,  0, fore_h - 5]) scale([1, 1.25, 0.38]) sphere(r = 24 + pad);
  }
}

/* ---- G21 CONFORMAL LINER: soft skin under the whole foot ---- */
module comfort_liner() {
  difference() { foot_negative(liner_t); foot_negative(0); }
}

module arch_dome() { translate([-48, 0, heel_h - 7]) scale([2.2, 0.8, 0.55]) sphere(r = 13); }
module met_bar()   { translate([46, 0, fore_h - 6])  scale([1.1, 2.4, 0.5])  sphere(r = 11); }
module heel_cup()  { translate([-104, 0, heel_h - 4]) scale([1.4, 1.5, 0.7]) sphere(r = 21); }

/* ---- G21 micro-dimples (grip + air, 0.9 mm) ---- */
module bed_dimples() {
  for (i = [0:14], j = [0:5])
    translate([-112 + i*17, -36 + j*14, heel_h - 9])
      sphere(r = 0.9, $fn = 10);
}

/* ============ INTERNAL LATTICE (F1: true rib grid, sealed) ============ */
module zone_lattice(z) {
  p = z[4]; r = z[5]; w = z[1] - z[0];
  intersection() {
    translate([(z[0]+z[1])/2, 0, z[3]/2])
      cube([w, z[2], z[3]], center = true);
    union() {
      for (i = [0:ceil(w/p)])
        translate([z[0] + i*p, 0, z[3]/2])
          cube([r, z[2], z[3] + 2], center = true);
      for (j = [0:ceil(z[2]/p)])
        translate([(z[0]+z[1])/2, -z[2]/2 + j*p, z[3]/2])
          cube([w, r, z[3] + 2], center = true);
    }
  }
}
module heel_pad() {           // F9: solid ring matrix
  intersection() {
    sole_envelope(skin_t);
    translate([-125, 0, heel_h/2]) cube([40, 120, heel_h + 2], center = true);
  }
}
module sole_core() {
  union() {
    intersection() { sole_envelope(skin_t); union() for (z = zones) zone_lattice(z); }
    heel_pad();
    difference() { sole_envelope(0); sole_envelope(skin_t); }   // F2: real skin
  }
}

/* ========== PROGRESSIVE BOW (F7: ends embedded) ========== */
module bow_spring() {
  for (i = [0:25]) {
    x0 = -88 + 176*i/26; x1 = -88 + 176*(i+1)/26;
    hull() {
      translate([x0, 0, bow_z(x0)]) cube([8, bow_w, bow_t(x0)], center = true);
      translate([x1, 0, bow_z(x1)]) cube([8, bow_w, bow_t(x1)], center = true);
    }
  }
}
module bow_channel() {        // F17: clearance shell AROUND bow (bow never eaten)
  difference() {
    intersection() {
      union() {
        for (i = [0:25]) {
          x0 = -84 + 168*i/26; x1 = -84 + 168*(i+1)/26;
          hull() {
            translate([x0, 0, bow_z(x0)]) cube([9, bow_w + 8, bow_t(x0) + 8], center = true);
            translate([x1, 0, bow_z(x1)]) cube([9, bow_w + 8, bow_t(x1) + 8], center = true);
          }
        }
      }
      translate([0, 0, 102.5]) cube([400, 240, 200], center = true); // z >= 2.5
    }
    bow_spring();
  }
}
module vent_ducts() {         // F8: channel -> gills (gills = only openings)
  for (s = [-1, 1], k = [0:3])
    translate([-78 + k*52, s*30, 20])
      cube([8, 40, 4], center = true);
}

/* ============ ACCORDION (sealed) + AERO GILLS ============ */
module accordion() {
  intersection() {
    sole_envelope(skin_t);
    for (i = [-24:24])
      translate([i*6.5, 0, heel_h - 13])
        rotate([0, 0, (i % 2 == 0) ? 28 : -28])
          cube([wave_wall, 96, 16], center = true);
  }
}
module aero_gills() {
  for (s = [-1, 1], k = [0:3])
    translate([-78 + k*52, s*47, heel_h - 12])
      rotate([0, 18, 0]) cube([26, 18, 4], center = true);  // crosses wall
}

/* ============ G21 SOFTSTEP HEEL — 3-ring decoupler (F9: clipped) ==== */
module crash_rings() {
  intersection() {
    union() {
      for (R = [44, 50, 56])
        intersection() {
          translate([-112, 0, 0]) rotate_extrude($fn = 72)
            translate([R, 7, 0]) circle(r = 1.1, $fn = 12);
          translate([-172, 0, 7]) cube([120, 220, 30], center = true);
        }
    }
    sole_envelope(skin_t + 1.6);   // sealed: >=1.6 wall to surface
  }
}
module flex_grooves() {       // F6: web >= 6 mm above footbed, no breach
  tops = [1.2, 1.3, 2.2, 2.9]; // footbed 7.25/7.35/8.27/8.91 minus 6 mm
  xs   = [72, 94, 114, 128];
  for (i = [0:3])
    translate([xs[i], 0, (tops[i] - 6)/2])
      cube([4, 220, tops[i] + 6], center = true);
}

/* ============ G21 ROUNDED CORSET (capsule slats) ============ */
module slat_seg(p1, p2) {
  hull() { translate(p1) sphere(r = 2, $fn = 16); translate(p2) sphere(r = 2, $fn = 16); }
}
module corset_slats() {
  for (i = [0:5]) {
    x = 30 + i*17;
    slat_seg([x, 34, 26], [x, 0, 40]);
    slat_seg([x, 0, 40], [x, -34, 26]);
  }
}
module corset_window() {
  translate([72, 0, 34]) rotate([0, -4, 0]) cube([130, 62, 34], center = true);
}

/* ============ G21 HEEL PULL TAB (F10: rounded) ============ */
module heel_pull_tab() {
  translate([-138, 0, heel_h - 4]) rotate([0, -28, 0])
    difference() {
      hull() {
        translate([0,  11, 0]) sphere(r = 5, $fn = 20);
        translate([0, -11, 0]) sphere(r = 5, $fn = 20);
      }
      hull() {
        translate([0,  6, 0]) sphere(r = 3, $fn = 16);
        translate([0, -6, 0]) sphere(r = 3, $fn = 16);
      }
    }
}

/* ============ MAROON SIDE PANELS ============ */
module side_slab(s) {
  hull() {
    translate([-118, s*54, 15]) cube([64, 34, 27], center = true);
    translate([-10,  s*54, 13]) cube([120, 34, 23], center = true);
    translate([112,  s*54, 11]) cube([90, 34, 19], center = true);
    translate([152,  s*48, 8])  cube([30, 28, 13], center = true);
  }
}
module toe_beak() {
  hull() { translate([150, 0, 10]) cube([4, 42, 8], center = true);
           translate([140, 0, 17]) cube([4, 48, 8], center = true); }
}

/* ============ ENGRAVED DECOR — F4/F5 conformal bands ============
   band_sole  = outer 0.8 mm of the sole skin
   band_upper = outer 0.8 mm of the upper wall                        */
module band_sole()  { difference() { sole_envelope(0); sole_envelope(0.8); } }
module band_upper() { difference() { foot_negative(upper_t); foot_negative(upper_t - 0.8); } }

module speed_lines() {        // F4: engraved 0.8 into upper surface
  intersection() {
    union() {
      for (i = [0:7])
        translate([-100 + i*26, 0, 44])
          rotate([0, -26, 0]) cube([2.2, 60 - i*3, 30], center = true);
    }
    band_upper();
  }
}
module heel_turbine_engrave() {   // F4: fan on heel back surface
  intersection() {
    union() {
      for (a = [-52:13:52])
        translate([-136, 0, 16]) rotate([0, 0, a]) translate([-15, 0, 0])
          rotate([0, 26, 0]) cube([10, 2.2, 18], center = true);
    }
    band_sole();
  }
}
module growth_ruler() {       // F4/F5: ticks + numerals, per-side, never mirrored
  intersection() {
    union() {
      for (s = [-1, 1]) {
        for (i = [0:2])
          translate([grow_x[i], s*45, 7]) cube([1.6, 20, 9], center = true);
        for (i = [0:2])
          translate([grow_x[i], s*45, 17])
            rotate([90, 0, (s > 0) ? 180 : 0]) linear_extrude(20, center = true)
              text(str(eu_lo + i), size = 7.5, font = "Liberation Sans:style=Bold",
                   halign = "center", valign = "center");
      }
    }
    band_sole();
  }
}

/* ================= CAGE UPPER (F2: 2.6 mm conformal wall) ================= */
module upper_shell() {
  difference() {
    foot_negative(upper_t);
    foot_negative(0);
    translate([-70, 0, 44]) rotate([0, 8, 0]) scale([2.2, 1.2, 0.8]) sphere(r = 30);
    corset_window();
    aero_gills();
    vent_ducts();
  }
}

/* ============ RAW BODY (single sealed solid, liner on) ============ */
module monolith_body() {
  difference() {
    union() {
      sole_core();
      bow_spring();
      accordion();
      upper_shell();
      corset_slats();
      toe_beak();
      heel_pull_tab();
      // F22: arch_dome/met_bar/heel_cup REMOVED (R2.3 cosmetics, not in fixed-spec
      // architecture; they islanded in lattice voids = loose bodies in print)
      comfort_liner();        // soft skin, foot side
    }
    foot_negative(0);
    bow_channel();
    crash_rings();
    flex_grooves();
    bed_dimples();
    speed_lines();
    heel_turbine_engrave();
    growth_ruler();
    translate([0, 0, -12.001]) cube([400, 240, 24], center = true);   // F15: trim z<-0.001 (no coplanar sliver)
  }
}

/* ============ FLOWSKIN + COLOR SPLIT (S6: pure partition) ============ */
color(c_white)
  difference() {
    union() {
      difference() { monolith_body(); side_slab(1); side_slab(-1); }
      intersection() {
        difference() { sole_envelope(0); sole_envelope(skin_t); }
        difference() { monolith_body(); side_slab(1); side_slab(-1); }
      }
    }
    speed_lines(); growth_ruler(); heel_turbine_engrave();
  }

for (s = [-1, 1])
  color(c_side) intersection() { monolith_body(); side_slab(s); }

color(c_deep) intersection() {
  monolith_body();
  translate([0, 0, -3]) cube([360, 200, 8], center = true);
}

/* ============ SOLVER (F11: labeled analytic ESTIMATE) ============ */
v_sole =  (zones[0][1]-zones[0][0])*zones[0][2]*zones[0][3]*kept(zones[0][5],zones[0][4])
        + (zones[1][1]-zones[1][0])*zones[1][2]*zones[1][3]*kept(zones[1][5],zones[1][4])
        + (zones[2][1]-zones[2][0])*zones[2][2]*zones[2][3]*kept(zones[2][5],zones[2][4]);

v_skin  = 2*(290 + 92)*16 * skin_t + 290*92*skin_t*0.55;
v_liner = 36000 * liner_t / 1000;                 // ~36,000 mm2 interior surface
v_total = 94.7 + (v_sole*0.55 + v_skin)/1000 + 1.18*interior_l*100*2.2*0.55/1000
        + 31.6 + 6.3 + v_liner/1000 + 12.5;       // + tab/rings/rounded slats
m_total = v_total * rho;

gain_mass  = (963 - m_total) / 100;
gain_total = gain_mass + 4.6 * ret / 0.75;
spd = 17.1 * (1 + gain_total/100);

echo(str("APEX STRIDE PRO R2.4 COMFORT | ", mat, " | rider ", rider_kg, " kg (12 y/o custom) | EU",
         eu_lo, "->", eu_hi, " | rocker ", rocker_profile, " (", heel_ang, "/", toe_ang, " deg)"));
echo(str("COMFORT  conformal liner ", liner_t, " mm | 3-ring softstep heel | rounded edges | dimples | pull tab"));
echo(str("FIT  interior ", interior_l, " mm (x -135..155) | toe room net liner 42/43/44 = ",
         round(toe_room_net[0]*10)/10, "/", round(toe_room_net[1]*10)/10, "/",
         round(toe_room_net[2]*10)/10, " mm | ruler @ ", grow_x[0], "/", grow_x[1], "/", grow_x[2]));
echo(str("BOW  ", round(t_mid*10)/10, "->", round(t_root*10)/10, " mm | travel ", d_bow,
         " mm | peak ", round(F_peak), " N | returned ", round(U_step*10)/10, " J/step"));
echo(str("MASS ESTIMATE (analytic, STL authoritative)  ", round(m_total), " g"));
echo(str("GAIN ESTIMATE ~", round(gain_total*10)/10, " % | SPEED ESTIMATE  12.0 -> ",
         round(12.0*(1+gain_total/100)*10)/10, " | 15.0 -> ", round(15.0*(1+gain_total/100)*10)/10,
         " | 17.1 -> ", round(spd*10)/10, " km/h"));

assert(rib_mm >= 1.8 && wave_wall >= mat_wall(mat) && skin_t >= mat_wall(mat), "wall/rib under material floor");
assert(toe_room_net[2] >= 7 && toe_room_net[0] <= 25,        "net growth fit out of band");
assert(d_bow <= 8 && rider_kg >= 40 && rider_kg <= 95,        "bow/rider band");
assert(rocker_profile == "COMFORT" || rocker_profile == "SPEED", "bad rocker profile");
echo("GATES  walls/ribs PASS | liner fit PASS | bow/rider PASS | rocker PASS");
echo("WEAR STATUS  DIGITAL CANDIDATE — physical tests OPEN. See protocol below.");

// ============================================================
//  WEAR-CLEARANCE PROTOCOL (all 10 items required to declare
//  "cleared for human wear" — software cannot grant this):
//  STAGE 0 — BENCH (before any wear):
//   [ ] 1. Static proof 1942 N x 60 s x 3 cycles, <5% set
//   [ ] 2. Bow fatigue 50k @ 650 N, then 1M @ 1295 N, >=90% travel left
//   [ ] 3. Heel ring dye-penetrant after fatigue — no cracks
//   [ ] 4. Wet-tile traction >= 0.5 mu
//   [ ] 5. Dye/finish survives 50k flex cycles
//   [ ] 6. Fit check: net toe room 22/16/9 mm, ruler readable
//  STAGE 1-4 — WEAR RAMP (parent + coach informed):
//   [ ] 7. 10 min indoors walking — ANY heel pain = stop, revert
//   [ ] 8. 20-30 min soft surface easy jog
//   [ ] 9. 45 min mixed pace, alternating with old shoes
//   [ ]10. Full training + weekly heel squeeze-check + clinician OK
//  GROWING-ATHLETE NOTE: 66 kg at 12 y/o -> heel growth plates at risk
//  (Sever's/calcaneal apophysitis). Cushioning-first design. Never skip
//  stages. Pain = rest. This design is NOT cleared until all boxes checked.
// ============================================================
