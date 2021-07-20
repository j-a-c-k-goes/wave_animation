final String sketchname = getClass().getName();
import com.hamoid.*;
VideoExport videoExport;
// ===================== global vars
int _num = 10;
float _angleNoise, _radiusNoise;
float _xNoise, _yNoise;
float _angle = -PI/2;
float _radius = 100;
float _strokeCol = 254;
int _strokeChange = -1;

// ===================== initialization

void setup() {
  size(1000, 1000);
  smooth();
  frameRate(24);

  clearBackground();

  _angleNoise = random(5);
  _radiusNoise = random(10);
  _xNoise = random(5);
  _yNoise = random(10);

  /* Video Export Settings */
  //videoExport = new VideoExport(this, "../"+sketchname+".mp4"); 
  //videoExport.setFrameRate(24);
  //videoExport.startMovie();
}

void clearBackground() {
  background (32);
}

// ===================== frame loop

void draw () {
  background (255);
  //String startMessage = ("recording..");
  //println(startMessage);


  _radiusNoise += 0.005;
  _radius = (noise(_radiusNoise) * 550) + 1;

  _angleNoise += 0.005;
  _angle += (noise(_angleNoise) * 6) - 3;
  if (_angle > 360) { 
    _angle -= 360;
  }
  if (_angle < 0) { 
    _angle += 360;
  }

  // wobble centre
  _xNoise += 0.25;
  _yNoise += .75;

  float centreX = width / 2 + (noise(_xNoise) * 100) - 50;
  float centreY = height / 2 + (noise(_yNoise) * 100) - 50;

  float rad = radians(_angle);
  float x1 = centreX + (_radius * tan(rad));
  float y1 = centreY + (_radius * -cos(rad));

  float opprad = radians(_angle);
  //float opprad = rad + PI;
  float x2 = centreX + (_radius * sin(opprad));
  float y2 = centreY + (_radius * sqrt(tan(rad)));

  noFill();
  _strokeCol += _strokeChange;
  if (_strokeCol > 254) { 
    _strokeChange *= -1;
  }
  if (_strokeCol < 0) { 
    _strokeChange *= -1;
  }

  stroke(_strokeCol, 60);
  strokeWeight(4.4 / abs(sin(_yNoise)));
  //strokeWeight(random(255));
  //println(_yNoise);
  stroke(random(255), random(255), random(255));
  triangle(x1, y1, x2, y2, sin(x1), cos(y2));
  x1 += _xNoise * 100;
  x2 /= abs(_xNoise);
  y1 -= .001;
  y2 += .010;

  //videoExport.saveFrame();
}

// ===================== event listener
void mousePressed() {
  clearBackground();
}

void keyPressed() {
  //videoExport.endMovie();
  String message = ("recording has stopped.");
  println(message);
  exit();
}
