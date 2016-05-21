abstract class GameObject
{
  //steering variables
  Vector2D position = new Vector2D();
  Vector2D velocity = new Vector2D();
  Vector2D force = new Vector2D();
  Vector2D diff = new Vector2D();
  
  //behavior variables
  ArrayList<Vector2D> paths = new ArrayList<Vector2D>();
  int pathIndex = 0;
  float seekThreshold = 100;
  float fleeThreshold = 100;
  float wanderAngle = 0;
  float wanderDistance = 2;
  float wanderRadius = 2;
  float wanderRange = 2;
  float rotation = 0;
  float maxForce = 1;
  float maxSpeed = 5;
  int mass = 1;
  
  //object variables
  ArrayList<Segment> segments = new ArrayList<Segment>();
  boolean expired = false;
  int life, reward, penalty, hitPoints, damage, coin;
  int w, h, c;
  String p;
  ID id;
  PImage img;
  
  //constructor
  GameObject(Vector2D position, int w, int h, int c, String p, ID id)
  {
    this.position = position;
    this.w = w;
    this.h = h;
    this.c = c;
    this.p = p;
    this.id = id;
    if(p != null)
    {
      img = loadImage(p);
    }
  }

  //update
  abstract void update();

  //draw
  abstract void draw();

  //draw image
  void drawImage(int ox, int oy){
    pushMatrix();
    translate(position.x, position.y);
    rotate(rotation);
    image(img, ox + (-(w / 2)), oy + (-(h / 2)), w, h);
    popMatrix(); 
   }; 

  //draw rectangle
  void drawRect(int ox, int oy) {
    pushMatrix();
    translate(position.x, position.y);
    rotate(rotation);
    noStroke();
    fill(c);
    rect(ox + (-(w / 2)), oy + (-(h / 2)), w, h);
    popMatrix();
  }

  //draw ellipse
  void drawEllipse(int ox, int oy) {
    pushMatrix();
    translate(position.x, position.y);
    rotate(rotation);
    noStroke();
    fill(c);
    ellipse(ox, oy, w, h);
    popMatrix();
  }
  
  //check if object has gone outside the canvas bounds
  boolean outOfBounds() 
  {
    if (position.x <= 0) 
    {
      return true;
    }

    if (position.x >= width) 
    {
      return true;
    }

    if (position.y <= 0) 
    {
      return true;
    }

    if (position.y >= height) 
    {
      return true;
    }
    return false;
  }
  
  //keep the object from going outside the canvas bounds
  void clamp() 
  {
    if (position.x - w / 2 <= 0) 
    {
      position.x = w / 2;
      velocity.x = 0;
    }

    if (position.x >= width - w / 2) 
    {
      position.x = width - w / 2;
      velocity.x = 0;
    }

    if (position.y - h / 2 <= 0) 
    {
      position.y = h / 2;
      velocity.y = 0;
    }

    if (position.y >= height - h / 2) 
    {
      position.y = height - h / 2;
      velocity.y = 0;
    }
  }
}