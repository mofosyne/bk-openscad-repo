$fn=60;
// Ball Mount To Camera Tripod Adapter
// By Brian Khuu 2023

// This was created to make use of the other mount when either the smartphone or tablet is used
// in the Anko Floor Standing Tablet and Smartphone Stand from Kmart 

//////////////////////////////////////////////////////////////////////////////
// ISO Metric Thread Implementation ) (STRIPPED DOWN LIB)
// Trevor Moseley
// 20/04/2014

// For thread dimensions see
//   http://en.wikipedia.org/wiki/File:ISO_and_UTS_Thread_Dimensions.svg

//--pitch-----------------------------------------------------------------------
// function for ISO coarse thread pitch (these are specified by ISO)
function get_coarse_pitch(dia) = lookup(dia, [
[1,0.25],[1.2,0.25],[1.4,0.3],[1.6,0.35],[1.8,0.35],[2,0.4],[2.5,0.45],[3,0.5],[3.5,0.6],[4,0.7],[5,0.8],[6,1],[7,1],[8,1.25],[10,1.5],[12,1.75],[14,2],[16,2],[18,2.5],[20,2.5],[22,2.5],[24,3],[27,3],[30,3.5],[33,3.5],[36,4],[39,4],[42,4.5],[45,4.5],[48,5],[52,5],[56,5.5],[60,5.5],[64,6],[78,5]]);

//--nut dims--------------------------------------------------------------------
// these are NOT specified by ISO
// support is provided for Rolson or Fairbury sizes, see WrenchSizes above

// function for Fairbury hex nut diameter from thread size
function fairbury_hex_nut_dia(dia) = lookup(dia, [
[3,6.0],[4,7.7],[5,8.8],[6,11.0],[8,14.4],[10,17.8],[12,20.0],[16,26.8],[20,33.0],[24,40.0],[30,50.9],[36,60.8]]);

//--bolt dims-------------------------------------------------------------------
// these are NOT specified by ISO
// support is provided for Rolson or Fairbury sizes, see WrenchSizes above

// function for Fairbury hex bolt head diameter from thread size
function fairbury_hex_bolt_dia(dia) = lookup(dia, [
[3,6.4],[4,8.1],[5,8.8],[6,11.1],[8,14.4],[10,17.8],[12,20.1],[16,26.8],[20,33.0],[24,39.6],[30,50.9],[36,60.8]]);

//--top level modules-----------------------------------------------------------

module thread_in(dia,hi,thr=$fn)
// make an inside thread (as used on a nut)
//  dia = diameter, 6=M6 etc
//  hi = height, 10=make a 10mm long thread
//  thr = thread quality, 10=make a thread with 10 segments per turn
{
	p = get_coarse_pitch(dia);
	thread_in_pitch(dia,hi,p,thr);
}

module thread_in_pitch(dia,hi,p,thr=$fn)
// make an inside thread (as used on a nut)
//  dia = diameter, 6=M6 etc
//  hi = height, 10=make a 10mm long thread
//  p=pitch
//  thr = thread quality, 10=make a thread with 10 segments per turn
{
	h=(cos(30)*p)/8;
	Rmin=(dia/2)-(5*h);	// as wiki Dmin
	s=360/thr;				// length of segment in degrees
	t1=(hi-p)/p;			// number of full turns
	r=t1%1.0;				// length remaining (not full turn)
	t=t1-r;					// integer number of turns
	n=r/(p/thr);			// number of segments for remainder
	for(tn=[0:t-1])
		translate([0,0,tn*p])	th_in_turn(dia,p,thr);
	for(sg=[0:n])
		th_in_pt(Rmin+0.1,p,s,sg+(t*thr),thr,h,p/thr);
}

//--low level modules-----------------------------------------------------------

module th_in_turn(dia,p,thr=$fn)
// make an single turn of an inside thread
//  dia = diameter, 6=M6 etc
//  p=pitch
//  thr = thread quality, 10=make a thread with 10 segments per turn
{
	h = (cos(30)*p)/8;
	Rmin = (dia/2) - (5*h);	// as wiki Dmin
	s = 360/thr;
	for(sg=[0:thr-1])
		th_in_pt(Rmin+0.1,p,s,sg,thr,h,p/thr);
}

