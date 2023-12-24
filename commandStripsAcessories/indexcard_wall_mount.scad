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

mount_width = commandstrip_w;

// Dev Note: We don't actually need to make the card form fittin. 
// The card will flex outward a bit... so we just need to make sure it large enough
// The flexing card will prevent cards upward from sliding downward anyway... so we are good
//mount_card_slide = card_thickness * 4 - 0.1;
mount_card_slide = 2.0;
mount_card_funnel = 2.5;
mount_card_grip_depth = 6;
mount_thickness = 0.6;

echo (mount_card_slide)

if (0)
%translate([0,0,(card_width+card_width_tol)/2+(commandstrip_w-mount_card_grip_depth)])
    cube([card_height+card_height_tol, card_thickness+card_thickness_tol, card_width+card_width_tol], center=true);

module cardSlit(card_mount_height, card_mount_thickness, mount_width)
{
    main_slide_bottom_width = card_thickness+card_thickness_tol*2;
    main_slide_width = card_thickness*3+card_thickness_tol;
    main_slide_flairout = card_thickness+mount_card_funnel;
    hull()
    {
        // Main Slide Channel
        translate([0,0,(mount_width-mount_card_grip_depth)])
            cube([card_mount_height+50, main_slide_bottom_width, 0.01], center=true);
        translate([0,0,(mount_width)-mount_card_grip_depth*1/3])
            cube([card_mount_height+50, main_slide_width, 0.01], center=true);
    }
    hull()
    {
        // Flair Out (Since the first few sub mm on plate will be very inaccurate due to plate squish)
        translate([0,0,(mount_width)-mount_card_grip_depth*1/3])
            cube([card_mount_height+50, main_slide_width, 0.01], center=true);
        translate([0,0,(mount_width)])
            cube([card_mount_height+50, main_slide_flairout, 0.01], center=true);
    }

    // Funnels
    translate([0,0,(mount_width - mount_card_grip_depth)+0.01])
    hull()
    {
        translate([card_mount_height/2-10,0,mount_card_grip_depth/2])
            cube([0.1, card_thickness+card_thickness_tol, mount_card_grip_depth], center=true);
        translate([card_mount_height/2,0,mount_card_grip_depth/2])
            cube([0.1, mount_card_funnel, mount_card_grip_depth+mount_card_funnel], center=true);
    }
}

difference()
{
    card_mount_height = (card_height+card_height_tol)*mount_slot_count;
    card_mount_thickness = card_thickness+mount_card_funnel+mount_thickness*2;
    
    union()
    {
        translate([0,0,mount_width/2])
            cube([card_mount_height, card_mount_thickness, mount_width], center=true);

       translate([0,0,mount_width])
            hull()
            {
                translate([-card_mount_height/2-2,0,-mount_card_grip_depth/2])
                    cube([0.1, card_thickness+card_thickness_tol, mount_card_grip_depth], center=true);
                translate([-card_mount_height/2,0,-mount_card_grip_depth/2-mount_card_funnel/4])
                    cube([0.1, mount_card_funnel, mount_card_grip_depth+mount_card_funnel/2], center=true);
            }

       translate([0,0,mount_width])
            hull()
            {
                translate([-card_mount_height/2-2,0,-mount_card_grip_depth/2])
                    cube([0.1, card_thickness+card_thickness_tol, mount_card_grip_depth], center=true);
                translate([-card_mount_height/2,0,-mount_card_grip_depth/2-mount_card_funnel/4])
                    cube([0.1, mount_card_funnel, mount_card_grip_depth+mount_card_funnel/2], center=true);
            }
    }

    // Card Slit
    translate([0,0,0])
        cardSlit(card_mount_height, card_mount_thickness, mount_width);

    // This represents the next slide we can connect to
    if (0)
    %translate([0,0,(mount_width - mount_card_grip_depth)+0.01])
    hull()
    {
        translate([-card_mount_height/2-5,0,mount_card_grip_depth/2])
            cube([0.1, card_thickness+card_thickness_tol, mount_card_grip_depth], center=true);
        translate([-card_mount_height/2,0,mount_card_grip_depth/2])
            cube([0.1, mount_card_funnel, mount_card_grip_depth+mount_card_funnel], center=true);
    }
    
}

