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
card_thickness_tol = 0.10;

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
mount_card_funnel = 3.0;
mount_card_grip_depth = 6;
mount_thickness = 0.6;

echo (mount_card_slide)

translate([0,0,1])
    %cube([card_height, card_width, card_thickness], center=true);

difference()
{
    guide_width = card_width+mount_card_grip_depth/2;
    cube([card_height*mount_slot_count, guide_width, 0.50], center=true);
    cube([card_height*mount_slot_count-30, guide_width-mount_card_grip_depth*2, 1], center=true);
}