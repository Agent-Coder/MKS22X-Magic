interface Displayable {
  void display();
}

interface Moveable {
  void move();
}

interface Collideable {
  boolean isTouching(Thing other);
  String identify();
}

abstract class Thing implements Displayable {
  float x, y;
  float[] colors = new float[3];
  float r;
  float b;
  float g;

  int radius=25;
  Thing(float x, float y) {
    this.x = x;
    this.y = y;
  }
  String identify() {
    return "Thing";
  }
}

class Rock extends Thing implements Collideable {
  PImage rockimg;
  int radius=25;
  Rock(float x, float y) {
    super(x, y);
    int num = (int)random(2);
    if (num == 0) {
      rockimg = loadImage("rock.png");
    } else {
      rockimg = loadImage("Rock-PNG.png");
    }
  }

  void display() { 
    rockimg.resize(50, 50);
    image(rockimg, x, y);
  }
  String identify() {
    return "Rock";
  }
  boolean isTouching(Thing other) {
    float distx=this.x-other.x;
    float disty=this.y-other.y;
    float dist=sqrt(pow(distx, 2)+pow(disty, 2));
    if (dist<this.radius+other.radius) {  
      return true;
    }
    return false;
  }
}

public class LivingRock extends Rock implements Moveable, Collideable {
  int t = 1; //sudo time
  int mode;
  float xdir, ydir;
  LivingRock(float x, float y) {
    super(x, y);
    mode = (int)random(3);
    if (mode == 0) {
      xdir = random(-5, 5);
      ydir = 9.8;
    }
    if (mode == 1 || mode == 2) {
      xdir = random(-5, 5);
      ydir = random(-5, 5);
    }
  }

  void move() {
    if (mode == 0) { //drop and slide
      if (y < 760) {
        if (ydir < 9.8) ydir = 9.8;
        y += ydir;
        ydir *= 1.0001;
      } else if (y > 760) y = 760;
      else {
        if (x + xdir <= 0 || x + xdir >= 950) xdir = -xdir;
        x += xdir;
      }
    }
    if (mode == 1) { // bounce around the walls
      while (x + xdir >= 950 || x  + xdir <= 0) {
        xdir = random(-5, 5);
      }
      while (y + ydir >= 760 || y  + ydir <= 0) {
        ydir = random(-5, 5);
      }
      x += xdir;
      y += ydir;
    }
    if (mode == 2) { // slide and decay speed
      if (abs(xdir) < 0.05) xdir = random(-5, 5);
      if (abs(ydir) < 0.05) ydir = random(-5, 5);
      x += xdir;
      if (x < 0) x = 0;
      else if (x > 760) x = 760;
      y += ydir;
      if (y < 0) y = 0;
      else if (y > 760) y = 760;
      xdir *= 0.97;
      ydir *= 0.97;
    }
    if (t >= 200) {
      mode = (int)random(3);
      t = -1;
    }
    t++;
  }
  String identify() {
    return "LivingRock";
  }

 boolean isTouching(Thing other) {
    float distx=this.x-other.x;
    float disty=this.y-other.y;
    float dist=sqrt(pow(distx, 2)+pow(disty, 2));
    if (dist<this.radius+other.radius) {  
      return true;
    }
    return false;
  }
  void display() {
    super.display();
    fill(255);
    ellipse(x + 10, y + 10, 20, 20);
    ellipse(x + 40, y + 10, 20, 20);
    fill(0);
    ellipse(x + 10, y + 10, 10, 10);
    ellipse(x + 40, y + 10, 10, 10);
  }
}

class Ball extends Thing implements Moveable, Collideable {
  void setColors() {
    for (int i = 0; i < colors.length; i++) {
      colors[i] = random(255);
      if (i==0) {
        r=colors[0];
      }
      if (i==1) {
        b=colors[1];
      }
      if (i==0) {
        g=colors[2];
      }
    }
  }
  String identify() {
    return "Ball";
  }
  void setColors(float red, float blue, float green) {
    colors[0] = red;
    colors[1] = blue;
    colors[2] = green;
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
  boolean isTouching(Thing other) {
    float distx=this.x-other.x;
    float disty=this.y-other.y;
    float dist=sqrt(pow(distx, 2)+pow(disty, 2));
    if (dist<this.radius+other.radius) {  
      return true;
    }
    return false;
  }
  void move() {
    x=random(width);
    y=random(height);
  }
}
class CurvedBall extends Ball {
  boolean first=true;
  int angle=0;
  float time;
  boolean up=false;
  CurvedBall(float x, float y) {
    super(x, y);
    if (random(2)==0) {
      xspeed=(millis()/(((random (radius)+5)*500.0)))%15;
      yspeed=-1*millis()%10+100*sin(radians(angle));
    } else {
      xspeed=(-1*millis()/(((random (radius)+5)*500.0)))%15;
      yspeed=(millis()%10+100*sin(radians(angle)));
    }
  }
  String identify() {
    return "CurvedBall";
  }
  void move() {
    if (up) {
      yspeed=-1*millis()%10+100*sin(radians(angle));
    } else {
      yspeed=(millis()%10+100*sin(radians(angle)));
    }
    angle+=random(10);
    x+=xspeed;
    y+=yspeed/10;
    System.out.println(xspeed);
    if (x>=width-radius||x<=radius) {
      if (x>=1000-radius) {
        xspeed=(-1*millis()/(((random (radius)+5)*500.0)))%15;
      } else if (x<=radius) {
        xspeed=(millis()/(((random (radius)+5)*500.0)))%15;
      }
    }
    if (y<0) {
      yspeed=abs(millis()%10+100*sin(radians(angle)));
      y+=yspeed;
      up=false;
    }
    if (y>height) {
      yspeed=-1*abs(millis()%10+100*sin(radians(angle)));
      y+=yspeed;
      up=true;
    }
    for ( Collideable c : listOfCollideables) {
      r=colors[0];
      b=colors[1];
      g=colors[2];
      if (isTouching((Thing)c)&&c!=this&&c.identify().equals("Rock")) {
        colors[0]=255;
        colors[1]=40;
        colors[2]=40;
      } else {
        colors[0]=r;
        colors[1]=b;
        colors[2]=g;
        setColors(r, b, g);
        fill(colors[0], colors[1], colors[2]);
      }
    }
  }
}
class StraightBall extends Ball {
  StraightBall(float x, float y) {

    super(x, y);
    setColors();
  }

  String identify() {
    return "StraightBall";
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
  listOfCollideables = new ArrayList<Collideable>();
  for (int i = 0; i < 10; i++) {
    CurvedBall b = new CurvedBall(50+random(width-100), 50+random(height)-100);
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    Rock r = new Rock(50+random(width-100), 50+random(height)-100);
    thingsToDisplay.add(r);
    listOfCollideables.add(b);
    listOfCollideables.add(r);
  }

  LivingRock m = new LivingRock(50+random(width-100), 50+random(height)-100);
  thingsToDisplay.add(m);
  thingsToMove.add(m);
  //listOfCollideables.add(m);
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
