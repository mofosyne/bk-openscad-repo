// Slotted Container Cup
// By Brian Khuu 2023
// Ref: https://www.thingiverse.com/thing:1241017/files Pegboard box by jww January 03, 2016
// This was created for little cardboard cafe
$fn=50;

/* [3D Printer] */
ring_tolerance=0.5;
spike_tolerance=0.5;

/* [Coffee Cup] */
coffeecup_ring_hole_diameter = 80; // Cup rim was 75mm but want to make it easier to pick up cup
coffeecup_ring_lip = 3; // Cup rim was 75mm but want to make it easier to pick up cup
coffeecup_holder_height = 10;

// ------------------------------------------------------
// EmptyBox, JWW, x,y,z,wall  r=riadius of rounding
// ------------------------------------------------------
module EmptyBox(xx,yy,zz,wall,rr)
{ 
    difference()
    {
        HalfRoundedBox(xx,yy,zz,rr);                                 
        translate([wall,wall,wall]) 
            RoundedBox(xx-2*wall,yy-2*wall,zz,rr-wall);
    }
}

// ------------------------------------------------------
// Rounded box, JWW, x,y,z  r=riadius of rounding
// ------------------------------------------------------
module RoundedBox(xx,yy,zz,rr)
{
    hull()
	{
        translate([rr,rr,0])       cylinder(r=rr,h=zz);
        translate([rr,yy-rr,0])    cylinder(r=rr,h=zz);
        translate([xx-rr,rr,0])    cylinder(r=rr,h=zz);
        translate([xx-rr,yy-rr,0]) cylinder(r=rr,h=zz);
    }
}

module HalfRoundedBox(xx,yy,zz,rr)
{ 
    hull()
	{
        translate([rr,rr,0])       cylinder(r=rr,h=zz);
        translate([0,yy-1,0])      cube([1,1,zz]);
        translate([xx-rr,rr,0])    cylinder(r=rr,h=zz);
        translate([xx-1,yy-1,0])   cube([1,1,zz]);
    }
}

module cup_mount(cup_hole_dia, cup_lip, cup_holder_height)
{   
    // Extra offset for shaft
    mount_offset=0;
    shift_offset=1.5;

    // Flange Lock
    difference()
    {
        sheetmetal_thickness = 1.5;
        mount_h = 15+12;
        union()
        {
            union()
            {
                mount_h = 15;
                hull()
                {
                    translate([-0.01,0,mount_h/2-1])
                        cube([0.01,25,mount_h-2],center=true);
                    translate([-sheetmetal_thickness,0,mount_h/2-1])
                        cube([0.01,25+shift_offset,mount_h-2],center=true);
                }
                hull()
                {
                    flange=10/2+10+15-5;
                    translate([-sheetmetal_thickness,0,mount_h/2-1])
                        cube([0.01,flange*2,mount_h-2],center=true);
                    translate([-sheetmetal_thickness-1.5,0,mount_h/2])
                        cube([0.01,flange*2+shift_offset,mount_h],center=true);
                }
            }
        }

        hull()
        {
            translate([0,0,mount_h/2-0.1])
                cube([0.1,15,mount_h+0.3],center=true);
            translate([-3,0,mount_h/2-0.1])
                cube([0.1,15+shift_offset,mount_h+0.3],center=true);
        }
    }

