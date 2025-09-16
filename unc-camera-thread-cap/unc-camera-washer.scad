$fn=60;
// By Brian Khuu 2023

// This was created to make use of the other mount when either the smartphone or tablet is used
// in the Anko Floor Standing Tablet and Smartphone Stand from Kmart 

//////////////////////////////////////////////////////////////////////////////
// Loop mount

// Camera Tripod Typical Thread Size
// | Diameter inch | Diameter mm | Thread size |
// |---------------|-------------|-------------|
// | 1/4           | 6.3500      | 20          |
// | 3/8           | 7.9375      | 16          |

washer_height = 5.5;
hole_dia_tolerance = 0.5;
bottom_screw_size = 6.35;
screw_mount_outer_dia = 23;
electric_wire_dia = 3;

thumbscrew_guide_dia = 14;
thumbscrew_guide_height = 2;

difference()
{
    cylinder(d = screw_mount_outer_dia, h = washer_height);
    hull()
    {
        translate([0,0,washer_height])
            rotate([0,90,0])
            cylinder(d = electric_wire_dia, h = screw_mount_outer_dia+1, center=true);
        translate([0,0,washer_height-electric_wire_dia/2])
            rotate([0,90,0])
            cylinder(d = electric_wire_dia, h = screw_mount_outer_dia+1, center=true);
    }
    translate([0,0,washer_height])
        rotate_extrude()
            hull()
            {
                translate([screw_mount_outer_dia/4, 0, 0])
                    circle(d = electric_wire_dia);
                translate([screw_mount_outer_dia/4, -electric_wire_dia/2, 0])
                    circle(d = electric_wire_dia);
            }
    translate([0,0,-0.1])
        cylinder(d = bottom_screw_size+hole_dia_tolerance, h = washer_height+0.2);
    translate([0,0,-0.1])
        cylinder(d = thumbscrew_guide_dia, h = thumbscrew_guide_height);
}
