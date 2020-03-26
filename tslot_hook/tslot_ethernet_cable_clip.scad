$fn=100;
/*
    Parametric Cable Hooks For Tslot Mounting of ethernet cables
    By Brian Khuu (2020)
    
    Got a desk with tslot rails, would be nice to mount cable on it...
    
    Inspired by https://www.thingiverse.com/thing:2676595 "V-Slot Cable Clips by pekcitron November 30, 2017"
    
    // Also need to add https://makerware.thingiverse.com/thing:1719073
*/

/* [Tslot Spec] */
// CenterDepth
tslot_centerdepth = 5+0.5;
// CenterWidth
tslot_centerwidth = 8; // Gap to slot the clip though
// For the wedge... its based on a 4040mm Tslot... so may need to modify polygon() in this script

/* [Hook Spec] */
// Spacing between centerpoint
hookcenterspacing=10;
// Hook Diameter
hookdia=10;
// Hook Flange
hookflange=3;
// Hook Width
hookwidth=7;
// Hook Thickness
hookthickness=2;

/* [Tslot Model] */
model_slot_gap = 10;
model_slot_side = 15;


////////
// cable diameter
cable = 7;
// number of cable pairs for holder
rows = 1;
// wall thikness */
thik  = 1.5;
// size of opening for cable
angel = 45; // [90]


outer = cable + 2*thik;


/* single clip, centered */
module clip(cable, outer, angel) {
    difference() {
	union() {
	    /* fill in the middle */
	    translate([-outer/2,0])
	    square(outer/2);
	    translate([-outer/2,-outer/2])
	    square(outer/2);

	    /* outer circle */
	    circle(d=outer);
	}
	/* remove cable circle */
	circle(d=cable);
	polygon(points=[[0,0],[ outer/2, tan(angel)*outer/2],[outer/2,-tan(angel)*outer/2]]);
    }
    /* Add rouded edge */
    hyp = ((outer-cable)/2 + cable)/2;

    translate([ cos(angel)*hyp , sin(angel)*hyp])
    circle(d=(outer-cable)/2);
    translate([ cos(angel)*hyp , -sin(angel)*hyp])
    circle(d=(outer-cable)/2);
}

module clips(num, h, cable, outer, angel) {
    w = (outer) * num;
    translate([0,-w/2+outer/2,-h/2])
    linear_extrude(height=h) {
	for(idx=[0 : 1 : num-1  ]) {
	    translate([0, outer * idx])
	    clip(cable, outer, angel);
	}
    }
}

////////

if (1)
translate([0, -1, 0])
union()
{
    difference()
    {
        union()
        {
            // Tslot Mount Inner
            translate([0, tslot_centerdepth, 0])
                intersection()
                {
                    heightlim=7;
                    linear_extrude(height = hookwidth, center = true)
                        polygon(points=[[-10,0],[-5,8],[5,8],[10,0]]);
                    rotate([-90,0,0])
                        intersection()
                        {
                            hull()
                            {
                                translate([0,0,0]) cylinder(r=10, h=0.1);
                                translate([0,0,8]) cylinder(r=5, h=0.1);
                            }
                            union()
                            {
                                translate([0,0,heightlim/2+tslot_centerdepth/4]) 
                                    cube([20,20,heightlim-tslot_centerdepth/2], center = true);
                                intersection()
                                {
                                    rotate([0,90,0])
                                        translate([-tslot_centerdepth/2,0,0]) 
                                        cylinder(r=hookwidth/2, h=20, center = true);
                                    cube([20,20,hookwidth+1], center = true);
                                }
                            }
                        }
                }

            // tslot mount shaft
            translate([0, -hookthickness, 0])
            rotate([-90,0,0])
                intersection()
                {
                    cheight = tslot_centerdepth+hookthickness+hookwidth/2;
                    union()
                    {
                        cylinder(r=tslot_centerwidth/2, h=cheight);
                    }
                    translate([0, 0, cheight/2])
                        cube([tslot_centerwidth+10, hookwidth, cheight], center=true);
                }
        }
        
        //
        translate([0, 100/2, 0])
            cube([2,100,100], center=true);

    }
 
    //
    translate([0, -hookdia/2-hookthickness, 0])
    rotate([0,0,-90])
    clips(3, hookwidth, cable, outer, angel);

}

%translate([model_slot_side/2+model_slot_gap/2,0,0]) cube([model_slot_side,0.1,100], center=true);
%translate([-model_slot_side/2-model_slot_gap/2,0,0]) cube([model_slot_side,0.1,100], center=true);