module th_in_pt(rt,p,s,sg,thr,h,sh)
// make a part of an inside thread (single segment)
//  rt = radius of thread (nearest centre)
//  p = pitch
//  s = segment length (degrees)
//  sg = segment number
//  thr = segments in circumference
//  h = ISO h of thread / 8
//  sh = segment height (z)
{
	as = ((sg % thr) * s - 180);	// angle to start of seg
	ae = as + s -(s/100);		// angle to end of seg (with overlap)
	z = sh*sg;
	pp = p/2;
	//         2,5
	//          /|
	//     1,4 / | 
 	//         \ |
	//          \|
	//         0,3
	//  view from front (x & z) extruded in y by sg
	//  
	polyhedron(
		points = [
			[cos(as)*(rt+(5*h)),sin(as)*(rt+(5*h)),z],				//0
			[cos(as)*rt,sin(as)*rt,z+(3/8*p)],						//1
			[cos(as)*(rt+(5*h)),sin(as)*(rt+(5*h)),z+(3/4*p)],		//2
			[cos(ae)*(rt+(5*h)),sin(ae)*(rt+(5*h)),z+sh],			//3
			[cos(ae)*rt,sin(ae)*rt,z+(3/8*p)+sh],					//4
			[cos(ae)*(rt+(5*h)),sin(ae)*(rt+(5*h)),z+(3/4*p)+sh]],	//5
		faces = [
			[0,1,2],			// near face
			[3,5,4],			// far face
			[0,3,4],[0,4,1],	// left face
			[0,5,3],[0,2,5],	// bottom face
			[1,4,5],[1,5,2]]);	// top face
}


//////////////////////////////////////////////////////////////////////////////
// Loop mount

// Camera Tripod Typical Thread Size
// | Diameter inch | Diameter mm | Thread size |
// |---------------|-------------|-------------|
// | 1/4           | 6.3500      | 20          |
// | 3/8           | 7.9375      | 16          |

cap_height = 20;
hole_dia_tolerance = 0.1;
bottom_screw_size = 6.35;
screw_mount_outer_dia = (fairbury_hex_nut_dia(6.35)+fairbury_hex_nut_dia(7.9375))/2;
ball_midpoint_to_mount_midpoint = cap_height/2+screw_mount_outer_dia/2+3;

intersection()
{
    union()
    {
        difference()
        {
            union()
            {
                cylinder(d = screw_mount_outer_dia, h = cap_height, $fn=60);
                hull()
                {
                    rotate([0,0,90]) translate([(cap_height/2)+(screw_mount_outer_dia/2)*2/3+1,0,0]) cylinder(d = 1.5, h = cap_height, $fn=60);
                    rotate([0,0,-90]) translate([(cap_height/2)+(screw_mount_outer_dia/2)*2/3+1,0,0]) cylinder(d = 1.5, h = cap_height, $fn=60);
                }
            }
            // Bottom thread
            translate([0,0,-0.1])
                cylinder(d = bottom_screw_size+hole_dia_tolerance, h = cap_height-screw_mount_outer_dia/3);
        }
        translate([0,0,0])
            thread_in(bottom_screw_size+hole_dia_tolerance, cap_height-0.2);
    }
    hull()
    {
        cylinder(d = screw_mount_outer_dia, h = 0.1, $fn=60);
        translate([0,screw_mount_outer_dia*1/3,cap_height/2])
            rotate([0,90,0])
                cylinder(d = cap_height/2, h = 0.5, center=true);
        translate([0,-screw_mount_outer_dia*1/3,cap_height/2])
            rotate([0,90,0])
                cylinder(d = cap_height/2, h = 0.5, center=true);
        translate([0,0,cap_height-screw_mount_outer_dia/2])
            sphere(d = screw_mount_outer_dia);
    }
}
