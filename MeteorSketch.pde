// libraries
import processing.pdf.*;

// global variables
PShape baseMap;
String csv[];
String myData[][];

// setup
void setup() {
  size(1800, 900);
  noLoop();
  baseMap = loadShape("WorldMap.svg");
  csv = loadStrings("MeteorStrikes.csv");
  myData = new String[csv.length][6];
  
  for(int i=0; i<csv.length; i++) {
    myData[i] = csv[i].split(",");
  }
}

// draw
void draw() {
  beginRecord(PDF, "MeteorStrikes.pdf");
  
  shape(baseMap, 0, 0, width, height);
  
  for(int i=0; i<myData.length; i++) {
    float longCoord = float(myData[i][3]);
    float latCoord = float(myData[i][4]);
    float graphLong = map(longCoord, -180, 180, 0, width);
    float graphLat = map(latCoord, 90, -90, 0, height);
    float markerSize = (sqrt(float(myData[i][2]))/PI) * 0.05;
    
    noStroke();
    fill(255, 0, 0, 50);
    ellipse(graphLong, graphLat, markerSize, markerSize);
    
    // label top ten sized meteors
    if(i<10) {
      fill(0);
      String label = myData[i][0] + " - " + myData[i][1];
      text(label, graphLong + markerSize + 5, graphLat + 3);
      
      noFill();
      stroke(0);
      line(graphLong + markerSize/2, graphLat, graphLong + markerSize, graphLat);
    }
  }
  
  endRecord();
  println("pdf saved");
}
