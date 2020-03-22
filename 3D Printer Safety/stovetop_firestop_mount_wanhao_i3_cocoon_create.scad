/*
    stovetop firestop mount for Mounting Clip For Cocoon Create and Wanhao i3 
    By Brian Khuu 2020    
*/
$fn=100;

printer_frame_mount_width = 10;
stfs_angle = -45/2;

/* 
# Stove Top Fire Stop
Settings */
stfs_tolerance = 1.5; // Tolerance (screw head is large)
stfs_between_space = 25; // Spacing between
hang_holes = 2;   // Diameter of holes for the wall hanging string
hang_hole_interspace = 4; // Spacing between hanging holes
hang_to_stfs_space = 5; // Spacing between the hanging and stfs holes

/* 
# STFS Dimentions */
stfs_head = 6.3; // Diameter of the screw head
stfs_holes = 2.7;   // Diameter of stovetop firestop retaining screws
stfs_b_dia = 85.23; // Diameter of stovetop firestop body
stfs_b_h = 55;      // Approx height of stovetop firestop body

/* 
# STFS Calc */
stfs_head_dia = stfs_head+stfs_tolerance+1;
stfs_hole_dia = stfs_holes+stfs_tolerance; // Alignment Pin Diamenter
hang_pin_dia = hang_holes; // Probe Pin Diameter



/*
# 3D printer Frame Clip
[<====y====>]
[ ^ ]
[ | ]
[ x ]
[ | ]
[ V ]
*/
printer_frame_tol=1;
printer_frame_clip_thickness=1.5;
printer_frame_y_lenght = 50+2;
printer_frame_x_lenght = 50+2;
metal_sheet_thickness=2+printer_frame_tol;

module sheet_metal(width)
{
    translate([0,0,-1])
    union()
    {
        hull()
        {
            translate([0,0,0])
                cylinder(r=metal_sheet_thickness/2, h=width+2);
            translate([0,printer_frame_y_lenght-metal_sheet_thickness,0])
                cylinder(r=metal_sheet_thickness/2, h=width+2);
        }
        hull()
        {
            translate([0,0,0])
                cylinder(r=metal_sheet_thickness/2, h=width+2);
            translate([printer_frame_x_lenght-metal_sheet_thickness,0,0])
                cylinder(r=metal_sheet_thickness/2, h=width+2);
        }
        cube([(printer_frame_x_lenght-metal_sheet_thickness),(printer_frame_y_lenght-metal_sheet_thickness)*3/4,width+2]);
    }
}

module sheet_metal_clip(width, thickness)
{
    diameter=metal_sheet_thickness+thickness*2;
    translate([thickness*2,thickness*2, 0])
    difference()
    {
        union()
        {
            /* Firestop mount*/
            firestopmount_dia = 4;
            firestopmountb_dia = 4;
            translate([-thickness*2-firestopmount_dia/2,0,0])
            hull()
            {
                translate([0,-stfs_b_dia/2-20,0])
                    cylinder(r=firestopmount_dia/2, h=width);
                translate([0,printer_frame_y_lenght+stfs_b_dia/2+14.5,0])
                    cylinder(r=firestopmount_dia/2, h=width);
            }
            translate([-thickness*2-firestopmount_dia/2, 
                        printer_frame_y_lenght+stfs_b_dia/2+5, 
                        width/2])
            hull()
            {
                translate([0,0,0])
                    cube([firestopmountb_dia/2,20,width], center=true);
                translate([-10,0,0])
                    cylinder(r=firestopmountb_dia/2, h=width, center=true);
            }
            translate([-thickness*2-firestopmount_dia/2, 
                        -stfs_b_dia/2-10, 
                        width/2])
            hull()
            {
                translate([0,0,0])
                    cube([firestopmountb_dia/2,20,width], center=true);
                translate([-10,0,0])
                    cylinder(r=firestopmountb_dia/2, h=width, center=true);
            }
            
            /* Clip */
            hull()
            {
                translate([0,0,0])
                    cylinder(r=diameter/2, h=width);
                translate([0,printer_frame_y_lenght-diameter/2,0])
                    cylinder(r=diameter/2, h=width);
            }
            hull()
            {
                translate([0,0,0])
                    cylinder(r=diameter/2, h=width);
                translate([printer_frame_x_lenght-diameter/2,0,0])
                    cylinder(r=diameter/2, h=width);
            }
            
            /* Tab */
            hull()
            {
                translate([printer_frame_x_lenght-diameter/2,0,0])
                    cylinder(r=diameter/2, h=width);
                translate([printer_frame_x_lenght-diameter/2+10,0,0])
                    cylinder(r=1, h=width);
            }
        }
        sheet_metal(width);
        
        /* STFS mount holes */
        #translate([-thickness,0, 0])
        translate([-5,0,0])
        rotate([0,stfs_angle,0]) 
        union()
        {
            translate([0 , printer_frame_y_lenght+stfs_b_dia/2+5, width/2]) 
                rotate([0,180+90,0])   
                    cylinder(r=stfs_hole_dia/2, h=100, center=true);  
            translate([0, -stfs_b_dia/2-10, width/2]) 
                rotate([0,180+90,0])   
                    cylinder(r=stfs_hole_dia/2, h=100, center=true);
        }
    }

    /* STFS mount dummy */
    if (1)
    {        
        %rotate([0,stfs_angle,0])   
            translate([10 , printer_frame_y_lenght+stfs_b_dia/2+10, width/2]) 
            rotate([0,90,0])   
                cylinder(r=stfs_b_dia/2, h=stfs_b_h);
        %rotate([0,stfs_angle,0])   
            translate([10 , -stfs_b_dia/2-5, width/2]) 
            rotate([0,90,0])   
                cylinder(r=stfs_b_dia/2, h=stfs_b_h);
    }
    
}



/* Clip */
rotate([180,0,0])
sheet_metal_clip(printer_frame_mount_width,printer_frame_clip_thickness);