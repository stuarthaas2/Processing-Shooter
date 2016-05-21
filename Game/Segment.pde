class Segment extends GameObject
{
  //constructor
 Segment(Vector2D position, int w, int h, int c, String i, ID id)
 {
  super(position, w, h, c, i, id); 
  reward = 2;
  hitPoints = 10;
  coin = 1;
 }
 
 void update(){}
 
 void draw()
 {
  drawRect(0, 0); 
 }
}