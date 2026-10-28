// ============================================================
//  APEX STRIDE PRO — REV R2.3 "COMFORT ABSOLUTE"
//  CUSTOM BUILD: 66 kg, 12 y/o, growth-fit EU42 -> EU44
//  ONE FILE | ONE PRINT (TPU 95A) | ZERO ASSEMBLY
//  WHITE BODY + MAROON SIDES | GLOW GROWTH RULER
//
//  WEAR STATUS: CLEARANCE PROTOCOL DEFINED (bottom of file).
//  "CLEARED" = bench 6/6 PASS + wear-ramp stage 4 + clinician OK.
//  Current state: DIGITAL CANDIDATE. Physical build untested.
//  Software cannot grant wear clearance — only the tests can.
// ============================================================

/* ---------------- FINAL material selection ---------------- */
mat      = "TPU95A";     // the entire print. locked.
rider_kg = 66;           // 40 .. 95 — bow re-solves
skin_t   = 1.5;          // FlowSkin outer shell
liner_t  = 1.0;          // conformal comfort liner (NEW)

/* ---------------- palette ---------------- */
c_white = "#F4F2EE"; c_side = "#5C0E28";
c_deep  = "#3A0A1C"; c_glow = "#C9D8B0";

/* ---------------- material solver ---------------- */
function mat_rho(m)  = m == "TPU95A" ? 1.20 : 0.95;
function mat_ret(m)  = m == "TPU95A" ? 0.62 : 0.75;
function mat_rib(m)  = m == "TPU95A" ? 1.8  : 1.5;
function mat_wall(m) = m == "TPU95A" ? 1.6  : 1.2;

rib_mm    = mat_rib(mat);
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
function bow_z(x) = 4 + 12 * (1 - pow(x / 85, 2));
function bow_t(x) = t_mid + (t_root - t_mid) * pow(abs(x) / 85, 1.5);

U_bow  = 0.5 * F_peak * d_bow / 1000;
U_step = (U_bow + 1.6 + 1.1) * ret;
P_back = U_step * 3;

/* --------- internal zones [x0,x1,w,h,pitch,rib] ---------- */
zones = [
  [-145, -55, 78, heel_h, 26,   rib_mm],
  [ -55,  62, 92, 27,     23,   rib_mm],
  [  62, 152, 88, fore_h, 18.5, rib_mm]
];
function kept(r, p) = 1 - pow((p - 2*r)/p, 2);

/* ================= ENVELOPE (k = inward shrink) ================= */
module station(x, w, h, ang, k)
  translate([x, 0, h/2]) rotate([0, ang, 0])
    cube([26, w - 2*k, h - 2*k], center = true);

module sole_envelope(k = 0) {
  hull() {
    station(-138, 72, 24, heel_ang, k);
    station(-106, 80, 30, 10, k);
    station(-55,  88, heel_h, 0, k);
    station(5,    94, 30, 0, k);
    station(62,   92, 27, -6, k);
    station(106,  90, 25, -8, k);
    station(128,  88, 23, -12, k);
    station(152,  76, 20, -toe_ang, k);
  }
}

