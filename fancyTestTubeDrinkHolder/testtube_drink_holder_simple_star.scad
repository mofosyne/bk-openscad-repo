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

/////////////////////////////////////////////////
// Star Approach
difference()
{
    holderHeight=testtube_height*0.30;
    holderThickness=nozzle_dia;
    holderTopThickness=2;
    holderBaseThickness=holderHeight*1.0;

    union()
    {
//        stepDeg=45;
        stepDeg=360/3;
        for (i = [0:stepDeg:360])
        {
            tubeholedia=testtube_diameter+testtube_tolerance*2;
            tubeBaseShift=20;
            hull()
            {
                rotate([0,0,i])
                    translate([0,tubeholedia/2+holderTopThickness/2,holderHeight])
                        cube([holderThickness,holderTopThickness,0.1], center=true);
                rotate([0,0,i+stepDeg/2])
                    translate([0,(tubeholedia/2+holderBaseThickness)/2,0])
                        cube([holderThickness,tubeholedia/2+holderBaseThickness,0.1], center=true);
            }
            hull()
            {
                rotate([0,0,i])
                    translate([0,tubeholedia/2+holderTopThickness/2,holderHeight])
                        cube([holderThickness,holderTopThickness,0.1], center=true);
                rotate([0,0,i-stepDeg/2])
                    translate([0,(tubeholedia/2+holderBaseThickness)/2,0])
                        cube([holderThickness,tubeholedia/2+holderBaseThickness,0.1], center=true);
            }
        }
    }

    translate([0,0,holderHeight*0.9+0.1])
        cylinder(r1=testtube_diameter/2, r2=testtube_diameter/2+holderTopThickness, h=holderHeight*0.1);

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
