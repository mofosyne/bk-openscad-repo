$fn=30;

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

        color("black")
        linear_extrude(height = 3.0)
            import("gameboycameralayers.svg", layer="Bump");

        if (1)
        color("black")
        linear_extrude(height = 3) 
            import("gameboycameralayers.svg", layer="Screen");

        // Camera Lense
        translate([7.6,30-1.5,0])
        {
            Half_sphere_size=7.0;
            lens_hole=1.0;
            lens_hole_height=2.0;
            lens_hole_iris=2;
            lens_height=2.5;
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
                                [Half_sphere_size/2,lens_height],
                                [lens_hole_iris,lens_height],
                                [lens_hole,lens_hole_height],
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

    translate([0,0,1])
        linear_extrude(height = 3) 
            import("gameboycameralayers.svg", layer="Speaker");

    if (0) // Print this layer a different color...
    translate([0,0,0.5])
        linear_extrude(height = 3) 
            import("gameboycameralayers.svg", layer="Inset");

    if (1) // Seems to not print properly in FDM... try on resin?
    translate([7.5,35.5,1])
    {
        rotate_extrude()
        {
            translate([5,0,0])
            {
                circle(d=1.2);
            }
        }
    }
}