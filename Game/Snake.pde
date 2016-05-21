class Snake extends MovingObject
{
  //variables
  int minLength = 10;
  int maxLength = 20;

  //constructor
  Snake(Vector2D position, int w, int h, int c, String p, ID id)
  {
    super(position, w, h, c, p, id);
    reward = 80;
    coin = 10;
    maxForce = .1;
    maxSpeed = 3;

    //add the minium amount of segments to the player
    for (int i = 0; i < minLength + 1; i ++) {
      segments.add(new Segment(new Vector2D(position.x + ((w / 2) * i), position.y), w / 2, h / 2, c, p, ID.SNAKE));
    }
  }

  //update
  void update()
  { 
    //wander
    wander();

    //update super class
    super.update();

    //set rotation
    rotation = velocity.getAngle();

    //set position of first segment
    segments.get(0).position.update(position);

    //keep within canvas bounds
    clamp();
  }

  //draw
  void draw()
  {
    //draw head
    drawEllipse(0, 0);

    //draw segments
    for (int i = segments.size() - 1; i > 0; i --)
    {
      //offset each segment behind the previous segment
      Segment p1 = segments.get(i - 1);
      Segment p2 = segments.get(i);
      Vector2D diff = p1.position.clone().subtract(p2.position);
      p2.position.update(p1.position.clone().subtract(diff.clone().setHeading(diff.getAngle(), (w / 2) - 4)));
      p2.rotation = diff.getAngle();
      p2.draw();
    }
  }
}