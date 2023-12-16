$fn = 100;
// Wall Bottle Holder
// By Brian Khuu 2023

bottle_w = 75; // bottle dia at marlen's cardboard cafe 7.0cm
bottleholder_h = 75; // 4cm

commandstrip_w = 18;
commandstrip_h = 75; // 75
commandstrip_thickness = 1.0;

wall_thickness = 1.5;

screw_hole_dia = 4.5;
screw_head_dia = 9;

difference()
{
    hull()
    {
        cylinder(h=bottleholder_h+1, r=bottle_w/2+wall_thickness);
        translate([0,(bottle_w+wall_thickness*2)/2,(bottleholder_h+1)/2])
            cube([bottle_w+wall_thickness*2, 0.1, (bottleholder_h+1)], center = true);
    }
    
    translate([0,0,1])
    hull()
    {
        translate([0,0,4])
        cylinder(h=bottleholder_h+1+1, r=bottle_w/2);
        cylinder(h=0.5, r=bottle_w/2-2);
    }

    hull()
    {
        translate([0,-(bottle_w+wall_thickness*2)/2,(bottleholder_h+1)/2])
            cube([bottle_w+wall_thickness*2+1, 0.1, 0.1], center = true);
        translate([0,0,bottleholder_h+1])
            cube([bottle_w+wall_thickness*2+1, bottle_w+wall_thickness*2, 0.1], center = true);
    }

    translate([0,0,1/2])
        cylinder(h=wall_thickness, r=bottle_w*0.6/2, center=true);
        
    // screw holes
    translate([(bottle_w+wall_thickness*2+1)*(1/6),0,bottleholder_h*(2/3)])
    hull()
    {
        translate([0,(bottle_w+wall_thickness*2)/2+0.1,0])
            rotate([90,0,0])
                cylinder(d=screw_hole_dia, h=bottle_w/2);
        translate([0,(bottle_w+wall_thickness*2)/2-1.5,0])
            rotate([90,0,0])
                cylinder(d=screw_head_dia, h=bottle_w/2);
    }
    translate([-(bottle_w+wall_thickness*2+1)*(1/6),0,bottleholder_h*(2/3)])
    hull()
    {
        translate([0,(bottle_w+wall_thickness*2)/2+0.1,0])
            rotate([90,0,0])
                cylinder(d=screw_hole_dia, h=bottle_w/2);
        translate([0,(bottle_w+wall_thickness*2)/2-1.5,0])
            rotate([90,0,0])
                cylinder(d=screw_head_dia, h=bottle_w/2);
    }
    
    // Command Strip Slot
    #translate([(bottle_w+wall_thickness*2)*(1/3),(bottle_w+wall_thickness*2)/2,commandstrip_h/2-0.5])
        cube([commandstrip_w, 1.0, commandstrip_h], center = true);
    #translate([-(bottle_w+wall_thickness*2)*(1/3),(bottle_w+wall_thickness*2)/2,commandstrip_h/2-0.5])
        cube([commandstrip_w, 1.0, commandstrip_h], center = true);
}

