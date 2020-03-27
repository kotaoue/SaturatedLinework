PImage background_img;
PImage ba_img;
PImage a_img;
PImage hyphen_img;
PImage nn_img;

void setup() {
  size(1280, 720);

  // If "bg.jpg" and "bg.png" are exists prioritize "bg.jpg".
  if (background_img == null) {
    loadBackgroundImage("bg.jpg");
  }
  if (background_img == null) {
    loadBackgroundImage("bg.png");
  }
  if (background_img != null) {
    background_img.resize(width, 0);
  }

  ba_img= loadImage("ba.png");
  a_img = loadImage("a.png");
  hyphen_img = loadImage("hyphen.png");
  nn_img = loadImage("nn.png");

  noLoop();
}

void draw() {
  int x_outer_radius = width / 2;
  int y_outer_radius = height / 2;
  float angle = random(2.95, 3.1);

  background(255);
  if (background_img != null) {
    image(background_img, 0, 0);
  }

  translate(x_outer_radius, y_outer_radius);
  pushMatrix();
  for (int i = 0; i < 360 / angle; i++) {
    rotate(radians(angle));
    stroke(0);
    int min_stroke = 1;
    int max_stroke = 5;
    // When loaded background image. Change line stroke to bold.
    if (background_img != null) {
      min_stroke = 2;
      max_stroke = 6;
    }
    strokeWeight(int(noise(angle) * random(min_stroke, max_stroke)));

    int x_inner_radius = x_outer_radius / 20;
    int y_inner_radius = y_outer_radius / 20;
    float inner_radius_margin = noise(angle)* random(-x_inner_radius, y_inner_radius);
    line(x_inner_radius + inner_radius_margin, y_inner_radius + inner_radius_margin, x_outer_radius, y_outer_radius);
  }
  popMatrix();

  resetMatrix();

  // When you modify image pos by using "Tweak". Recommend comment out "noLoop()" in "setUp()". 
  drawImage(ba_img, 359, (height * 0.4));
  drawImage(a_img, 510, (height * 0.4));
  drawImage(hyphen_img, 1029, (height * 0.4));
  drawImage(nn_img, 1294, (height * 0.4));

  save("zoom_bg.png");
}

void drawImage(PImage img, float x, float y) {
  image(img, (x - img.width), (y - img.height));
}

void loadBackgroundImage(String filename) {
  File f = new File(dataPath(filename));
  if (f.exists())
  {
    background_img= loadImage(filename);
  }
}
