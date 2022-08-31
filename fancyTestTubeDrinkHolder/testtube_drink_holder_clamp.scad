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

// Cube Approach
rotate([0,90,0])
difference()
{
    holderHeight=testtube_height*0.30;
    holderThickness=nozzle_dia*2;
    holderTopThickness=2;
    holderBaseThickness=holderHeight*1.5;

    union()
    {
        hull()
        {
            rounding = 5;
            // top
            topwidth=testtube_diameter+holderTopThickness;
            topwidthSide=testtube_diameter+1;
            translate([0,-topwidth/2,-rounding+holderHeight])
                rotate([0,90,0])
                cylinder(r=rounding, h=topwidthSide, center=true);
            translate([0,topwidth/2,-rounding+holderHeight])
                rotate([0,90,0])
                cylinder(r=rounding, h=topwidthSide, center=true);
            // bottom
            bottomwidth=testtube_diameter+holderBaseThickness;
            bottomwidthSide=bottomwidth*0.8;
            translate([0,-bottomwidth/2,rounding])
                rotate([0,90,0])
                cylinder(r=rounding, h=bottomwidthSide, center=true);
            translate([0,bottomwidth/2,rounding])
                rotate([0,90,0])
                cylinder(r=rounding, h=bottomwidthSide, center=true);
            // Mid
            Midwidth=testtube_diameter+holderBaseThickness;
            MidwidthSide=bottomwidth*0.8;
            translate([0,-bottomwidth/2,-rounding+holderHeight/2])
                rotate([0,90,0])
                cylinder(r=rounding, h=MidwidthSide, center=true);
            translate([0,bottomwidth/2,-rounding+holderHeight/2])
                rotate([0,90,0])
                cylinder(r=rounding, h=MidwidthSide, center=true);
        }
    }

    hull()
    {
        rounding = 5;
        // top
        topwidth=testtube_diameter+holderTopThickness;
        translate([0,-topwidth/2,-rounding+holderHeight])
            rotate([0,90,0])
            cylinder(r=rounding-holderThickness, h=bottomwidth+10, center=true);
        translate([0,topwidth/2,-rounding+holderHeight])
            rotate([0,90,0])
            cylinder(r=rounding-holderThickness, h=bottomwidth+10, center=true);
        // bottom
        bottomwidth=testtube_diameter+holderBaseThickness;
        bottomHolderthickness=holderThickness;
        translate([0,-bottomwidth/2,rounding])
            rotate([0,90,0])
            cylinder(r=rounding-bottomHolderthickness, h=bottomwidth+10, center=true);
        translate([0,bottomwidth/2,rounding])
            rotate([0,90,0])
            cylinder(r=rounding-bottomHolderthickness, h=bottomwidth+10, center=true);
        // Mid
        midHolderthickness=holderThickness;
        translate([0,-bottomwidth/2,-rounding+holderHeight/2])
            rotate([0,90,0])
            cylinder(r=rounding-midHolderthickness, h=bottomwidth+10, center=true);
        translate([0,bottomwidth/2,-rounding+holderHeight/2])
            rotate([0,90,0])
            cylinder(r=rounding-midHolderthickness, h=bottomwidth+10, center=true);
    }

    translate([0,0,holderHeight*0.9+0.1])
        cylinder(r1=testtube_diameter/2, r2=testtube_diameter/2+holderTopThickness, h=holderHeight*0.1);

    translate([0,0,1])
        testTubeBulk(testtube_diameter+testtube_tolerance, testtube_height);

    // Simulated Tube
    %difference()
    {
        translate([0,0,1])
            testTubeBulk(testtube_diameter, testtube_height);
        translate([0,0,1+1])
            testTubeBulk(testtube_diameter-1, testtube_height);
    }
}

