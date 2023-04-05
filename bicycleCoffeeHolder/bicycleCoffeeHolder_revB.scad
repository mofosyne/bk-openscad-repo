// Bicycle Coffee Holder
// By Brian Khuu 2023
// Inspired by https://www.thingiverse.com/thing:100362/remixes
$fn=40;

/* [3D Printer] */
ring_tolerance=0.5;
spike_tolerance=0.5;

/* [Bike Spec] */
handlebar_handle_dia=22.5;
handlebar_shaft_dia=24;

/* [Coffee Cup] */
coffeecup_ring_diameter = 70; // Cup rim was 75mm but want to make it easier to pick up cup
ring_thickness = 8;
ring_height = handlebar_handle_dia*0.8;
ring_gap=1;

/* Gyro Spec */
module spikeHole(r=20, h=5, spike_length=5, tol=0, tol_tip=0) 
{
    translate([0,r-0.5,0]) rotate([0,90,90]) cylinder(r1=h/2+tol,r2=0,h=spike_length+tol_tip);
    translate([0,-r+0.5,0]) rotate([0,-90,90]) cylinder(r1=h/2+tol,r2=0,h=spike_length+tol_tip);
}

module gyro_ring(r=20, h=5, thickness=1, gyro_spacing=0, spike_length=5, spike_hinge_tolerance=0.2, pins=true, is_inner=false)
{
    difference() 
    {
        union()
        {
            intersection() 
            {
                difference() 
                {
                    sphere(r=r+thickness,$fn=50);
                    if (is_inner)
                    {
                        // No more ring. Keep flat for cup holder etc...
                        cylinder(r=r,h=h+0.5,center=true);
                    }
                    else
                    {
                        // Spherical cut so inner ring can spin inside it
                        sphere(r=r,$fn=50);
                    }
                }
                // Height of each ring
                cylinder(r=r+thickness,h=h,center=true);
            }
            if (pins) 
            {
                rotate([0,0,90])
                    scale([0.6,1,1])
                        spikeHole(
                            r=r+thickness, 
                            h=h*0.8, 
                            spike_length=spike_length);
            }
        }
        if (!is_inner) 
        {
            spikeHole(
                r=r+thickness-gyro_spacing, 
                h=h*0.8, 
                spike_length=spike_length, 
                tol=spike_hinge_tolerance, 
                tol_tip=0.2);
        }
    }
}

module gyro_model(cup_dia, gyro_gap, gyro_height, gyro_hinge_tolerance)
{
    // Length of spike
    spike_length=ring_thickness-0.5;
    
    // spacing between rings
    gyro_spacing=ring_thickness+gyro_gap;
    
    // Size of inner ring that will hold the cup
    inner_ring_radius=cup_dia/2;
    
    // Cut bit extra for easier print tolerance
    tol_scaled=1.4;
    
    for (i=[0:1:2])
    {
        rotate([0,0,90*i]) 
            gyro_ring(
                r=inner_ring_radius+gyro_spacing*i,
                h=gyro_height,
                thickness=ring_thickness,
                gyro_spacing=gyro_spacing,
                spike_length=spike_length,
                spike_hinge_tolerance=gyro_hinge_tolerance,
                pins=(i<2)?true:false,
                is_inner=(i == 0)?true:false
                );
    }    
}

module gyro_mount(cup_dia, gyro_gap, gyro_height, gyro_hinge_tolerance)
{
    // Length of spike
    spike_length=ring_thickness-0.5;
    
    // spacing between rings
    gyro_spacing=ring_thickness+gyro_gap;
    
    // Size of inner ring that will hold the cup
    inner_ring_radius=cup_dia/2;
    
    // Cut bit extra for easier print tolerance
    tol_scaled=1.4;
    
    gyro_ring_outer_dia=coffeecup_ring_diameter/2+(ring_gap+ring_thickness+ring_tolerance)*3;
    
    difference()
    {
        union()
        {
            // Gyro Cup
            gyro_model(
                cup_dia=coffeecup_ring_diameter, 
                gyro_gap=ring_gap+ring_tolerance,
                gyro_height=ring_height, 
                gyro_hinge_tolerance=spike_tolerance);

            // Mount Bulk
            difference()
            {
                hull()
                {
                    rotate([0,0,180]) 
                        gyro_ring(
                            r=inner_ring_radius+gyro_spacing*2,
                            h=gyro_height,
                            thickness=ring_thickness,
                            gyro_spacing=gyro_spacing,
                            spike_length=spike_length,
                            spike_hinge_tolerance=gyro_hinge_tolerance,
                            pins=false,
                            is_inner=false
                            );

                    translate([gyro_ring_outer_dia+handlebar_handle_dia/2,0,0])
                        rotate([90,0,0])
                            cube([1,gyro_height,handlebar_shaft_dia*3],center=true);
                }
                hull()
                {
                    rotate([0,0,180]) 
                        gyro_ring(
                            r=inner_ring_radius+gyro_spacing*2,
                            h=gyro_height+10,
                            thickness=ring_thickness,
                            gyro_spacing=gyro_spacing,
                            spike_length=spike_length,
                            spike_hinge_tolerance=gyro_hinge_tolerance,
                            pins=false,
                            is_inner=false
                            );
                }
            }
        }

        // Bicycle Handlebars and Shaft
        translate([gyro_ring_outer_dia+handlebar_handle_dia/2,0,0])
            rotate([90,0,0])
                cylinder(d=handlebar_handle_dia,h=100,center=true);
        translate([gyro_ring_outer_dia+handlebar_shaft_dia/2,0,0])
            rotate([180,0,0])
                cylinder(d=handlebar_shaft_dia,h=100,center=true);

        // ZipTies
        translate([gyro_ring_outer_dia+(handlebar_shaft_dia)/2,handlebar_shaft_dia,0])
            rotate([90,0,0])
            scale([1.2,1,1])
            rotate_extrude(convexity = 10)
            translate([(handlebar_handle_dia+2)/2, 0, 0])
            square([2,6],center=true);
        translate([gyro_ring_outer_dia+(handlebar_shaft_dia)/2,-handlebar_shaft_dia,0])
            rotate([90,0,0])
            scale([1.2,1,1])
            rotate_extrude(convexity = 10)
            translate([(handlebar_handle_dia+2)/2, 0, 0])
            square([2,6],center=true);
        translate([gyro_ring_outer_dia-4,0,20])
            rotate([-90,0,90])
            scale([1,1.2,1])
            rotate_extrude(convexity = 10)
            translate([(handlebar_shaft_dia+2)/2, 0, 0])
            square([2,6],center=true);
    }
}

/*********************************************************************************/

// Gyro Cup Model
gyro_mount(
    cup_dia=coffeecup_ring_diameter, 
    gyro_gap=ring_gap+ring_tolerance,
    gyro_height=ring_height, 
    gyro_hinge_tolerance=spike_tolerance);

//%translate([0,0,ring_height]) cylinder(r=coffeecup_ring_diameter/2,h=10);