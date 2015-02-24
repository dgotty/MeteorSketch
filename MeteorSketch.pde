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
  // beginRecord(PDF, "MeteorStrikes.pdf");
  
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
        noFill();
        stroke(51, 51, 51);
        strokeWeight(2);
        
        // alternate the sides of the cirls to put the labels
        float arcX = i%2 == 0 ? graphLong + 5 : graphLong - 5;
        float startAngle = i%2 == 0 ? 0 : HALF_PI;
        float stopAngle = i%2 == 0 ? HALF_PI : PI;
        
        arc(arcX, graphLat + 5, markerSize, markerSize, startAngle, stopAngle);
        
        float line1x1 = i%2 == 0 ? (graphLong + markerSize/3) + 10 : (graphLong - markerSize/3) - 10;
        float line1x2 = i%2 == 0 ? (graphLong + markerSize/2) + 10 : (graphLong - markerSize/2) - 10;
        float line2x1 = line1x2;
        float line2x2 = i%2 == 0 ? line2x1 + markerSize/1.5 : line2x1 - markerSize/1.5;
        float line1y1 = (graphLat + markerSize/3) + 5;
        float line1y2 = (graphLat + markerSize/2) + 5;
        float line2y1 = line1y2;
        float line2y2 = line1y2;
        line(line1x1, line1y1, line1x2, line1y2);
        line(line2x1, line2y1, line2x2, line2y2);
        
        noStroke();
        fill(51, 51, 51);
        if(i%2 == 0) {
          textAlign(LEFT);
        } else {
          textAlign(RIGHT);
        }
        String label = myData[i][0] + " - " + myData[i][1];
        float labelX = i%2 == 0 ? line2x1 + 2 : line2x1 + 10;
        float labelY = line2y1 - 5;
        text(label, labelX, labelY);
    }
  }
  
  // endRecord();
  // println("pdf saved");
}
