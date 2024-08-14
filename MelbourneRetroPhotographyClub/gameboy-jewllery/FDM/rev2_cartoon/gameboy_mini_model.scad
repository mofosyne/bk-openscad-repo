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

        // Screen
        color("black")
        linear_extrude(height = 3) 
            import("gameboycameralayers.svg", layer="Inset");

        // Camera Lense
        translate([7.6,30-0.5,0])
        {
            Half_sphere_size=8.5;
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
                                [Half_sphere_size/6,Half_sphere_size/4],
                                [Half_sphere_size/6,1],
                                [Half_sphere_size/6+0.2,0],
                                [0,0]
                                ]);
                }
            }
        }
    }

    translate([0,0,-0.1])
        linear_extrude(height = 10) 
            import("gameboycameralayers.svg", layer="Hole");

    if (0)
    translate([0,0,0.5])
        linear_extrude(height = 3) 
            import("gameboycameralayers.svg", layer="Inset");

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