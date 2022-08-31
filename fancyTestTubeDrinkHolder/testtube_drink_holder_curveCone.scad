$fn = 40;

nozzle_dia=0.6;

testtube_diameter=32;
testtube_height=180;
testtube_tolerance=1;

module testTubeBulk(diameter=32, height=30+50*3)
{
    translate([0,0,diameter/2])
    {
        cylinder(r=diameter/2, h=height);
        sphere(r=diameter/2);
    }
}

//////////////////////////////////////////////////////////////
// Cone Approach
function curve(x, y) = 50*(1-sqrt(x))+testtube_diameter/2+y;

difference()
{
    holderHeight=testtube_height*0.30;
    holderThickness=nozzle_dia*2;
    holderTopThickness=2;
    holderBaseThickness=holderHeight*1.5;


    heightStep = holderHeight/100;
    for (i = [0:10:100-1])
    {
        translate([0,0,i*heightStep])
            cylinder(r1=curve(i/100, holderThickness), r2=curve((i+10)/100, holderThickness), h=heightStep*10);
    }

    translate([0,0,holderHeight*0.8+0.1])
        cylinder(r1=testtube_diameter/2, r2=testtube_diameter/2+2, h=holderHeight*0.2);

    translate([0,0,3+holderHeight/2+10/2])
        rotate([0,0,0])
        cube([10,200,(holderHeight+10)], center=true);
    translate([0,0,3+holderHeight/2+10/2])
        rotate([0,0,90])
        cube([10,200,(holderHeight+10)], center=true);
    translate([0,0,3+holderHeight/2+10/2])
        rotate([0,0,0])
        cube([10,200,(holderHeight+10)], center=true);

    translate([0,0,1])
        testTubeBulk(testtube_diameter+testtube_tolerance, testtube_height);
}

// Simulated Tube
if (1)
%difference()
{
    translate([0,0,1])
        testTubeBulk(testtube_diameter, testtube_height);
    translate([0,0,1+1])
        testTubeBulk(testtube_diameter-1, testtube_height);
}
