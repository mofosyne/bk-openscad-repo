$fn = 50;

slot_count = 7;

waterpik_slot_dia = 7;
waterpik_slot_dia_tol = 1;

mount_hole_dia = waterpik_slot_dia + waterpik_slot_dia_tol;
mount_hole_standoff_radius = 5;
mount_horzontal_height = 20;

mount_plate_thickness = 2.5;
mount_wall_mount_thickness = 1.5;

rotate([0,90,0])
difference()
{
    mount_rim_dia = mount_hole_dia+mount_hole_standoff_radius*2;
    mount_rim_width = slot_count*mount_rim_dia;
    spacer_gap_cut = mount_horzontal_height - mount_plate_thickness*2;
    
    // Bulk
    translate([-mount_rim_dia/2,0,0])
        hull()
        {
            translate([mount_rim_dia/2,mount_rim_width/2,0])
                cube([0.01, mount_rim_width, mount_horzontal_height], center=true);
            translate([0,mount_rim_dia/2,])
                cylinder(d=mount_rim_dia, h = mount_horzontal_height, center=true);
            translate([0,mount_rim_dia/2+(slot_count-1)*mount_rim_dia,0])
                cylinder(d=mount_rim_dia, h = mount_horzontal_height, center=true);
        }

    // Holes
    for(i = [0 : 1 : slot_count-1])
        translate([-mount_rim_dia/2, mount_rim_dia/2+i*mount_rim_dia, 0])
            cylinder(d=mount_hole_dia, h = mount_horzontal_height+1, center=true);

    // Center Cut
    translate([-mount_rim_dia/2,mount_rim_width/2,0])
        hull()
        {
            translate([-mount_hole_standoff_radius,0,0])
                cube([mount_rim_dia, mount_rim_width, spacer_gap_cut], center=true);
            translate([-mount_wall_mount_thickness,0,0])
                cube([mount_rim_dia, mount_rim_width, spacer_gap_cut/2], center=true);
        }
}