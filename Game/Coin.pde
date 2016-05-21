class Coin extends MovingObject
{
  //constructor
  Coin(Vector2D position, int w, int h, int c, String p, ID id)
  {
    super(position, w, h, c, p, id);
    reward = 2;
    life = 200;
    wanderDistance = 1;
    wanderRange = 1;
    wanderRadius = 1;
  }

  //update
  void update() {
    //seek
    force = player.position.clone().subtract(position);
    if(force.getDist() < seekThreshold)
    {
      maxForce = 1;
      maxSpeed = 3;
      seek(player.position);
    }
    //wander
    else
    {
     maxForce = .1;
     maxSpeed = .5;
     wander(); 
    }
    
    //update super class
    super.update();
    
    //keep object in canvas bounds
    clamp();
    
    //countdown lifespan
    life --;
    if(life <= 0)
    {
      expired = true;
    }
  }

  //draw
  void draw()
  {
    drawEllipse(0, 0);
  }
}