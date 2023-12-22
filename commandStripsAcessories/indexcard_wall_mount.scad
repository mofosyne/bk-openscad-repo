// INDEX CARD FIFO

// Office Works Index Card measured with micrometer to be 0.255
// You may want to add some more tolerance to account for varying card thickness

/* [Card Spec] */
// 76 x 127mm (More like 126mm width when measured)
card_width = 126;
card_width_tol = 0.1;
card_height = 76;
card_height_tol = 0.1;
card_thickness = 0.25;
card_thickness_tol = 0.15;

/* [Command Strip] */

// Command Strip Width
commandstrip_w = 16/2; // 16mm width strip, but cut in half

// Command Strip Height (Not including the pull tab)
commandstrip_h = 50;

// Command Strip Thickness
commandstrip_thickness = 1.0;

/* [Wall Mount Spec] */
mount_slot_count = 2;

mount_card_slide = card_thickness * 2 - 0.1;
mount_card_funnel = 2;
mount_card_grip_depth = 3;
mount_width = commandstrip_w;
mount_thickness = 0.8;

echo (mount_card_slide)

if (1)
%translate([0,0,(card_width+card_width_tol)/2+(commandstrip_w/2-mount_card_grip_depth)])
    cube([card_height+card_height_tol, card_thickness+card_thickness_tol, card_width+card_width_tol], center=true);


module cardSlit(card_mount_height, card_mount_thickness)
{
    main_slide_bottom_width = mount_card_slide;
    main_slide_width = mount_card_slide+card_thickness_tol;
    main_slide_flairout = card_thickness+card_thickness_tol*4+1;
    hull()
    {
        // Main Slide Channel
        translate([0,0,(commandstrip_w/2-mount_card_grip_depth)])
            cube([card_mount_height+1, main_slide_bottom_width, 0.01], center=true);
        translate([0,0,(commandstrip_w/2)-0.5])
            cube([card_mount_height+1, main_slide_width, 0.01], center=true);
    }
    hull()
    {
        // Flair Out (Since the first few sub mm on plate will be very inaccurate due to plate squish)
        translate([0,0,(commandstrip_w/2)-0.5])
            cube([card_mount_height+1, main_slide_width, 0.01], center=true);
        translate([0,0,(commandstrip_w/2)])
            cube([card_mount_height+1, main_slide_flairout, 0.01], center=true);
    }

    // Funnels
    translate([0,0,(commandstrip_w/2 - mount_card_grip_depth)+0.01])
    hull()
    {
        translate([card_mount_height/2-10,0,mount_card_grip_depth/2])
            cube([0.1, card_thickness+card_thickness_tol, mount_card_grip_depth], center=true);
        translate([card_mount_height/2,0,mount_card_grip_depth/2])
            cube([0.1, mount_card_funnel, mount_card_grip_depth+mount_card_funnel], center=true);
    }

    translate([0,0,(commandstrip_w/2 - mount_card_grip_depth)+0.01])
    hull()
    {
        translate([-card_mount_height/2+10,0,mount_card_grip_depth/2])
            cube([0.1, card_thickness+card_thickness_tol, mount_card_grip_depth], center=true);
        translate([-card_mount_height/2,0,mount_card_grip_depth/2])
            cube([0.1, mount_card_funnel, mount_card_grip_depth+mount_card_funnel], center=true);
    }
}

difference()
{
    card_mount_height = (card_height+card_height_tol)*mount_slot_count;
    card_mount_thickness = card_thickness+mount_card_funnel+mount_thickness*2+commandstrip_thickness/2;
    
    translate([0,commandstrip_thickness/4,0])
        cube([card_mount_height, card_mount_thickness, mount_width], center=true);

    // Card Slit
    rotate([0,0,0])
        cardSlit(card_mount_height, card_mount_thickness);
    if (1)
    rotate([0,180,0])
        cardSlit(card_mount_height, card_mount_thickness);

    // Command Strip
    translate([card_mount_height/2-commandstrip_h/2,card_mount_thickness/2+commandstrip_thickness/4+0.01,0])
        cube([commandstrip_h+0.01,commandstrip_thickness,commandstrip_w+0.1], center=true);
    translate([-card_mount_height/2+commandstrip_h/2,card_mount_thickness/2+commandstrip_thickness/4+0.01,0])
        cube([commandstrip_h+0.01,commandstrip_thickness,commandstrip_w+0.1], center=true);

    // Slot
    if (0)
    hull()
    {
        translate([card_mount_height/2-15,0,0])
            cube([0.1, card_thickness+card_thickness_tol, mount_width+0.1], center=true);
        translate([card_mount_height/2-10,0,0])
            cube([0.1, mount_card_funnel, mount_width+0.1], center=true);
        translate([card_mount_height/2,0,0])
            cube([0.1, mount_card_funnel, mount_width+0.1], center=true);

        translate([card_mount_height/2-10,-card_mount_thickness/2,0])
            cube([0.1, mount_card_funnel, mount_width+0.1], center=true);
        translate([card_mount_height/2,-card_mount_thickness/2,0])
            cube([0.1, mount_card_funnel, mount_width+0.1], center=true);
    }
}

