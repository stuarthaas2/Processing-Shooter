class Seeker extends MovingObject
{
 //constructor
 Seeker(Vector2D position, int w, int h, int c, String p, ID id)
 {
  super(position, w, h, c, p, id);
  hitPoints = 40;
  reward = 40;
  coin = 5;
  maxForce = .05;
  maxSpeed = 3;
 }
 
 //update
 void update()
 {
    //seek the player
    seek(player.position);
    
    //set rotation
    rotation = velocity.getAngle();
    
    //update super class
    super.update();
    
    //keep within the canvas bounds
    clamp();
 }
 
 //draw
 void draw()
 {
   drawRect(0, 0);
 }
}