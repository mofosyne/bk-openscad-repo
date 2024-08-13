tally_mount_base_diameter = 56;
tally_mount_hole_spacing = 56/2 - 5;
tally_mount_hole_diameter = 3;

// 50mm x 80mm label
tally_mount_label_width = 55;
tally_mount_label_length = 85;

tally_mount_base_height = 12-2;
tally_mount_label_height = 0.5;

dual_mount_spacing = 5;

module roundedRectangleBox(width, length, height, radius, scaling=1) {
    linear_extrude(height = height, scale=scaling)
        offset(r=radius) 
            square([width-radius*2, length-radius*2], center=true);
}

difference()
{
    hull()
    {
        translate([0,tally_mount_base_diameter/2,0])
            cylinder(d=tally_mount_base_diameter, h=tally_mount_base_height);
        translate([0,-tally_mount_base_diameter/2,0])
            cylinder(d=tally_mount_base_diameter, h=tally_mount_base_height);
        translate([tally_mount_base_diameter/2,0,tally_mount_base_height/2])
            cube([1, tally_mount_label_length, tally_mount_base_height], center=true);
        translate([tally_mount_base_diameter/2+tally_mount_label_width/2,0,0])
            roundedRectangleBox(tally_mount_label_width, tally_mount_label_length, tally_mount_label_height, 10);
    }
    
    #translate([0,tally_mount_hole_spacing+dual_mount_spacing,0])
    for (i = [0:60:360])
    {
        rotate([0,0,i])
            translate([tally_mount_hole_spacing,0,-1/2])
            {
                cylinder(d=tally_mount_hole_diameter, h = tally_mount_base_height+1, $fn = 30);
                cylinder(d=tally_mount_hole_diameter+2, h = 2.5, $fn = 30);
                translate([0,0,2.5-0.01])
                    cylinder(d1=tally_mount_hole_diameter+2, d2=tally_mount_hole_diameter, h = 3, $fn = 30);
            }
    }
    
    #translate([0,-tally_mount_hole_spacing-dual_mount_spacing,0])
    for (i = [0:60:360])
    {
        rotate([0,0,i])
            translate([tally_mount_hole_spacing,0,-1/2])
            {
                cylinder(d=tally_mount_hole_diameter, h = tally_mount_base_height+1, $fn = 30);
                cylinder(d=tally_mount_hole_diameter+2, h = 2.5, $fn = 30);
                translate([0,0,2.5-0.01])
                    cylinder(d1=tally_mount_hole_diameter+2, d2=tally_mount_hole_diameter, h = 3, $fn = 30);
            }
    }
}
