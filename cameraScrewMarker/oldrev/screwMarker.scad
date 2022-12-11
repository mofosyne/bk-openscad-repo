 use <lib/ISOThread.scad>
// Concept is that this would screw together... in practice it didn't work... however it did show the benefit of a large grip area

// Typical camera mounts are 3/4 inch or 1/4 inch
screwDia=6.35; // 6.35mm == 1/4 inch
screwLen=8;

flagHead=10;
headWidth=20;

layerHeight=0.3;

rotate([-90,0,0])
intersection()
{
    //screwFlatCut=screwDia*3/4;
    screwFlatCut=screwDia/2;
    union()
    {
         // Screw
        thread_out(screwDia,screwLen+0.1);
        thread_out_centre(screwDia+0.2,screwLen+0.1);
        difference()
        {
            // Head
            hull()
            {
                cube([headWidth,screwFlatCut,0.1], center=true);
                translate([0,0,-flagHead*3/4])
                    cube([headWidth,screwFlatCut,0.1], center=true);
                translate([0,0,-flagHead])
                    cube([headWidth,1,0.1], center=true);
            }
            // Screw Hole
            translate([0,0,-screwLen-flagHead/3])
                cylinder(r=screwDia/2, h=screwLen+0.2);
            translate([0,0,-screwLen-flagHead/3+0.5])
                thread_in(screwDia,screwLen-0.2);
            // Save Plastic / Tag holes
            loopWidth = headWidth/2-4-screwDia/2;
            //loopWidth = 2;
            loopHeight = flagHead-6;
            translate([headWidth/2-loopWidth/2-2, 0,-flagHead/2])
                cube([loopWidth,screwFlatCut+0.1,loopHeight], center=true);
            translate([-(headWidth/2-loopWidth/2-2), 0,-flagHead/2])
                cube([loopWidth,screwFlatCut+0.1,loopHeight], center=true);
        }

        // Brim for more reliable printing
        hull()
        {
            translate([0,screwFlatCut/2,screwLen])
                cube([1,layerHeight*2+0.1,0.01], center=true);
            translate([0,screwFlatCut/2,screwLen+10])
                cube([3,layerHeight*2+0.1,0.01], center=true);
        }
        if (0)
        hull()
        {
            translate([0,screwFlatCut/2,0])
                cube([1,layerHeight*2+0.1,0.01], center=true);
            translate([0,screwFlatCut/2,-10])
                cube([3,layerHeight*2+0.1,0.01], center=true);
        }
    }

    // Cut for ease of printing
    cube([screwDia*2+headWidth, screwFlatCut, screwLen*3+10], center=true);
}