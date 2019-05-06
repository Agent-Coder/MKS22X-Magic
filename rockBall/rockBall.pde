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
  Rock(float x, float y) {
    super(x, y);
  }

  void display() { 
      /* ONE PERSON WRITE THIS */
      //PImage rockimg = loadImage("rock.png");
      //image(rockimg, 0,0);
      fill(106,93,108);
      ellipse(x,y,50,40);
  }
}

public class LivingRock extends Rock implements Moveable {
  // t is pseudo time
  LivingRock(float x, float y) {
    super(x,y);
  }
  void move() {
    if (y < 800){
      if ((y + 9.8) > 800) y = 800;
      else y += 9.8;
    }
    x += random(-2,2);
  }
}

class Ball extends Thing implements Moveable {
  float radius = random(25) + 25;
  Ball(float x, float y) {

    super(x, y);
  }

  void display() {
    /* ONE PERSON WRITE THIS */
    fill(255,0,0);
    ellipse(x,y,radius,radius);
  }

  void move() {
    /* ONE PERSON WRITE THIS */
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