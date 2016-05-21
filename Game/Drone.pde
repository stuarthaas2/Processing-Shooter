class Drone extends MovingObject
{
 //constructor
 Drone(Vector2D position, int w, int h, int c, String p, ID id)
 {
  super(position, w, h, c, p, id);
  hitPoints = 20;
  reward = 20;
  coin = 2;
  wanderRadius = 1;
  wanderRange = 1;
  wanderDistance = 1;
  maxForce = .1;
  maxSpeed = 1;
 }
 
 //update
 void update()
 {
    //seek the player
    wander();
    
    //update super class
    super.update();
    
    //keep within the canvas bounds
    clamp();
 }
 
 //draw
 void draw()
 {
   drawEllipse(0, 0);
 }
}