class SmartSeeker extends MovingObject
{
  //constructor
  SmartSeeker(Vector2D position, int w, int h, int c, String p, ID id)
  {
    super(position, w, h, c, p, id);
    hitPoints = 40;
    reward = 60;
    coin = 8;
    fleeThreshold = 300;
    seekThreshold = 200;
  }

  //update
  void update()
  {
    Iterator<GameObject> i = bullets.iterator();
    while (i.hasNext())
    {
      GameObject bullet = i.next();
      //evade bullets
      if (bullet.position.clone().dist(position) < fleeThreshold)
      {
        maxForce = 1;
        maxSpeed = 5;
        evade(bullet.position, bullet.velocity);
      } 
      //seek the player
      else
      {
        maxForce = .5;
        maxSpeed = 2;
        seek(player.position);
      }
    }

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