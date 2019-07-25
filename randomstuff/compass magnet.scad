
difference()
{
    union()
    {
        translate([2,0,0]) linear_extrude(height = 3) rotate([0,0,90])
            text("N", size = 10, h =10, $fn = 16, halign="center", valign="top");
        translate([-2,0,0]) linear_extrude(height = 3) rotate([0,0,90])
            text("S", size = 10, h =10, $fn = 16, halign="center", valign="bottom");
        cube([24,10,3], center=true);
    }
    cube([11,7,1.5], center=true); 
    
    translate([0,4,0])
        cylinder(r=1.5/2, h=100, center=true, $fn=100);
    translate([0,-4,0])
        cylinder(r=1.5/2, h=100, center=true, $fn=100);
}