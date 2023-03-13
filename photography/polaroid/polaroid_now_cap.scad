// Lens Cover For Polaroid Now Camera
// By Brian Khuu 2023
// Heavy remix of post cap by Seemomster from printables
// Ref: https://www.printables.com/model/220453-post-cap-openscad/files

/* [Viewfinder Cover Dimentions] */
viewfinder_size=20;
viewfinder_offset_from_lense=2;
viewfinder_cover_thickness=0.6;

// Enable Viewfinder Cover. Highly recommended to ensure users do not forget to remove the lens cover.
enable_viewfinder_cover = true;

/* [Lens Cover Dimentions] */
hole_height = 10;
inner_diameter = 43;
wall_thickness = 1;

/* [Lens Cover Smoothing] */
inner_chamfer = 0.4;
bulge_factor = 0.10;

/* [Smoothness] */
$fn = 75;

// Global Calcuation
height = hole_height + 0.5 * wall_thickness;
cap_outer_diameter = inner_diameter + wall_thickness * 2;

module lens_viewfinder_cover(hoffset=0)
{
    hull()
    {
        cylinder (d = cap_outer_diameter, h = viewfinder_cover_thickness+hoffset);
        translate([cap_outer_diameter/2,cap_outer_diameter/2-viewfinder_offset_from_lense-viewfinder_size,0])
        linear_extrude(height = viewfinder_cover_thickness+hoffset)
            offset(viewfinder_offset_from_lense)
                square([viewfinder_size,viewfinder_size]);
    }
}

module lens_cover(hoffset=0)
{
    difference(){
        union(){
            cylinder (d = cap_outer_diameter, h = height);
            translate([0,0,height])
                scale([1,1,bulge_factor])
                    sphere (d = inner_diameter + wall_thickness * 2);
            
            // Viewfinder Cover
            if (enable_viewfinder_cover)
            {
                lens_viewfinder_cover();
                intersection()
                {
                    lens_viewfinder_cover(10);
                    cylinder (d1 = cap_outer_diameter*1.5, d2 = cap_outer_diameter, h = viewfinder_offset_from_lense);
                }
            }
        }

        // Polaroid Text
        translate([0,0,hole_height+0.5])
            linear_extrude(height = 8)
                text("Polaroid", size = 7.5,
                   spacing=1,
                   font = str("Liberation Sans", ":style=Bold"),
                   valign = "center",
                   halign = "center",
                   $fn = 16);

        // Cap Inner
        cylinder (d = inner_diameter, h = hole_height);
        translate([0,0,-0.01])
            cylinder (d1 = inner_diameter + inner_chamfer * 2,d2 = inner_diameter, h = inner_chamfer);
    }
}

lens_cover();