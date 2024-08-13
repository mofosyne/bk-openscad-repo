
difference()
{
    union()
    {
        color("green")
        linear_extrude(height = 1.5)
            import("gameboycameralayers.svg", layer="Cam");

        color("grey")
        linear_extrude(height = 1.5)
            import("gameboycameralayers.svg", layer="Base");

        color("black")
        linear_extrude(height = 2.5)
            import("gameboycameralayers.svg", layer="Bump");
    }

    translate([0,0,-0.1])
        linear_extrude(height = 3.2) 
            import("gameboycameralayers.svg", layer="Hole");

    translate([0,0,0.5])
        linear_extrude(height = 3) 
            import("gameboycameralayers.svg", layer="Inset");
}