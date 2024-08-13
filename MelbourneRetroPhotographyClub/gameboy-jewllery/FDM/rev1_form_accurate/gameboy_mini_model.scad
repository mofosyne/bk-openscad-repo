
difference()
{
    union()
    {
        color("grey")
        linear_extrude(height = 2) 
            import("gameboycameralayers.svg", layer="Base");

        color("green")
        linear_extrude(height = 1.5) 
            import("gameboycameralayers.svg", layer="Cam");

        color("black")
        linear_extrude(height = 2+0.5)
            import("gameboycameralayers.svg", layer="Bump");
    }
    
    translate([0,0,-0.1])
        linear_extrude(height = 3.2) 
            import("gameboycameralayers.svg", layer="Hole");

    translate([0,0,2-1])
        linear_extrude(height = 3.2) 
            import("gameboycameralayers.svg", layer="Inset");
}