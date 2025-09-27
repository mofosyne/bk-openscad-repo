/* KEEPTEEN D5 Lora Sled for Heltec v3 (and other slideable PCB) */
// This is intended to allow for mounting meshtastic/meshcore/rnodes in a lipo based solar powered node. Tested against a KEEPTEEN D5 Solar Lora Repeater enclosure.

// Brian Khuu 2025

/* [PCB] */
// PCB Thickness
pcb_thickness = 1.7;

// PCB Width
pcb_width = 26.0;

// PCB Top Clearance Height
pcb_top_clearance_height = 3;

// PCB Top Clearance Width
pcb_top_clearance_width = 23.0;

// PCB Bottom Clerance Height
pcb_bottom_clearance_height = 3;

// PCB Bottom Clearance Width
pcb_bottom_clearance_width = 23.0;

// PCB Bottom Plug Clerance Height
pcb_bottom_plug_clearance_height = 5;

// PCB Bothm Plug Clerance Width
pcb_bottom_plug_clearance_width = 10.0;

/* [Tray] */

// Tray Holder Height
holder_h = 11;

// Tray Holder Width
holder_w = 45;

// Tray PCB Slot Count
tray_pcb_slot_count = 2;

// Cell Count
cell_count=6;

/* [Rendering] */
$fn=80;

module pcb_slide()
{
    // PCB
    translate([0,0,0])
        cube([pcb_width,holder_w+1,pcb_thickness], center=true);
    // Top Clearance
    translate([0,0,pcb_top_clearance_height/2])
        cube([pcb_top_clearance_width,holder_w+1,pcb_top_clearance_height], center=true);
    // Bottom Clearance
    translate([0,0,-pcb_bottom_clearance_height/2])
        cube([pcb_bottom_clearance_width,holder_w+1,pcb_bottom_clearance_height], center=true);
    // Bottom Plugs
    translate([0,0,-pcb_bottom_plug_clearance_height/2])
        cube([pcb_bottom_plug_clearance_width,holder_w+1,pcb_bottom_plug_clearance_height], center=true);
}

rotate([90,0,0])
difference()
{
    // Tray Bulk
    translate([0,0,0-holder_h])
        intersection()
        {
            translate([0,-holder_w/2,0])
                cube([1 + (pcb_width + 1) * tray_pcb_slot_count,holder_w,holder_h]);

            union()
            {
                translate([0,-65/2,18/2])
                    cube([cell_count* 18 + 1,65,18/2]);

                hull()
                {

                    translate([0,-65/2,5])
                        cube([cell_count* 18 + 1,65,18/2]);
                    
                    translate([0,-38/2,4])
                        cube([cell_count* 18 + 1,38,1]);
                }

                hull()
                {
                    translate([0,-38/2,4])
                        cube([cell_count* 18 + 1,38,1]);

                    translate([0,-(38-10)/2,0])
                        cube([cell_count* 18 + 1,38-10,4]);
                }

                translate([0,-65/2,5])
                    cube([cell_count* 18 + 1,65,18/2]);

                for(i = [1 : 1 : cell_count])
                {
                    translate([i * 18 - 18/2 + 1 ,0,18/2])
                        rotate([90,0,0])
                        cylinder(h=65, d=18, center=true);
                }
            }
        }

    // PCB Slide Cutout
    for ( i = [ 0 : 1 : tray_pcb_slot_count-1])
        translate([pcb_width/2 + 1 + ((pcb_width + 1) * i),0,-pcb_top_clearance_height+0.01])
            pcb_slide();
}