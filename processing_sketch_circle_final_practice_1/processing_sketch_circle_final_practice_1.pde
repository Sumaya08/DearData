// ArrayList = a flexible list that can store many Walk objects
ArrayList<Walk> walks = new ArrayList<Walk>();

// How many walks are currently visible on screen
int visibleWalks = 0;

// Counts frames for the animation timing
int frameCounter = 0;

// Stores the hover information text
String hoverText = "";

void setup() {

  // Creates an 800 x 800 pixel window
  size(800, 800);

  // Example walk data

  walks.add(new Walk(45, "moderate", 4, "pavement", 2));
  walks.add(new Walk(30, "fast", 8, "grass", 1));
  walks.add(new Walk(20, "slow", 2, "gravel", 0));
  walks.add(new Walk(60, "fast", 10, "grass", 3));
  walks.add(new Walk(35, "moderate", 5, "pavement", 1));
  walks.add(new Walk(45, "moderate", 4, "pavement and grass", 2));
  walks.add(new Walk(63,"slow and moderate", 12, "pavement", 2));
  walks.add(new Walk(15, "fast",2, "pavement", 0));
  walks.add(new Walk(20,"fast", 3, "pavement and carpet", 1));
  walks.add(new Walk(67, "moderate",8,"pavement and grass", 3));
  walks.add(new Walk(67, "moderate", 8, "pavement and grass", 3));
  walks.add(new Walk(42, "fast", 11, "grass", 1));
  walks.add(new Walk(28, "slow", 2, "pavement", 0));
  walks.add(new Walk(55, "moderate", 6, "gravel", 2));
  walks.add(new Walk(73, "fast", 14, "pavement and grass", 1));
  walks.add(new Walk(35, "slow", 4, "pavement", 1));
  walks.add(new Walk(81, "moderate", 10, "grass", 4));
  walks.add(new Walk(24, "fast", 5, "pavement", 0));
  walks.add(new Walk(63, "moderate", 9, "gravel", 2));
  walks.add(new Walk(48, "slow", 3, "pavement and grass", 1));
  walks.add(new Walk(92, "fast", 15, "grass", 3));
  walks.add(new Walk(31, "moderate", 4, "pavement", 0));
  walks.add(new Walk(76, "fast", 12, "gravel", 2));
  walks.add(new Walk(39, "slow", 1, "pavement", 1));
  walks.add(new Walk(58, "moderate", 7, "grass", 2));
  walks.add(new Walk(45, "fast", 8, "pavement and grass", 0));
  walks.add(new Walk(70, "moderate", 11, "gravel", 3));
  walks.add(new Walk(21, "slow", 2, "pavement", 0));
  walks.add(new Walk(83, "fast", 13, "grass", 2));
  walks.add(new Walk(52, "moderate", 5, "pavement and grass", 1));
  walks.add(new Walk(61, "fast", 9, "gravel", 2));
  walks.add(new Walk(27, "slow", 3, "pavement", 0));
  walks.add(new Walk(88, "moderate", 12, "grass", 4));
  walks.add(new Walk(46, "fast", 7, "pavement and grass", 1));
  walks.add(new Walk(34, "moderate", 4, "pavement", 0));
  walks.add(new Walk(79, "fast", 16, "gravel", 3));
  walks.add(new Walk(53, "slow", 5, "grass", 1));
  walks.add(new Walk(66, "moderate", 10, "pavement and grass", 2));
  walks.add(new Walk(29, "fast", 6, "pavement", 0));
  walks.add(new Walk(95, "moderate", 14, "grass", 5));
}

