void setup() {
  size(800, 800);
  background(255);

  float centreX = width/2;
  float centreY = height/2;

  // Big circle
  noFill();
  stroke(0);
  strokeWeight(2);

  circle(centreX, centreY, 650);

  // Example walks

  drawWalk(
    centreX, centreY,
    0,
    250,
    "fast",
    8,
    "gravel"
  );

  drawWalk(
    centreX, centreY,
    PI/2,
    180,
    "moderate",
    4,
    "grass"
  );

  drawWalk(
    centreX, centreY,
    PI,
    120,
    "slow",
    1,
    "pavement"
  );

  drawWalk(
    centreX, centreY,
    3*PI/2,
    220,
    "fast",
    6,
    "grass"
  );
}

void drawWalk(
  float cx,
  float cy,
  float angle,
  float length,
  String pace,
  int turns,
  String surface
) {

  // PACE = COLOUR

  if (pace.equals("slow")) {
    stroke(60, 120, 255);
  }
  else if (pace.equals("moderate")) {
    stroke(255, 180, 0);
  }
  else {
    stroke(255, 70, 70);
  }

  // SURFACE = WIGGLE HEIGHT

  float amplitude;

  if (surface.equals("pavement")) {
    amplitude = 5;
  }
  else if (surface.equals("grass")) {
    amplitude = 12;
  }
  else if (surface.equals("gravel")) {
    amplitude = 20;
  }
  else {
    amplitude = 10;
  }

  noFill();
  strokeWeight(2);

  float radius = 325;

  beginShape();

  for (float d = 0; d <= length; d += 3) {

    float wave =
      sin(
      map(d,
          0,
          length,
          0,
          TWO_PI * turns)
      )
      * amplitude;

    float r = radius - d;

    float x =
      cx +
      cos(angle) * r +
      cos(angle + HALF_PI) * wave;

    float y =
      cy +
      sin(angle) * r +
      sin(angle + HALF_PI) * wave;

    vertex(x, y);
  }

  endShape();
}
