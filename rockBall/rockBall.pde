interface Displayable {
  void display();
}

interface Moveable {
  void move();
}

interface Collideable {
  boolean isTouching(Thing other);
}

abstract class Thing implements Displayable {
  float x, y;

  Thing(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

class Rock extends Thing{
  PImage rockimg;
  Rock(float x, float y) {
    super(x, y);
    int num = (int)random(2);
    if (num == 0) {
      rockimg = loadImage("rock.png");
    }
    else {
      rockimg = loadImage("Rock-PNG.png");
    }
  }

  void display() { 
    rockimg.resize(50, 50);
    image(rockimg, x, y);
  }
}

public class LivingRock extends Rock implements Moveable {
  float t = 1.0001;// t is pseudo time
  LivingRock(float x, float y) {
    super(x, y);
  }
  void move() {
    if (y < 780) {
      if ((y + 9.8 * t * t) > 780) y = 780;
      else y += 9.8 * t * t;
      t += 0.0001;
    } 
    else if (y > 780) y = 780;
    else x += random(-2, 2);
  }
}

class Ball extends Thing implements Moveable {
  float[] colors = new float[3];

  void setColors() {
    for (int i = 0; i < colors.length; i++) {
      colors[i] = random(255);
    }
  }
  float radius = random(25) + 25;
  float xspeed=15-radius/5;
  float yspeed=15-radius/5;
  Ball(float x, float y) {

    super(x, y);
    setColors();
  }

  void display() {
    /* ONE PERSON WRITE THIS */
    fill(colors[0], colors[1], colors[2]);
    ellipse(x, y, radius, radius);
  }

  void move() {
    x+=xspeed;
    y+=yspeed;
    if (x>=1000-radius||x<=radius) {
      xspeed=-xspeed;
    }
    if (y>=800-radius||y<=radius ) {
      yspeed=-yspeed;
    }
  }
}
ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;
ArrayList<Collideable> listOfCollideables;

void setup() {
  size(1000, 800);
  //PImage rockimg = loadImage("rock.png");

  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  for (int i = 0; i < 10; i++) {
    Ball b = new Ball(50+random(width-100), 50+random(height)-100);
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    Rock r = new Rock(50+random(width-100), 50+random(height)-100);
    thingsToDisplay.add(r);
  }

  LivingRock m = new LivingRock(50+random(width-100), 50+random(height)-100);
  thingsToDisplay.add(m);
  thingsToMove.add(m);
}

void draw() {
  background(255);

  for (Displayable thing : thingsToDisplay) {
    thing.display();
  }
  for (Moveable thing : thingsToMove) {
    thing.move();
  }
}