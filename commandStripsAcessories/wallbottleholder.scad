$fn = 100;

bottlew = 90; // bottle dia at marlen's cardboard cafe 8.5cm
bottleholderh = 75; // 4cm
wall = 1.5;

difference()
{
    hull()
    {
        cylinder(h=bottleholderh+1, r=bottlew/2+wall);
        translate([0,(bottlew+wall*2)/2,(bottleholderh+1)/2])
            cube([bottlew+wall*2, 0.1, (bottleholderh+1)], center = true);
    }
    
    translate([0,0,1])
    hull()
    {
        translate([0,0,4])
        cylinder(h=bottleholderh+1+1, r=bottlew/2);
        cylinder(h=0.5, r=bottlew/2-2);
    }

    hull()
    {
        translate([0,-(bottlew+wall*2)/2,(bottleholderh+1)/2])
            cube([bottlew+wall*2+1, 0.1, 0.1], center = true);
        translate([0,0,bottleholderh+1])
            cube([bottlew+wall*2+1, bottlew+wall*2, 0.1], center = true);
    }

    translate([0,0,1/2])
        cylinder(h=wall, r=bottlew*0.6/2, center=true);
    
    // Command Strip Slot
    #translate([0,(bottlew+wall*2)/2,75/2-0.5])
        cube([18, 1.0, 75], center = true);
    #translate([(bottlew+wall*2)*(1/3),(bottlew+wall*2)/2,75/2-0.5])
        cube([18, 1.0, 75], center = true);
    #translate([-(bottlew+wall*2)*(1/3),(bottlew+wall*2)/2,75/2-0.5])
        cube([18, 1.0, 75], center = true);
}

