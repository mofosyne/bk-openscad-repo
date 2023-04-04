// Inspired by https://www.thingiverse.com/thing:100362/remixes
$fn=20;

/*[3D Printer]*/
ring_tolerance=0.5;
spike_tolerance=0.5;

/*[Coffee Cup]*/
coffeecup_ring_diameter = 73; 
ring_thickness = 4;
ring_height = 10;

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
                    sphere(r=r,$fn=50);
                    if (is_inner)
                    {
                        // No more ring. Keep flat for cup holder etc...
                        cylinder(r=r-thickness,h=h+0.5,center=true);
                    }
                    else
                    {
                        // Spherecal cut so inner ring can spin inside it
                        sphere(r=r-thickness,$fn=50);
                    }
                }
                // Height of each ring
                cylinder(r=r,h=h,center=true);
            }
            if (pins) 
            {
                rotate([0,0,90])
                    scale([0.8,1,1])
                        spikeHole(
                            r=r, 
                            h=h*0.8, 
                            spike_length=spike_length);
            }
        }
        if (!is_inner) 
        {
            spikeHole(
                r=r-gyro_spacing, 
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

/*********************************************************************************/
gyro_ring_outer_dia=coffeecup_ring_diameter/2+(ring_thickness+ring_tolerance)*(3-1);


difference()
{
    union()
    {
        gyro_model(
            cup_dia=coffeecup_ring_diameter, 
            gyro_gap=ring_tolerance,
            gyro_height=ring_height, 
            gyro_hinge_tolerance=spike_tolerance);
        
    }
    //cylinder(r=coffeecup_ring_diameter,h=10);
}

//%cylinder(d=coffeecup_ring_diameter,h=1);

if (0)
translate([gyro_ring_outer_dia,0,0])
%rotate([90,0,0])
    cylinder(d=20,h=100,center=true);

