// Practice using ISOThread.scad

use <lib/ISOThread.scad>

screwDia=6.35; // 6.35mm == 1/4 inch
screwLen=10;


translate([-10, -10, 0])
//rotate([-90,0,0])
test_rolson_hex_bolt_test(screwDia,screwLen);

thread_out(screwDia,screwLen+0.1);
thread_out_centre(screwDia,screwLen+0.1);

translate([10, 10, 0])
    hex_bolt(10,16);						// make an M10 x 16 ISO bolt

translate([20, 20, 0])
    hex_nut(10,16);						// make an M10 x 16 ISO bolt