void draw() {

  // Clears the screen every frame
  background(#F0DCEE);

  // Centre coordinates of the circle
  float centreX = width/2;
  float centreY = height/2;

  // Radius of the big circle
  float radius = 350;

  // Clears previous hover text
  hoverText = "";

  // Draw the main circle
  stroke(#FFFAFE);
  strokeWeight(4);
  noFill();

  // Diameter is radius × 2
  circle(centreX, centreY, radius * 2);

  // Increase the frame counter every frame
  frameCounter++;

  // Reveal one new walk every 40 frames
  if (frameCounter % 20 == 0 &&
      visibleWalks < walks.size()) {

    visibleWalks++;
  }

  // Draw all currently visible walks
  for (int i = 0; i < visibleWalks; i++) {

    // Spread walks evenly around the circle

    float angle =
      map(
      i,
      0,
      walks.size(),
      0,
      TWO_PI
      );

    drawWalk(
      walks.get(i),
      centreX,
      centreY,
      radius,
      angle,
      i+1
      );
  }

  // Draw information pop-up if mouse is hovering

  if (!hoverText.equals("")) {

    fill(255);
    stroke(2);

    rect(
      mouseX + 15,
      mouseY + 15,
      170,
      110,
      10
      );

    fill(0);
    textAlign(LEFT);

    text(
      hoverText,
      mouseX + 25,
      mouseY + 35
      );
  }
}

void drawWalk(

  Walk walk,      // Current walk being drawn
  float cx,       // Circle centre x
  float cy,       // Circle centre y
  float radius,   // Circle radius
  float angle,    // Position around circle
  int walkNumber

) {

  // -----------------------
  // PACE = COLOUR
  // -----------------------

  if (walk.pace.equals("slow")) {

    stroke(#BDCBF0); // blue
  }
  else if (walk.pace.equals("moderate")) {

    stroke(#E09AB4); // dark prink
  }
  else {

    stroke(#917FCE); // prurple
  }

  // -----------------------
  // SURFACE = WIGGLE HEIGHT
  // -----------------------

  float amplitude;

  if (walk.surface.equals("pavement")) {

    // Small wiggles
    amplitude = 5;
  }
  else if (walk.surface.equals("grass")) {

    // Medium wiggles
    amplitude = 15;
  }
  else if (walk.surface.equals("gravel")) {

    // Large wiggles
    amplitude = 25;
  }
  else {

    amplitude = 10;
  }

  // Duration controls path length

  float pathLength = walk.duration * 3;

  noFill();
  strokeWeight(2);

  beginShape();

  float finalX = 0;
  float finalY = 0;

  // Move along the path

  for (float d = 0; d <= pathLength; d += 4) {

    // =======================================
    // TURNS = WIGGLE FREQUENCY
    // =======================================

    float wave =

      sin(

      map(
      d,
      0,
      pathLength,
      0,
      TWO_PI * walk.turns
      )

      )

      * amplitude;

    // Move inward from the circle edge

    float r = radius - d;

    // Stop paths reaching the exact centre

    if (r < 20) {

      r = 20;
    }

    // X position

    float x =

      cx +
      cos(angle) * r +

      // Adds wiggle sideways

      cos(angle + HALF_PI) * wave;

    // Y position

    float y =

      cy +
      sin(angle) * r +

      // Adds wiggle sideways

      sin(angle + HALF_PI) * wave;

    vertex(x, y);

    // Remember the last point

    finalX = x;
    finalY = y;
  }

  endShape();

  // -----------------------
  // HOVER DETECTION
  // -----------------------

  float hoverDistance =

    dist(
    mouseX,
    mouseY,
    finalX,
    finalY
    );

  // If mouse is close to endpoint

  if (hoverDistance < 20) {

    hoverText =

      "Walk #" + walkNumber + "\n\n" +

      walk.duration + " mins\n" +

      walk.pace + " pace\n" +

      walk.turns + " turns\n" +

      walk.surface + "\n" +

      walk.breaks + " breaks";

    // Small dot showing selected walk

    noStroke();
    fill(0);

    circle(
      finalX,
      finalY,
      12
      );
  }
}


// =========================
// WALK CLASS
// =========================

class Walk {

  // Variables that store one walk's data

  int duration;
  String pace;
  int turns;
  String surface;
  int breaks;

  // Constructor

  Walk(

    int duration,
    String pace,
    int turns,
    String surface,
    int breaks

  ) {

    // "this" means this object's variables

    this.duration = duration;
    this.pace = pace;
    this.turns = turns;
    this.surface = surface;
    this.breaks = breaks;
  }
}
