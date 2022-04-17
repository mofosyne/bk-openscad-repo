$fn=50;



thick = 0.5;
buttond = 2.5;
buttontopw = 2.5;
buttonholel = 26;

inner_ledge = 3;

module button_presser()
{
    pressorw = 10;
    // Fingerpad
    translate([0,0,thick])
    hull()
    {        
        dia = 3.0;
        translate([inner_ledge/2 + dia/2 + 0.5,0,0])
            cylinder(d=dia, h=buttond);
        translate([buttonholel/2 - dia/2 ,0,0])
            cylinder(d=dia, h=buttond);
    }
    // Base
    translate([0,0,0])
    hull()
    {        
        dia = 3.0;
        translate([inner_ledge/2 + dia/2,0,0])
            cylinder(d=dia, h=thick);
        translate([buttonholel/2 - dia/2,0,0])
            cylinder(d=dia, h=thick);
    }
    // Strip
    translate([5,0,thick/2])
        cube([10,2.2,thick], center=true);
    // Bridge
    translate([5,0,buttond+thick/2])
        cube([10,3,thick], center=true);
    // Fingerpad
    translate([0,0,buttond])
    hull()
    {        
        dia = 3.0;
        translate([0,0,(thick/2)/2])
            cylinder(d1=dia, d2=3, h=thick/2);
        translate([buttonholel/2 - dia/2,0,(thick*2)/2])
            cylinder(d1=dia, d2=3, h=thick*2);
    }   
}

rotate([0,0,0])
{
    if (0)
    %translate([0,0,buttond/2])
        cube([3,2,buttond], center=true);
    if (0)
    %translate([0,0,buttond+1])
        cube([buttonholel,3,0.2], center=true);

    // pressor
    rotate([0,0,180])
        button_presser();
    rotate([0,0,0])
        button_presser();

}