$fn=60;

tally_tab_circle_dia = 10;
tally_tab_circle_tab = 5;
tally_tab_circle_tol = 1;

tally_tab_thickness = 2.0;
base_thickness = 0.5;
top_thickness = 0.5;

difference() 
{
    translate([-2,5,0.01])
    union()
    {
        translate([0,0,0])
        color("black")
        linear_extrude(height = tally_tab_thickness+base_thickness)
            import("like-button.svg", id="like-base", center=true);

        translate([0,0,tally_tab_thickness+base_thickness])
        color("white")
        linear_extrude(height = top_thickness)
            import("like-button.svg", id="like", center=true);
    }

    linear_extrude(height = tally_tab_thickness)
    {
        circle(d=tally_tab_circle_dia+tally_tab_circle_tol);
        translate([0,0,0])
            square([tally_tab_circle_tab+tally_tab_circle_tol,tally_tab_circle_dia+2], center=true);
    }
}
