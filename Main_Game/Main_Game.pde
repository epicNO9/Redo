Camera Camera0;
PImage[] head_image = new PImage[5];
Star star1, star2, star3, star4, star5, star6;
boolean stopper;
float transX, transY, diffX, diffY;
boolean mouseIsPressed, mouseOver, zoom, full, dead;
float transpar = 0;
float health = 599, red, green=255, blue=128;
float theta;
float zoomXPos, zoomYPos;
boolean changerStopper;
float headAngle = PI/2;
float scaler = 1; 
void setup() {
    size(720, 480);
    //fullScreen();
    frameRate(60);
    imageMode(CENTER);
    for (int i = 1; i < 5; i++) {
        String imageName = "frame" + i + ".gif";
        head_image[i] = loadImage(imageName);
    }
    star1 = new Star(width+100, height/2, #FFA000, "10 Trillion", false, false, ""); 
    star2 = new Star(width+100, -200, #FFC000, "Zero", false, true, "Uhh, this star has a poopy butthole"); 
    star3 = new Star(-200, height+100, #FFB000, "327", false, true, "");
    star4 = new Star(-1000, -150, #AFCFFF, "5 Quintillion", false, false, "");
    star5 = new Star(width+400, height+200, #C000FF, "10 Billion", true, false, "");
    Camera0 = new Camera();
    Camera0.position = new PVector(0, 0);
    Camera0.velocity = new PVector(0, 0);
    textAlign(CENTER, CENTER);
    rectMode(CENTER);
    Seg0 = new Segment();
    Seg0.position = new PVector(-Camera0.position.x + width/2, -Camera0.position.y + height/2);
    Seg0.velocity = new PVector(0, 0);
    Seg1 = new Segment();
    Seg1.position = new PVector(-Camera0.position.x + width/2, -Camera0.position.y + height/2);
    Seg1.velocity = new PVector(0, 0);
    Seg2 = new Segment();
    Seg2.position = new PVector(-Camera0.position.x + width/2, -Camera0.position.y + height/2);
    Seg2.velocity = new PVector(0, 0);
    Tail = new Segment();
    Tail.position = new PVector(-Camera0.position.x + width/2, -Camera0.position.y + height/2);
    Tail.velocity = new PVector(0, 0);
    cis = new System(new PVector(width+100, height/2), #FFA000);
    cis2 = new System(new PVector(width+100, -200), #FFC000);
    cis3 = new System(new PVector(-200, height+100), #FFB000);
    cis4 = new System(new PVector(-1000, -150), #AFCFFF);
    cis5 = new System(new PVector(width+400, height+200), #C000FF);
}
void draw() {
    background(0);
    fill(255);
    translate(Camera0.position.x, Camera0.position.y);
    //println(Camera0.position.x);
    //println(Camera0.position.y);
    transX = Camera0.position.x;
    transY = Camera0.position.y;
    //bgStars();
    runParticles();
    star1.create();
    star2.create();
    star3.create();
    star4.create();
    star5.create();
    fill(255, 0, 0);
    if (dead) 
        fill(0, 0, 255);
    stroke(0);
    hunger();
    if (!zoom) {
        pushMatrix();
        translate(-Camera0.position.x + width/2, -Camera0.position.y + height/2);
        rotate(headAngle-PI/2);
        playerAnimation();
        popMatrix();

        //Seg0.followHead();
        //Seg1.follow1();
        //Seg2.follow2();
        //Tail.follow3();
    }
    Camera0.moveCamera();
}

void mousePressed() {
    mouseIsPressed = true;
    changerStopper = true;
}
void mouseReleased() {
    mouseIsPressed = false;
    stopper = false;
}
class Camera {
    PVector position;
    PVector velocity;

    void moveCamera() {
        if (mouseIsPressed && !mouseOver && !zoom && !stopper && !dead) {
            diffX = mouseX - width/2;
            diffY = mouseY - height/2;
            Camera0.velocity.x = -diffX/100;
            Camera0.velocity.y = -diffY/100;
            headAngle = atan2(mouseY - height/2, mouseX - width/2);
            Seg0.blahY[5] = -Camera0.velocity.y;
        }
        Camera0.position.add(Camera0.velocity);
    }
}
class Star {
    float xPos, yPos, xSize =50, ySize = 50;
    color c;
    String number;
    boolean isZoomed;
    boolean isEaten;
    boolean isBlackHole;
    boolean doesNeedNotes;
    String theNotes;
    Star(float tempxPos, float tempyPos, color tempColor, String tempNum, boolean tempBlack, boolean needsNotes, String notes) {
        xPos = tempxPos;
        yPos = tempyPos;
        c = tempColor;
        number = tempNum;
        isBlackHole = tempBlack;
        doesNeedNotes = needsNotes;
        theNotes = notes;
    }
    void create() {
        if (!isEaten) {
            fill(255, transpar);
            text(number, xPos-250, yPos-25);
            if (!isBlackHole)
                text("lifeforms depend on this star", xPos-250, yPos-10);
            else {
                text("lifeforms will be destroyed", xPos- 250, yPos-10);
                text("by this black hole", xPos-250, yPos+5);
            }
            if (doesNeedNotes) {
                text("Notes:", xPos-250, yPos+height/2-20);    
                textAlign(LEFT);
                text(theNotes, xPos-225, yPos+height/2-20);
                textAlign(CENTER);
            }
            text("Consume", xPos+ 250, yPos-50);
            text("Exit", xPos+ 250, yPos+50);
            fill(c);
            noStroke();
            if (zoom) {
                if (isZoomed) {
                    if (!isBlackHole) {
                        fill(c, random(20, 30));
                        ellipse(xPos, yPos, xSize+45, ySize+45);
                        fill(c, random(60, 70));
                        ellipse(xPos, yPos, xSize+25, ySize+25);
                        fill(c, random(90, 100));
                        ellipse(xPos, yPos, xSize+10, ySize+10);
                    }
                    fill(c);
                    ellipse(xPos, yPos, xSize, ySize);

                    zoomXPos = cos(radians(theta))*150;
                    zoomYPos = sin(radians(theta))*150;
                    fill(255, 0, 0);
                    pushMatrix();

                    translate(-Camera0.position.x+width/2, -Camera0.position.y+height/2);
                    //scale(scaler);
                    rotate(radians(theta));
                    playerAnimation();
                    //image(head_image[0], 150, 0, 100, 100); // if you want to scale it by .25, multiply the xPos.
                    //if(scaler >= .25) 
                    //    scaler -= .05;
                    popMatrix();
                    theta += .5;
                    if (transpar < 255) {
                        transpar+= 7.5;
                    }
                    if (xSize < 200) {
                        xSize += 4;
                        ySize += 4;
                    } else {
                        full = true;
                    }
                    if (mouseX >  width/2 + 200 && mouseX <  width/2 + 290 && mouseY > height/2-50-10 && mouseY < height/2-50+10 && full && !dead) {
                        noFill();
                        stroke(255);
                        rect(xPos+250, yPos-55, 70, 30);
                        if (mouseIsPressed) {
                            zoom = false;
                            isZoomed = false;
                            transpar = 0;
                            stopper = true;
                            full = false;
                            isEaten = true;
                            scaler = 1;
                            if (!isBlackHole) {
                                eaten-= .01;
                            } else {
                                eaten+= .02;
                            }
                        }
                    }
                    if (mouseX >  width/2 + 200 && mouseX <  width/2 + 290 && mouseY > height/2+50-10 && mouseY < height/2+50+10 && full && !dead) {
                        noFill();
                        stroke(255);
                        rect(xPos+250, yPos+45, 40, 30);
                        if (mouseIsPressed) {
                            zoom = false;
                            isZoomed = false;
                            transpar = 0;
                            xSize = 50;
                            ySize = 50;
                            stopper = true;
                            full = false;
                            scaler = 1;
                        }
                    }
                }
            } else {

                if (!isBlackHole) {
                    fill(c, random(20, 30));
                    ellipse(xPos, yPos, xSize+45/4, ySize+45/4);
                    fill(c, random(60, 70));
                    ellipse(xPos, yPos, xSize+25/4, ySize+25/4);
                    fill(c, random(90, 100));
                    ellipse(xPos, yPos, xSize+2.5, ySize+2.5);
                }
                fill(c);
                ellipse(xPos, yPos, xSize, ySize);
            }
            if (mouseX > transX+xPos-30 && mouseX < transX+ xPos+30 && mouseY < transY+ yPos+ 30 && mouseY > transY+yPos -30) {
                mouseOver = true;
                if (!zoom) {
                    noFill();
                    stroke(255);
                    ellipse(xPos, yPos, 90, 90);
                } else {
                    isZoomed = true;
                    Camera0.position.x = -xPos + width/2;
                    Camera0.position.y = -yPos + height/2;
                }
            } else {
                mouseOver = false;
            }
            if (mouseOver && mouseIsPressed) {
                zoom = true;
            }
            if (zoom) { // gets applied to both, but regardless of mouse position
                Camera0.velocity.x = 0;
                Camera0.velocity.y = 0;
            }
        }
    }
}
void bgStars() {
    if (!zoom) {
        for (int i = -1000; i <= 1000; i+= 100) {
            for (int j = -1000; j <= 1000; j+= 100) {
                ellipse(i, j, 2, 2);
            }
        }
    }
}