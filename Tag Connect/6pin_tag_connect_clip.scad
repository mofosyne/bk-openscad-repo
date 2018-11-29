$fn=20;

isx = 1.5;       // Inital Spacing X

a_dia_tol = 0.15; // Alignment Hole Tolerance
p_dia_tol = 0.01; // Probe Hole Tolerance

align_pin_dia = 0.991+a_dia_tol; // Alignment Pin Diamenter
probe_pin_dia = 0.787+p_dia_tol; // Probe Pin Diameter

/* Probe Clip Dimention */
boxx = 8;
boxy = 4;
boxh = 7;
his = 0.5; // Alignment/Probe hole offset height spacing

/* Probe Pair Spacing */
pps = 1.270;// mm probe pair spacing
pys = 0.635; // Probe spacing from x axis along y axis

/* Align Hole Calc */
ap1xs   = isx;        // Align pin 1 x spacing
ap2a3xs = ap1xs+5.080; // Align pin 2&3 x spacing
ap2a3ys = 1.016;

/* Probe Shield */
// http://www.tag-connect.com/Materials/TC2030-IDC.pdf
pss = ap1xs + pps - (probe_pin_dia/2);
psx = pps*2 + probe_pin_dia;
psy = 1.016*2;

/* Probe Pair Space Calc */
pp1s = ap1xs + pps*1; // mm spacing 
pp2s = ap1xs + pps*2; // mm spacing 
pp3s = ap1xs + pps*3; // mm spacing 

/* 3D Model */
difference() {
translate([0  , -boxy/2  , 0])
  /* Main Plug */
  cube([boxx,boxy,boxh]);

/* Align Hole */
#translate([ap1xs   , 0         , his])
    cylinder(r=align_pin_dia/2, h=boxh);
#translate([ap2a3xs , +ap2a3ys  , his])
    cylinder(r=align_pin_dia/2, h=boxh);
#translate([ap2a3xs , -ap2a3ys  , his])
    cylinder(r=align_pin_dia/2, h=boxh);

/* Probe Pair 1 */
%translate([pp1s, +pys  , his])
    cylinder(r=probe_pin_dia/2, h=boxh);
%translate([pp1s, -pys  , his])
    cylinder(r=probe_pin_dia/2, h=boxh);
/* Probe Pair 2 */
%translate([pp2s, +pys  , his])
    cylinder(r=probe_pin_dia/2, h=boxh);
%translate([pp2s, -pys  , his])
    cylinder(r=probe_pin_dia/2, h=boxh);
/* Probe Pair 3 */
%translate([pp3s, +pys  , his])
    cylinder(r=probe_pin_dia/2, h=boxh);
%translate([pp3s, -pys  , his])
    cylinder(r=probe_pin_dia/2, h=boxh);
}