    // Cup Mold
    if (0)
    {
        // Cup Holder
        translate([0,0,cup_holder_height/2])
            difference()
            {
                hull()
                {
                    cube([0.01,45,cup_holder_height],center=true);
                    translate([(cup_hole_dia+cup_lip*2)/2+mount_offset,0,0])
                        cylinder(d=cup_hole_dia+cup_lip*2,h=cup_holder_height,center=true);
                }
                translate([(cup_hole_dia+cup_lip*2)/2+mount_offset,0,0])
                    cylinder(d1=cup_hole_dia+cup_lip*2-1,d2=cup_hole_dia,h=cup_holder_height+0.5,center=true);
            }
            
        hull()
        {
            translate([1,0,cup_holder_height])
                cube([2,45,0.01],center=true);
            translate([0.5/2,0,cup_holder_height+10/2])
                cube([0.5,45,20],center=true);
        }
            
    }
    else if (0)
    {
        // Box
        boxX=75; // 75mm is width of the shelf post at little cardboard cafe. 83mm is the size of Sizzix Big Shot instruction Manual, where we must also plus wall thickness times 2 to fit the manual in.
        boxY=20; // typical Sharpie is 15mm dia, thick bundle of Sizzix Big Shot instruction Manual is 4mm. Must also plus wall thickness times 2 to fit the pen.
        boxZ=90;
        roundBox=6; // 6 norminally, but must be 2 for holding the instruction manual
        translate([0,0,boxZ])
            rotate([0,180,90])
            translate([-boxX/2,-boxY,0])
            EmptyBox(xx=boxX, yy=boxY, zz=boxZ, wall=1.5, rr=roundBox);
    }
    else if (0)
    {
        // Glue Stick Holder
        boxX=40; // 75mm is width of the shelf post at little cardboard cafe. 83mm is the size of Sizzix Big Shot instruction Manual, where we must also plus wall thickness times 2 to fit the manual in.
        boxY=40; // typical Sharpie is 15mm dia, thick bundle of Sizzix Big Shot instruction Manual is 4mm. Must also plus wall thickness times 2 to fit the pen.
        boxZ=80;
        roundBox=20; // 6 norminally, but must be 2 for holding the instruction manual
        translate([0,0,boxZ])
            rotate([0,180,90])
            translate([-boxX/2,-boxY,0])
            EmptyBox(xx=boxX, yy=boxY, zz=boxZ, wall=1.5, rr=roundBox);
    }
    else if (0)
    {
        // Cable Holder
        boxX=75; // 75mm is width of the shelf post at little cardboard cafe. 83mm is the size of Sizzix Big Shot instruction Manual, where we must also plus wall thickness times 2 to fit the manual in.
        boxY=6; // typical Sharpie is 15mm dia, thick bundle of Sizzix Big Shot instruction Manual is 4mm. Must also plus wall thickness times 2 to fit the pen.
        boxZ=15;
        roundBox=2; // 6 norminally, but must be 2 for holding the instruction manual
        wall = 1.0;
        translate([0,0,boxZ])
            rotate([0,180,90])
            translate([-boxX/2,-boxY,0])
            difference()
            {
                HalfRoundedBox(boxX,boxY,boxZ,roundBox);
                translate([wall,wall,-1]) 
                    RoundedBox(boxX-2*wall,boxY-2*wall,boxZ+2,roundBox-wall);
                translate([boxX/2,0,boxZ/2]) 
                    cube([0.4,boxY,boxZ+1],center=true);
            }
    }
    else if (0)
    {
        // Sissor Holder
        boxX=75; // 75mm is width of the shelf post at little cardboard cafe. 83mm is the size of Sizzix Big Shot instruction Manual, where we must also plus wall thickness times 2 to fit the manual in.
        boxY=20; // typical Sharpie is 15mm dia, thick bundle of Sizzix Big Shot instruction Manual is 4mm. Must also plus wall thickness times 2 to fit the pen.
        boxZ=15;
        roundBox=5; // 6 norminally, but must be 2 for holding the instruction manual
        wall = 1.5;
        translate([0,0,boxZ])
            rotate([0,180,90])
            translate([-boxX/2,-boxY,0])
            difference()
            {
                HalfRoundedBox(boxX,boxY,boxZ,roundBox);
                translate([wall,wall,-1]) 
                    RoundedBox(boxX-2*wall,boxY-2*wall,boxZ+2,roundBox-wall);
            }
    }
    else if (1)
    {
        // Screwdriver Holder
        boxX=75; // 75mm is width of the shelf post at little cardboard cafe. 83mm is the size of Sizzix Big Shot instruction Manual, where we must also plus wall thickness times 2 to fit the manual in.
        boxY=15; // typical Sharpie is 15mm dia, thick bundle of Sizzix Big Shot instruction Manual is 4mm. Must also plus wall thickness times 2 to fit the pen.
        boxZ=15;
        roundBox=5; // 6 norminally, but must be 2 for holding the instruction manual
        wall = 1.5;
        translate([0,0,0])
            rotate([0,0,90])
            translate([-boxX/2,-boxY,0])
            difference()
            {
                HalfRoundedBox(boxX,boxY,boxZ,roundBox);
                for(i = [-30:12:30])
                translate([i,0,0])
                union()
                {
                    translate([boxX/2,boxY/2,-1])
                    hull()
                    {
                        cylinder(r=2.5,h=boxZ+2);
                        translate([0,-boxY/2,0])
                            cylinder(r=3,h=boxZ+2);
                    }
                    translate([boxX/2,boxY/2,-1])
                    hull()
                    {
                        cylinder(r2=2.1,r1=(10+1)/2,h=5);
                    }
                }
            }
    }
}

/*********************************************************************************/

cup_mount(
    cup_hole_dia=coffeecup_ring_hole_diameter, 
    cup_lip=coffeecup_ring_lip,
    cup_holder_height=coffeecup_holder_height);

//Cup Model (Based on salamatea large coffee cup)
if (0)
%translate([0,0,-100]) cylinder(d1=52,d2=75,h=120);
