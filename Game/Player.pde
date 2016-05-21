class Player extends GameObject
{
 //constructor
 Player(Vector2D position, int w, int h, int c, String p, ID id)
 {
  super(position, w, h, c, p, id);
  maxForce = .9;
  maxSpeed = 6;
 }
 
 //update
 void update()
 {
   //move
   velocity.add(force);
   velocity.multiply(.9);
   position.add(velocity);
   rotation = velocity.getAngle();
   
   //keep within the canvas bounds
   clamp();
 }
 
 //draw
 void draw()
 {
   drawRect(0, 0);
 }
 
 //fire bullet
 void fireBullet(int mx, int my)
 {
   Bullet bullet = new Bullet(position.clone(), 6, 6, #ffffff, null, ID.BULLET);
   bullet.velocity.setHeading(position.clone().subtract(new Vector2D(mx, my)).getAngle(), -bullet.maxSpeed);
   bullets.add(bullet);
 }
}