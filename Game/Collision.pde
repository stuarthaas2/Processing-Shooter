static class Collision 
{
  static String collisionSide = "No collision";
  static boolean colliding = false;
  
  //a is the primary object, b is the secondary object
  //b is the object that a will be checking for a collision with
  static boolean calcAABB(GameObject a, GameObject b)
  {
    //create vectors for the position of the objects
    PVector rv1 = new PVector(a.position.x, a.position.y);
    PVector rv2 = new PVector(b.position.x, b.position.y);
    //get distance vector between the objects
    PVector v0 = rv2.sub(rv1);

    //check if there is a collision between the objects
    if (Math.abs(v0.x) < a.w * 0.5 + b.w * 0.5)
    {
      if (Math.abs(v0.y) < a.h * 0.5 + b.h * 0.5)
      {
        //get overlap of the objects
        float overlapX = a.w * 0.5 + b.w * 0.5
            - Math.abs(v0.x);

        float overlapY = a.h * 0.5 + b.h * 0.5
            - Math.abs(v0.y);

        //check the side the collision occurs on and offupdate the object with the overlap distance
        if (overlapX >= overlapY)
        {
          if (v0.y > 0)
          {
            collisionSide = "Top";
            a.position.update(a.position.x, a.position.y - overlapY);
            colliding = true;
          }
          else
          {
            collisionSide = "Bottom";
            a.position.update(a.position.x, a.position.y + overlapY);
            colliding = true;
          }
        }
        else
        {
          if (v0.x > 0)
          {
            collisionSide = "Left";
            a.position.update(a.position.x - overlapX, a.position.y);
            colliding = true;
          }
          else
          {
            collisionSide = "Right";
            a.position.update(a.position.x + overlapX, a.position.y);
            colliding = true;
          }
        }
      }
      else
      {
        collisionSide = "No collision";
        colliding = false;
      }
    }
    else
    {
      collisionSide = "No collision";
      colliding = false;
    }
    return colliding;
  }
  
    //a is the primary object, b is the secondary object
  //b is the object that a will be checking for a collision with
  static boolean calcAABB2(GameObject a, GameObject b)
  {
    
    //create vectors for the position of the objects
    PVector rv1 = new PVector(a.position.x, a.position.y);
    PVector rv2 = new PVector(b.position.x, b.position.y);
    //get distance vector between the objects
    PVector v0 = rv2.sub(rv1);

    //check if there is a collision between the objects
    if (Math.abs(v0.x) < a.w * 0.5 + b.w * 0.5)
    {

      if (Math.abs(v0.y) < a.h * 0.5 + b.h * 0.5)
      {

        //get overlap of the objects
        float overlapX = a.w * 0.5 + b.w * 0.5
            - Math.abs(v0.x);

        float overlapY = a.h * 0.5 + b.h * 0.5
            - Math.abs(v0.y);

        //check the side the collision occurs on and offupdate the object with the overlap distance
        if (overlapX >= overlapY)
        {
          if (v0.y > 0)
          {
            collisionSide = "Top";
            colliding = true;
          }
          else
          {
            collisionSide = "Bottom";
            colliding = true;
          }
        }
        else
        {
          if (v0.x > 0)
          {
            collisionSide = "Left";
            colliding = true;
          }
          else
          {
            collisionSide = "Right";
            colliding = true;
          }
        }
      }
      else
      {
        collisionSide = "No collision";
        colliding = false;
      }
    }
    else
    {
      collisionSide = "No collision";
      colliding = false;
    }
    return colliding;
  }
}