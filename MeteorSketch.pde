// libraries


// global variables
PShape baseMap;

// setup
void setup() {
  size(1800, 900);
  baseMap = loadShape("WorldMap.svg");
}

// draw
void draw() {
  shape(baseMap, 0, 0, width, height);
}
