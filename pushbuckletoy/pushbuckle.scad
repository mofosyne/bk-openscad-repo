// OpenSCAD file automatically generated by svg2cookiercutter.py
wallHeight = 12;
wallFlareWidth = 3;
wallFlareThickness = 1.5;
minWallWidth = 1;
maxWallWidth = 3;
insideWallFlareWidth = 2;
insideWallFlareThickness = 1.5;
minInsideWallWidth = 1;
maxInsideWallWidth = 3;
featureHeight = 2.5;
minFeatureThickness = 0.1;
maxFeatureThickness = 3;
connectorThickness = 1;
size = 50.192;

module dummy() {}

scale = size/50.192;

module ribbon(points, thickness=1, closed=false) {
    p = closed ? concat(points, [points[0]]) : points;
    
    union() {
        for (i=[1:len(p)-1]) {
            hull() {
                translate(p[i-1]) circle(d=thickness, $fn=8);
                translate(p[i]) circle(d=thickness, $fn=8);
            }
        }
    }
}

module cookieCutter() {

path0=scale*[[0.000,30.000],[-50.000,30.000],[-50.000,25.000],[0.000,25.000],[0.000,30.000]];
render(convexity=10) linear_extrude(height=featureHeight) polygon(points=path0);
path1=scale*[[0.009,4.990],[-50.000,4.990],[-50.000,-0.037],[0.009,-0.037],[0.009,4.990]];
render(convexity=10) linear_extrude(height=featureHeight) polygon(points=path1);
path2=scale*[[-0.071,29.912],[-5.027,29.912],[-5.027,-0.088],[-0.071,-0.088],[-0.071,29.912]];
render(convexity=10) linear_extrude(height=featureHeight) polygon(points=path2);
path3=scale*[[-44.962,29.912],[-50.183,29.912],[-50.183,-0.088],[-44.962,-0.088],[-44.962,29.912]];
render(convexity=10) linear_extrude(height=featureHeight) polygon(points=path3);
path4=scale*[[-20.000,22.442],[-23.722,21.548],[-23.722,13.409],[-20.000,12.515],[-23.722,12.515],[-29.990,12.515],[-26.278,13.409],[-26.278,21.548],[-29.990,22.442],[-20.000,22.442]];
render(convexity=10) linear_extrude(height=featureHeight) polygon(points=path4);
path5=scale*[[-24.758,20.010],[-21.345,19.902],[-18.507,19.619],[-16.089,19.219],[-13.941,18.760],[-9.845,17.900],[-7.592,17.617],[-5.000,17.510]];
render(convexity=10) linear_extrude(height=(featureHeight)) ribbon(path5,thickness=min(maxFeatureThickness,max(0.500,minFeatureThickness)));
path6=scale*[[-25.242,20.010],[-28.655,19.902],[-31.493,19.619],[-33.911,19.219],[-36.059,18.760],[-40.155,17.900],[-42.408,17.617],[-45.000,17.510]];
render(convexity=10) linear_extrude(height=(featureHeight)) ribbon(path6,thickness=min(maxFeatureThickness,max(0.500,minFeatureThickness)));
path7=scale*[[-24.758,14.930],[-21.345,14.822],[-18.507,14.539],[-16.089,14.139],[-13.941,13.680],[-9.845,12.820],[-7.592,12.537],[-5.000,12.430]];
render(convexity=10) linear_extrude(height=(featureHeight)) ribbon(path7,thickness=min(maxFeatureThickness,max(0.500,minFeatureThickness)));
path8=scale*[[-25.242,14.930],[-28.655,14.822],[-31.493,14.539],[-33.911,14.139],[-36.059,13.680],[-40.155,12.820],[-42.408,12.537],[-45.000,12.430]];
render(convexity=10) linear_extrude(height=(featureHeight)) ribbon(path8,thickness=min(maxFeatureThickness,max(0.500,minFeatureThickness)));
}

translate([50.183*scale,0.088*scale,0]) cookieCutter();
