abstract class MovingObject extends GameObject
{
  //constructor
  MovingObject(Vector2D position, int w, int h, int c, String p, ID id)
  {
    super(position, w, h, c, p, id);
  }
  
  //update
  void update()
  {
    force.limit(maxForce);
    force.divide(mass);
    velocity.add(force);
    force = new Vector2D();
    velocity.limit(maxSpeed);
    position.add(velocity);
  }

  //seek
  void seek(Vector2D target)
  {
    //seek the player
    diff = target.clone().subtract(position);
    diff.normalize();
    diff.multiply(maxSpeed);
    diff.subtract(velocity);
    force.add(diff);
  }
  
  //flee
  void flee(Vector2D target)
  {
    diff = position.clone().subtract(target);
    diff.normalize();
    diff.multiply(maxSpeed);
    diff.subtract(velocity);
    force.add(diff);
  }
  
  //evade
  void evade(Vector2D targetPosition, Vector2D targetVelocity)
  {
   float lookAheadTime = position.dist(targetPosition) / maxSpeed;
   Vector2D predictedTarget = targetPosition.clone().add(targetVelocity.clone().multiply(lookAheadTime));
   flee(predictedTarget);
  }
  
  //wander
  void wander()
  {
    Vector2D center = velocity.clone().normalize().multiply(wanderDistance);
    Vector2D offset = new Vector2D();
    offset.setHeading(wanderAngle, wanderRadius);
    wanderAngle += Math.random() * wanderRange - wanderRange * .5;
    center.add(offset);
    center.multiply(.1);
    force = center;
  }
}