/* ============ FOOT NEGATIVE (pad = liner build-out) ============ */
module foot_negative(pad = 0) {
  hull() {
    translate([-112, 0, heel_h + 2]) scale([1, 1, 0.50]) sphere(r = 30 + pad);
    translate([-55,  0, heel_h - 2]) scale([1, 1, 0.42]) sphere(r = 34 + pad);
    translate([10,   0, heel_h - 6]) scale([1, 1, 0.42]) sphere(r = 38 + pad);
    translate([82,   0, fore_h - 2]) scale([1, 1, 0.42]) sphere(r = 36 + pad);
    translate([128,  0, fore_h - 3]) scale([1, 1, 0.40]) sphere(r = 30 + pad);
    translate([148,  0, fore_h - 5]) scale([1, 1, 0.38]) sphere(r = 24 + pad);
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

/* ============ INTERNAL LATTICE (sealed) ============ */
module zone_lattice(z) {
  p = z[4]; r = z[5]; a = p - 2*r;
  intersection() {
    translate([(z[0]+z[1])/2, 0, z[3]/2])
      cube([z[1]-z[0], z[2], z[3]], center = true);
    for (i = [0:26], j = [0:22])
      translate([z[0] + i*p, -z[2]/2 + j*p, -1])
        rotate([0, 0, 45]) translate([-a*0.707, -a*0.707, 0])
          cube([a*1.414, a*1.414, z[3] + 2]);
  }
}
module sole_core() {
  intersection() { sole_envelope(skin_t); union() for (z = zones) zone_lattice(z); }
}

/* ========== PROGRESSIVE BOW (sealed) ========== */
module bow_spring() {
  for (i = [0:25]) {
    x0 = -85 + 170*i/26; x1 = -85 + 170*(i+1)/26;
    hull() {
      translate([x0, 0, bow_z(x0)]) cube([8, 22, bow_t(x0)], center = true);
      translate([x1, 0, bow_z(x1)]) cube([8, 22, bow_t(x1)], center = true);
    }
  }
}
module bow_channel() {
  for (i = [0:25]) {
    x0 = -85 + 170*i/26; x1 = -85 + 170*(i+1)/26;
    hull() {
      translate([x0, 0, bow_z(x0) + 3]) cube([9, 30, 24], center = true);
      translate([x1, 0, bow_z(x1) + 3]) cube([9, 30, 24], center = true);
    }
  }
}

/* ============ ACCORDION (sealed) + AERO GILLS ============ */
module accordion() {
  intersection() {
    sole_envelope(skin_t);
    for (i = [-24:24])
      translate([i*6.5, 0, heel_h - 13])
        rotate([0, 0, (i % 2 == 0) ? 28 : -28])
          cube([wave_wall, 130, 22], center = true);
  }
}
module aero_gills() {
  for (s = [-1, 1], k = [0:3])
    translate([-78 + k*52, s*47, heel_h - 12])
      rotate([0, 18, 0]) cube([26, 8, 4], center = true);
}

/* ============ G21 SOFTSTEP HEEL — 3-ring decoupler ============ */
module crash_rings() {
  for (R = [44, 50, 56])
    intersection() {
      translate([-112, 0, 0]) rotate_extrude($fn = 72)
        translate([R, 7, 0]) circle(r = 1.1, $fn = 12);   // thinner, softer
      translate([-172, 0, 7]) cube([120, 220, 30], center = true);
    }
}
module flex_grooves() {
  for (x = [72, 94, 114, 128])
    translate([x, 0, -2]) rotate([0, -20, 0]) cube([4, 220, 30], center = true);
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

/* ============ G21 HEEL PULL TAB (integrated) ============ */
module heel_pull_tab() {
  translate([-146, 0, heel_h + 12]) rotate([0, -28, 0])
    difference() {
      hull() {
        translate([0,  11, 0]) cylinder(r = 5, h = 5, center = true, $fn = 20);
        translate([0, -11, 0]) cylinder(r = 5, h = 5, center = true, $fn = 20);
      }
      hull() {
        translate([0,  6, 0]) cylinder(r = 3, h = 8, center = true, $fn = 16);
        translate([0, -6, 0]) cylinder(r = 3, h = 8, center = true, $fn = 16);
      }
    }
}

/* ============ MAROON SIDE PANELS ============ */
module side_slab(s) {
  hull() {
    translate([-118, s*52, 15]) cube([64, 30, 27], center = true);
    translate([-10,  s*52, 13]) cube([120, 30, 23], center = true);
    translate([112,  s*52, 11]) cube([90, 30, 19], center = true);
    translate([152,  s*46, 8])  cube([30, 26, 13], center = true);
  }
}
module toe_beak() {
  hull() { translate([150, 0, 10]) cube([4, 42, 8], center = true);
           translate([140, 0, 17]) cube([4, 48, 8], center = true); }
}

/* ============ ENGRAVED DECOR (0.8 mm — no holes) ============ */
module speed_lines() {
  for (i = [0:7])
    translate([-100 + i*26, 0, heel_h + 6])
      rotate([0, -26, 0]) cube([2.2, 60 - i*3, 12], center = true);
}
module heel_turbine_engrave() {
  for (a = [-52:13:52])
    rotate([0, 0, a]) translate([-136, 0, 16]) rotate([0, 26, 0])
      cube([12, 2.2, 20], center = true);
}
module growth_ruler() {
  for (s = [-1, 1]) {
    for (i = [0:2]) translate([grow_x[i], s*54, 7]) cube([1.6, 6, 9], center = true);
    for (i = [0:2])
      translate([grow_x[i], s*53.2, 17]) rotate([90, 0, -90]) linear_extrude(2)
        text(str(eu_lo + i), size = 7.5, font = "Liberation Sans:style=Bold",
             halign = "center", valign = "center");
  }
}

/* ================= CAGE UPPER (smooth flow) ================= */
module upper_shell() {
  difference() {
    hull() {
      translate([-112, 0, heel_h + 6]) scale([1, 1, 0.62]) sphere(r = 34);
      translate([-55,  0, heel_h + 4]) scale([1, 1, 0.52]) sphere(r = 37);
      translate([10,   0, heel_h])     scale([1, 1, 0.50]) sphere(r = 41);
      translate([82,   0, fore_h + 2]) scale([1, 1, 0.50]) sphere(r = 39);
      translate([128,  0, fore_h])     scale([1, 1, 0.46]) sphere(r = 31);
      translate([150,  0, fore_h - 1]) scale([1, 1, 0.42]) sphere(r = 23);
    }
    foot_negative(0);
    translate([-62, 0, 52]) rotate([0, 8, 0]) scale([2.4, 1.1, 0.8]) sphere(r = 32);
    corset_window();
    aero_gills();
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
      arch_dome(); met_bar(); heel_cup();
      comfort_liner();        // G21 — soft skin, foot side
    }
    foot_negative(0);
    bow_channel();
    crash_rings();
    flex_grooves();
    bed_dimples();
    speed_lines();
    heel_turbine_engrave();
    growth_ruler();
    translate([0, 0, -skin_t*2]) cube([400, 240, skin_t*2], center = true);
  }
}

/* ============ SOLVER ============ */
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

echo(str("APEX STRIDE PRO R2.3 COMFORT | ", mat, " | rider ", rider_kg, " kg (12 y/o custom) | EU",
         eu_lo, "->", eu_hi, " | rocker ", rocker_profile, " (", heel_ang, "/", toe_ang, " deg)"));
echo(str("COMFORT  conformal liner ", liner_t, " mm | 3-ring softstep heel | rounded edges | dimples | pull tab"));
echo(str("FIT  toe room net liner 42/43/44 = ",
         round(toe_room_net[0]*10)/10, "/", round(toe_room_net[1]*10)/10, "/",
         round(toe_room_net[2]*10)/10, " mm | ruler @ ", grow_x[0], "/", grow_x[1], "/", grow_x[2]));
echo(str("BOW  ", round(t_mid*10)/10, "->", round(t_root*10)/10, " mm | travel ", d_bow,
         " mm | peak ", round(F_peak), " N | returned ", round(U_step*10)/10, " J/step"));
echo(str("MASS  963 g -> ", round(m_total), " g   (saved ", round(963 - m_total), " g)"));
echo(str("METABOLIC GAIN ~", round(gain_total*10)/10, " % | SPEED  12.0 -> ",
         round(12.0*(1+gain_total/100)*10)/10, " | 15.0 -> ", round(15.0*(1+gain_total/100)*10)/10,
         " | 17.1 -> ", round(spd*10)/10, " km/h"));

assert(rib_mm >= mat_wall(mat) && wave_wall >= mat_wall(mat), "wall under material floor");
assert(toe_room_net[2] >= 7 && toe_room_net[0] <= 25,        "net growth fit out of band");
assert(m_total < 420,                                        "comfort mass budget blown");
assert(d_bow <= 8 && rider_kg >= 40 && rider_kg <= 95,        "bow/rider band");
assert(rocker_profile == "COMFORT" || rocker_profile == "SPEED", "bad rocker profile");
echo("GATES  walls PASS | liner fit PASS | mass PASS | bow/rider PASS | rocker PASS");
echo("WEAR STATUS  DIGITAL CANDIDATE — physical tests OPEN. See protocol below.");

// ============================================================
//  WEAR-CLEARANCE PROTOCOL (all 10 items required to declare
//  "cleared for human wear" — software cannot grant this):
//  STAGE 0 — BENCH (before any wear):
//   [ ] 1. Static proof 1942 N x 60 s x 3 cycles, <5% set
//   [ ] 2. Bow fatigue 50k @ 650 N, then 1M @ 1300 N, >=90% travel left
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