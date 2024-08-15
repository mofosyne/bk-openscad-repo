$fn=30;
rotate([0,180,0])
intersection()
{
    difference()
    {
        union()
        {
            color("green")
            linear_extrude(height = 1.5)
                import("gameboycameralayers.svg", layer="Cam");

            color("grey")
            linear_extrude(height = 2.5)
                import("gameboycameralayers.svg", layer="Base");

            if (0)
            color("black")
            linear_extrude(height = 3.0)
                import("gameboycameralayers.svg", layer="Bump");

            // Screen
            if (0)
            color("black")
            linear_extrude(height = 3) 
                import("gameboycameralayers.svg", layer="Inset");

            // Camera Lense
            translate([7.6,30-1.5,0])
            {
                Half_sphere_size=7.0;
                lens_hole=0.8;
                rotate_extrude()
                {
                    difference()
                    {
                        intersection(){
                            circle(d=Half_sphere_size);
                            square(Half_sphere_size);
                        }
                        polygon([[0,0],
                                    [0,Half_sphere_size/2],
                                    [Half_sphere_size/2,Half_sphere_size/2],
                                    [lens_hole,Half_sphere_size/4],
                                    [lens_hole,1],
                                    [lens_hole+0.2,0],
                                    [0,0]
                                    ]);
                    }
                }
            }
        }

        translate([0,0,-0.1])
            linear_extrude(height = 10) 
                import("gameboycameralayers.svg", layer="Hole");

        if (1)
        translate([0,0,0.5])
            linear_extrude(height = 3) 
                import("gameboycameralayers.svg", layer="Inset");

        if (0) // Seems to not print properly in FDM... try on resin?
        translate([7.5,37,2.5/2])
        {
            rotate_extrude()
            {
                translate([5,0,0])
                {
                    circle(d=1);
                }
            }
        }
    }
    cube([20,40,2.5]);
}