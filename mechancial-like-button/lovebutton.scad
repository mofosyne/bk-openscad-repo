$fn=60;

tally_tab_circle_dia = 10;
tally_tab_circle_tab = 5;
tally_tab_circle_tol = 1;

tally_tab_thickness = 1.0;
base_thickness = 0.5;
top_thickness = 0.8;

difference() 
{
    translate([0,0,0.01])
    union()
    {
        translate([0,0,0])
        color("black")
        linear_extrude(height = tally_tab_thickness+base_thickness)
            import("love-button.svg", id="love-base", center=true);

        translate([0,0,tally_tab_thickness+base_thickness])
        color("red")
        linear_extrude(height = top_thickness)
            import("love-button.svg", id="love", center=true);
    }

    linear_extrude(height = tally_tab_thickness)
    {
        circle(d=tally_tab_circle_dia+tally_tab_circle_tol);
        translate([0,0,0])
            square([tally_tab_circle_tab+tally_tab_circle_tol,tally_tab_circle_dia+2], center=true);
    }
}
