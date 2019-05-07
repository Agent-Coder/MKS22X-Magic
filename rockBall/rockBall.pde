interface Displayable {
  void display();
}
interface Moveable {
  void move();
}
abstract class Thing implements Displayable{
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
    int num = (int)random(1);
    if (num == 0) {
      rockimg = loadImage("rock.png");
      //image(rockimg, 0,0);
        //fill(106,93,108);
        //ellipse(x,y,50,40);
      }
      else {
      rockimg = loadImage("rock_PNG.png");
        //image(rockimg, 0,0);
        
      }
  }

  void display() { 
      /* ONE PERSON WRITE THIS */
      rockimg.resize(50,50);
      image(rockimg, x,y);
  }
}

public class LivingRock extends Rock implements Moveable {
  float t = 1.0001;// t is pseudo time
  LivingRock(float x, float y) {
    super(x,y);
  }
  void move() {
    if (y < 780){
      if ((y + 9.8 * t * t) > 780) y = 780;
      else y += 9.8 * t * t;
      t += 0.0001;
    }
    else x += random(-2,2);
  }
}

class Ball extends Thing implements Moveable {
  float radius = random(25) + 25;
  float xspeed=15-radius/5;
  float yspeed=15-radius/5;
  Ball(float x, float y) {

    super(x, y);
  }

  void display() {
    /* ONE PERSON WRITE THIS */
    fill(255,0,0);
    ellipse(x,y,radius,radius);
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

void setup() {
  size(1000, 800);
  //PImage rockimg = loadImage("rock.png");

  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  for (int i = 0; i < 10; i++) {
    Ball b = new Ball(50+random(width-100),50+random(height)-100);
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    Rock r = new Rock(50+random(width-100),50+random(height)-100);
    thingsToDisplay.add(r);
  }

  LivingRock m = new LivingRock(50+random(width-100),50+random(height)-100);
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