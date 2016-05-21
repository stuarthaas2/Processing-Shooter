class Bullet extends GameObject
{
 //constructor
 Bullet(Vector2D position, int w, int h, int c, String p, ID id)
 {
  super(position, w, h, c, p, id);
  maxSpeed = 10;
  damage = 10;
 }
 
 //update
 void update()
 {
  position.add(velocity); 
 }
 
 //draw
 void draw()
 {
  drawEllipse(0, 0); 
 }
}