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
path4=scale*[[-20.000,22.477],[-23.722,21.584],[-23.722,13.391],[-20.000,12.497],[-23.722,12.497],[-29.990,12.497],[-26.278,13.391],[-26.278,21.584],[-29.990,22.477],[-20.000,22.477]];
render(convexity=10) linear_extrude(height=featureHeight) polygon(points=path4);
path5=scale*[[-24.900,20.021],[-20.793,19.913],[-17.614,19.627],[-15.132,19.224],[-13.113,18.762],[-9.530,17.898],[-7.500,17.615],[-5.000,17.510]];
render(convexity=10) linear_extrude(height=(featureHeight)) ribbon(path5,thickness=min(maxFeatureThickness,max(0.500,minFeatureThickness)));
path6=scale*[[-25.051,21.701],[-22.525,19.976],[-25.025,18.177],[-25.051,21.701]];
render(convexity=10) linear_extrude(height=featureHeight) polygon(points=path6);
path7=scale*[[-3.898,19.241],[-6.424,17.517],[-3.924,15.718],[-3.898,19.241]];
render(convexity=10) linear_extrude(height=featureHeight) polygon(points=path7);
path8=scale*[[-25.076,20.021],[-29.184,19.913],[-32.362,19.627],[-34.844,19.224],[-36.864,18.762],[-40.447,17.898],[-42.476,17.615],[-44.976,17.510]];
render(convexity=10) linear_extrude(height=(featureHeight)) ribbon(path8,thickness=min(maxFeatureThickness,max(0.500,minFeatureThickness)));
path9=scale*[[-24.926,21.701],[-27.451,19.976],[-24.951,18.177],[-24.926,21.701]];
render(convexity=10) linear_extrude(height=featureHeight) polygon(points=path9);
path10=scale*[[-46.078,19.241],[-43.552,17.517],[-46.053,15.718],[-46.078,19.241]];
render(convexity=10) linear_extrude(height=featureHeight) polygon(points=path10);
path11=scale*[[-24.900,14.941],[-20.793,14.833],[-17.614,14.547],[-15.132,14.144],[-13.113,13.682],[-9.530,12.818],[-7.500,12.535],[-5.000,12.430]];
render(convexity=10) linear_extrude(height=(featureHeight)) ribbon(path11,thickness=min(maxFeatureThickness,max(0.500,minFeatureThickness)));
path12=scale*[[-25.051,16.621],[-22.525,14.896],[-25.025,13.097],[-25.051,16.621]];
render(convexity=10) linear_extrude(height=featureHeight) polygon(points=path12);
path13=scale*[[-3.898,14.161],[-6.424,12.437],[-3.924,10.638],[-3.898,14.161]];
render(convexity=10) linear_extrude(height=featureHeight) polygon(points=path13);
path14=scale*[[-25.076,14.941],[-29.184,14.833],[-32.362,14.547],[-34.844,14.144],[-36.864,13.682],[-40.447,12.818],[-42.476,12.535],[-44.976,12.430]];
render(convexity=10) linear_extrude(height=(featureHeight)) ribbon(path14,thickness=min(maxFeatureThickness,max(0.500,minFeatureThickness)));
path15=scale*[[-24.926,16.621],[-27.451,14.896],[-24.951,13.097],[-24.926,16.621]];
render(convexity=10) linear_extrude(height=featureHeight) polygon(points=path15);
path16=scale*[[-46.078,14.161],[-43.552,12.437],[-46.053,10.638],[-46.078,14.161]];
render(convexity=10) linear_extrude(height=featureHeight) polygon(points=path16);
}

translate([50.183*scale,0.088*scale,0]) cookieCutter();
