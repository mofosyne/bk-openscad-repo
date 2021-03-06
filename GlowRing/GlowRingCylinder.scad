
DIA = 53; // mm
RADIUS=DIA/2;
HEIGHT=40;

WAVE_DENSITY = 80;
CIRCUMFRENCE = pow(3.14159*(DIA/2),2);
echo(CIRCUMFRENCE/WAVE_DENSITY);

WAVECOUNT = CIRCUMFRENCE/WAVE_DENSITY;

module SpringRingv3();
{
  i_max=WAVECOUNT;
  THICKNESS=1.5;
  OVERLAP_GAP=THICKNESS*2.5;
  AMP=THICKNESS*2;

  module segment(i)
  {
    rotate(360*(i/i_max))
    translate([RADIUS + ((i%2)?AMP:0) - (THICKNESS+OVERLAP_GAP)*(i/i_max), 0, 0])
    cylinder(r=THICKNESS/2, h=HEIGHT, $fn = 10);
  }

  union(){
    for (i = [0:1:i_max+5])
    {
      hull()
      {
        segment(i);
        segment(i+1);
      }
    }
  }
}

SpringRingv3();

%cylinder(h=HEIGHT+10, r=RADIUS, center=true);


