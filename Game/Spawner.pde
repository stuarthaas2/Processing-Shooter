class Spawner 
{
  //variables
  Random r = new Random();
  int droneSpawnChance = 100;
  int seekerSpawnChance = 200;
  int smartSeekerSpawnChance = 300;
  int snakeSpawnChance = 400;
  int rocketSpawnChance = 400;
  int droneCount = 0;
  int seekerCount = 0;
  int smartSeekerCount = 0;
  int snakeCount = 0;
  int rocketCount = 0;
  int droneMax = 15;
  int seekerMax = 10;
  int smartSeekerMax = 5;
  int snakeMax = 5;
  int rocketMax = 5;

  //constructor
  Spawner() {
  }

  //reset
  void reset()
  {
    seekerCount = 0;
    smartSeekerCount = 0;
    droneCount = 0;
    snakeCount = 0;
    rocketCount = 0;
  }

  //update
  void update()
  {
    //spawn drone
    if ((int)(Math.random() * droneSpawnChance) == 0 && droneCount < droneMax)
    {
      enemies.add(new Drone(getPosition(200), 16, 16, #05FC30, null, ID.DRONE));
      droneCount ++;
    }
    //spawn seeker
    if ((int)(Math.random() * seekerSpawnChance) == 0 && seekerCount < seekerMax)
    {
      enemies.add(new Seeker(getPosition(300), 16, 16, #ff0303, null, ID.SEEKER));
      seekerCount ++;
    }
    //spawn smart seeker
    if ((int)(Math.random() * smartSeekerSpawnChance) == 0 && smartSeekerCount < smartSeekerMax)
    {
      enemies.add(new SmartSeeker(getPosition(300), 16, 16, #FF9203, null, ID.SMART_SEEKER));
      smartSeekerCount ++;
    }
    //spawn snake
    if ((int)(Math.random() * snakeSpawnChance) == 0 && snakeCount < snakeMax)
    {
      enemies.add(new Snake(getPosition(200), 16, 16, #05c5fc, null, ID.SNAKE));
      snakeCount ++;
    }
    //spawn rocket
    if ((int)(Math.random() * rocketSpawnChance) == 0 && rocketCount < rocketMax)
    {
      //enemies.add(new Rocket(getPosition(200), 16, 16, #FF9203, null, ID.ROCKET));
      //rocketCount ++;
      //println("Rocket count: " + rocketCount);
    }
  }

  //get position that is a specific distance from the player
  Vector2D getPosition(int dist)
  {
    Vector2D pos;
    do
    {
      pos = new Vector2D(r.nextInt(width), r.nextInt(height));
    }
    while (pos.dist(player.position) < dist);
    return pos;
  }

  //get random random range
  float getBetweenRange(float min, float max)
  {
    return r.nextFloat() * (max - min) + min;
  }

  //get random random range
  int getBetweenRange(int min, int max)
  {
    return r.nextInt() * (max - min) + min;
  }
}