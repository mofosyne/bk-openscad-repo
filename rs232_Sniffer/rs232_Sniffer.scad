// RS232 Sniffer (Brian Khuu) (Created On 2022-08-16)
//
// This arranges 4 RS232 screw terminal breakout boards so you can wire up a sniffer for reverse engineering purpose
// You may need to adapt the screw holes and the solder pits to match your breakout

$fn = 40;

screwDia = 1.9;
screwDepth = 3.0;
thicknessBase = 3.2;
solderDepth = 2.5;

module serialScrew()
{
    screwSpacing = 28;
    translate([+screwSpacing/2, 0,thicknessBase/2-screwDepth/2+0.1])
        cylinder(d=screwDia, h=screwDepth, center=true);
    translate([-screwSpacing/2, 0,thicknessBase/2-screwDepth/2+0.1])
        cylinder(d=screwDia, h=screwDepth, center=true);
    

    translate([0,6.5,thicknessBase/2-solderDepth/2+0.1])
        cube([31.5, 6.5, solderDepth], center=true);
    translate([0,-8,thicknessBase/2-solderDepth/2+0.1])
        cube([31.5, 4.5, solderDepth], center=true);
    
    if(0)
    %translate([0,0,thicknessBase])
        cube([33, 25, 1], center=true);
}

translate([0, 0, thicknessBase/2])
difference()
{
    hull()
    {
        cube([33, 125, thicknessBase], center=true);
        translate([33,0,0])
            cube([18, 70, thicknessBase], center=true);
    }
    
    translate([0, +100/2, 0])
        serialScrew();
    translate([0, -100/2, 0])
        rotate([0,0,-180])
        serialScrew();

    translate([30, +35/2, 0])
        rotate([0,0,-90])
            serialScrew();
    translate([30, -35/2, 0])
        rotate([0,0,-90])
            serialScrew();
}