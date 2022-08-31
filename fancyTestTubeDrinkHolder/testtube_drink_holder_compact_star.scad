$fn = 40;

nozzle_dia=0.6;
layer_height=0.3;

testtube_diameter=32;
testtube_height=180;
testtube_tolerance=1;

PRINTER_PLATE_SIZE_TYPE="?x?";

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
module testtubeStar()
{
    difference()
    {
        holderHeight=testtube_height*0.30;
        holderThickness=nozzle_dia*1.5;
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
                ////////////////////////////////////////////////////////////////////
                // Top Fold
                holderHeight_upper=holderHeight;
                holderBaseThickness_upper=tubeholedia/2;
                hull()
                {
                    rotate([0,0,i])
                        translate([0,tubeholedia/2+holderTopThickness/2,holderHeight_upper])
                            cube([holderThickness,holderTopThickness,0.01], center=true);
                    rotate([0,0,i+stepDeg/2])
                        translate([0,(tubeholedia/2+holderBaseThickness_upper)/2,0])
                            cube([holderThickness,tubeholedia/2+holderBaseThickness_upper,0.01], center=true);
                }
                hull()
                {
                    rotate([0,0,i])
                        translate([0,tubeholedia/2+holderTopThickness/2,holderHeight_upper])
                            cube([holderThickness,holderTopThickness,0.01], center=true);
                    rotate([0,0,i-stepDeg/2])
                        translate([0,(tubeholedia/2+holderBaseThickness_upper)/2,0])
                            cube([holderThickness,tubeholedia/2+holderBaseThickness_upper,0.01], center=true);
                }
                ////////////////////////////////////////////////////////////////////
                // Bottom Fold
                holderHeight_lower=holderHeight/3;
                holderBaseThickness_lower=holderBaseThickness;
                stepDeg_lower = stepDeg/2;
                rotate([0,0,stepDeg_lower])
                hull()
                {
                    rotate([0,0,i])
                        translate([0,tubeholedia/2+holderTopThickness/2,holderHeight_lower])
                            cube([holderThickness,holderTopThickness,0.01], center=true);
                    rotate([0,0,i+stepDeg/2])
                        translate([0,(tubeholedia/2+holderBaseThickness_lower)/2,0])
                            cube([holderThickness,tubeholedia/2+holderBaseThickness_lower,0.01], center=true);
                }
                rotate([0,0,stepDeg_lower])
                hull()
                {
                    rotate([0,0,i])
                        translate([0,tubeholedia/2+holderTopThickness/2,holderHeight_lower])
                            cube([holderThickness,holderTopThickness,0.01], center=true);
                    rotate([0,0,i-stepDeg/2])
                        translate([0,(tubeholedia/2+holderBaseThickness_lower)/2,0])
                            cube([holderThickness,tubeholedia/2+holderBaseThickness_lower,0.01], center=true);
                }
                ////////////////////////////////////////////////////////////////////
                // BRIM
                rotate([0,0,i-stepDeg/2])
                union()
                {
                    holderBaseThickness_upper_brim=tubeholedia/2;
                    translate([0,tubeholedia/2+holderBaseThickness_upper_brim,layer_height/2])
                    hull()
                    {
                        cube([holderThickness,0.1,layer_height], center=true);
                        translate([0,10,0])
                            cube([holderThickness+10,0.1,layer_height], center=true);
                    }
                    translate([0,(tubeholedia/2+holderBaseThickness_upper)/2+5,layer_height/2])
                        cube([holderThickness,tubeholedia/2+holderBaseThickness_upper+10,layer_height], center=true);
                }
                rotate([0,0,i-stepDeg/2+stepDeg_lower])
                union()
                {
                    holderBaseThickness_lower_brim=holderBaseThickness;
                    translate([0,tubeholedia/2+holderBaseThickness_lower_brim,layer_height/2])
                    hull()
                    {
                        cube([holderThickness,0.1,layer_height], center=true);
                        translate([0,10,0])
                            cube([holderThickness+10,0.1,layer_height], center=true);
                    }
                    translate([0,(tubeholedia/2+holderBaseThickness_lower)/2+5,layer_height/2])
                        cube([holderThickness,tubeholedia/2+holderBaseThickness_lower+10,layer_height], center=true);
                }
            }
        }

        // Rim Cut to slide tube easier into it
        translate([0,0,holderHeight*0.9+0.01])
            cylinder(r1=testtube_diameter/2, r2=testtube_diameter/2+holderTopThickness, h=holderHeight*0.1);

        // Test Tube Cut
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
}



////////////////////////////////////////////////////////////////////////////////
// Plate
if (PRINTER_PLATE_SIZE_TYPE == "25cm x 21cm")
{
    // Assumes test tube diameter : 32;
    // Assumes test tube height   : 180;

    translate([0,-50,0])
        rotate([0,0,0])
            testtubeStar();
    translate([75,30,0])
        rotate([0,0,90])
            testtubeStar();
    translate([-75,30,0])
        rotate([0,0,-90])
            testtubeStar();

    // Simulated Prusa MK3S+ Plate
    translate([0,0,-1])
        %cube([250,210,0.1], center=true);
}
else
{
    testtubeStar();
}