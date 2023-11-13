$fn=50;
box_length = 100;
box_width = 70;
box_wall_thickness = 1;
box_rounding = 5;
box_rounding_tol = 3;

cap_basethickness = 0.5;
cap_wall_thickness = 1.5;
cap_retaining_wall_height = 10;

guidehole_wall_thickness = 1;
guidehole_height = 40;
guidehole_tol = 0.4;
guidehole_entrance_tol = 1; // First layer is squashed

cuphole_wall_thickness = 1;
cuphole_depth = 40;
cuphole_tol = 0.4;

module roundedRectangleBox(width, length, height, radius, scaling=1) {
    translate([width/2,length/2,0])
        linear_extrude(height = height, scale=scaling)
            offset(r=radius) 
                square([width-radius*2, length-radius*2], center=true);
}

difference()
{
    union()
    {
        // Base
        translate([0,0,0])
            roundedRectangleBox(box_length, box_width, cap_basethickness, box_rounding);
            
        // Cap Lips
        translate([box_wall_thickness,box_wall_thickness,0])
        difference()
        {
            width_lip = box_length-box_wall_thickness*2;
            length_lip = box_width-box_wall_thickness*2;
            translate([0, 0, 0])
                roundedRectangleBox(width_lip, length_lip, cap_retaining_wall_height, box_rounding+box_rounding_tol, 0.99);
            translate([cap_wall_thickness, cap_wall_thickness, -0.1])
                roundedRectangleBox(width_lip-cap_wall_thickness*2, length_lip-cap_wall_thickness*2, cap_retaining_wall_height+1, 5);
        }
        
        // Guided Holes
        {
            linear_extrude(height = guidehole_height)
                offset(r=guidehole_wall_thickness+guidehole_tol) 
                translate([box_wall_thickness,box_wall_thickness,0])
                import(file = "toothbrushBoxTopDesign.svg", id="guidedhole");
        }
        
        // Cup Holes
        {
            linear_extrude(height = cuphole_depth)
                offset(r=cuphole_wall_thickness+cuphole_tol) 
                translate([box_wall_thickness,box_wall_thickness,0])
                import(file = "toothbrushBoxTopDesign.svg", id="cuphole");
        }
    }
    translate([box_wall_thickness,box_wall_thickness,-0.1])
    {
        linear_extrude(height = cap_basethickness + 0.2)
            import(file = "toothbrushBoxTopDesign.svg", id="hole");
        linear_extrude(height = guidehole_height + 1)
            offset(r=guidehole_tol) 
            import(file = "toothbrushBoxTopDesign.svg", id="guidedhole");
        linear_extrude(height = cuphole_depth-cap_basethickness)
            offset(r=guidehole_tol) 
            import(file = "toothbrushBoxTopDesign.svg", id="cuphole");
        // Sloped Entrance to guide holes, because the filament squish on first
        // layer of the print wil throw off the tolerance a bit
        for(i = [0 : 0.1 : guidehole_entrance_tol])
        {
            translate([0, 0, 0])
                linear_extrude(height = i)
                offset(r=guidehole_tol+(guidehole_entrance_tol-i)) 
                    import(file = "toothbrushBoxTopDesign.svg", id="guidedhole");
        }
    }
}