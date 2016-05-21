import ddf.minim.*; //<>//
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import java.util.*;
import java.awt.Rectangle;

//game states
enum STATE
{
  START, RUNNING, RESET, END;
}

//model variables
STATE gameState;
boolean[] keyDown = new boolean[4];
int score = 0;
int lives = 3;
int fireCounter = 0;
int fireRate = 6;

//object variables
Player player;
Spawner spawner;
List<GameObject> enemies;
List<GameObject> bullets;
List<GameObject> coins;

//visuals and sounds
PFont f;

//setup
void setup()
{
  //set canvas size
  size(1024, 768);

  //set pressed keys to false
  keyDown[0] = false;
  keyDown[1] = false;
  keyDown[2] = false;
  keyDown[3] = false;

  //create player
  player = new Player(new Vector2D((width / 2) - 8, (height / 2) - 8), 16, 16, #ffffff, null, ID.PLAYER);

  //create object arrays
  enemies = new ArrayList<GameObject>();
  bullets = new ArrayList<GameObject>();
  coins = new ArrayList<GameObject>();

  //create spawner
  spawner = new Spawner();

  //create font
  f = createFont("Arial", 16, true);

  //set game state
  gameState = STATE.START;
}

//draw
void draw()
{
  //draw background
  background(0);

  //check if the game has started
  if (gameState == STATE.START)
  {
    startGame();
  }
  //check if the game is running
  if (gameState == STATE.RUNNING)
  {
    runGame();
  }
  //check if the game has reset
  if (gameState == STATE.RESET)
  {
    resetGame();
  }
  //check if the game has ended
  if (gameState == STATE.END)
  {
    endGame();
  }
}

//start game
void startGame()
{
  //draw start game text
  String t1 = "MOVE WITH AWSD AND AIM WITH THE MOUSE";
  textFont(f, 16);
  fill(#FFFFFF);
  text(t1, (width / 2) - (textWidth(t1) / 2), (height / 2) - textAscent());

  //draw start game text]
  String t2 = "PRESS ENTER TO PLAY";
  textFont(f, 16);
  fill(#FFFFFF);
  text(t2, (width / 2) - (textWidth(t2) / 2), (height / 2) + 16);
}

//run game
void runGame()
{
  //update spawner
  spawner.update();

  //update and draw player
  player.update();
  player.draw();
  //fire bullets
  if (fireCounter % fireRate == 0)
  {
    player.fireBullet(mouseX, mouseY);
    if (fireCounter == fireRate)
    {
      fireCounter = 0;
    }
  }
  fireCounter ++;

  //update and draw enemies
  Iterator<GameObject> a = enemies.iterator();
  while (a.hasNext())
  {
    GameObject enemy = a.next();
    enemy.update();
    enemy.draw();
  }

  //update and draw bullets
  Iterator<GameObject> b = bullets.iterator();
  while (b.hasNext())
  {
    GameObject bullet = b.next();
    bullet.update();
    bullet.draw();
  }

  //update and draw coins
  Iterator<GameObject> c = coins.iterator();
  while (c.hasNext())
  {
    GameObject coin = c.next();
    coin.update();
    coin.draw();
  }

  Iterator<GameObject> h = enemies.iterator();
  while (h.hasNext())
  {
    GameObject enemy = h.next();
    //check for collisions between player and enemies
    if (Collision.calcAABB2(player, enemy))
    {
      removeLife();
    }
    //decrease enemy count when enemy is destroyed
    if (enemy.expired)
    {
      if (enemy.id == ID.DRONE)
      {
        spawner.droneCount --;
      }
      if (enemy.id == ID.SEEKER)
      {
        spawner.seekerCount --;
      }
      if (enemy.id == ID.SMART_SEEKER)
      {
        spawner.smartSeekerCount --;
      }
      if (enemy.id == ID.SNAKE)
      {
        spawner.snakeCount --;
      }
      if (enemy.id == ID.ROCKET)
      {
        spawner.rocketCount --;
      }
      //increase score and create coins
      score += enemy.reward;
      for (int x = 0; x < enemy.coin; x ++)
      {
        coins.add(new Coin(enemy.position.clone(), 6, 6, #ffeb34, null, ID.COIN));
      }
      h.remove();
      break;
    }
    //check collision between player and snake segments
    for (Segment seg : enemy.segments)
    {
      if (Collision.calcAABB2(player, seg))
      {
        removeLife();
      }
    }
  }

  Iterator<GameObject> i = bullets.iterator();
  while (i.hasNext()) {
    GameObject bullet = i.next();
    if (bullet.outOfBounds())
    {
      i.remove();
      break;
    }  
    for (GameObject enemy : enemies)
    {
      //check collision between bullet and enemy
      if (Collision.calcAABB2(bullet, enemy))
      {
        if (enemy.id != ID.SNAKE)
        {
          enemy.hitPoints -= bullet.damage;
          if (enemy.hitPoints <= 0)
          {
            enemy.expired = true;
          }
          i.remove();
          break;
        }
      }
      //check collision between bullet and snake segments
      Iterator<Segment> k = enemy.segments.iterator();
      while (k.hasNext())
      {
        Segment seg = k.next();
        if (Collision.calcAABB2(bullet, seg))
        {
          seg.hitPoints -= bullet.damage;
          if (seg.hitPoints <= 0)
          {
            score += seg.reward;
            for (int x = 0; x < seg.coin; x ++)
            {
              coins.add(new Coin(seg.position.clone(), 6, 6, #ffeb34, null, ID.COIN));
            }
            k.remove();
          }
          if (enemy.segments.size() == 2)
          {
            enemy.expired = true;
          }
          i.remove();
          break;
        }
      }
    }
  }

  //check for collisions between player and coins
  Iterator<GameObject> j = coins.iterator();
  while (j.hasNext())
  {
    GameObject coin = j.next();
    if (coin.outOfBounds())
    {
      j.remove();
      break;
    }
    if (coin.expired)
    {
      j.remove();
      break;
    }
    if (Collision.calcAABB2(player, coin))
    {
      score += coin.reward;
      j.remove();
      break;
    }
  }

  //draw lives text
  textFont(f, 16);
  fill(#FFFFFF);
  text("Lives: " + lives, 16, 24);

  //draw score text
  textFont(f, 16);
  fill(#FFFFFF);
  text("Score: " + score, 16, 48);
}

//remove life
void removeLife()
{
  lives --;
  if (lives == 0)
  {
    gameState = STATE.END;
  } else
  {
    gameState = STATE.RESET;
  }
}

//reset game
void resetGame()
{
  player.position = new Vector2D((width / 2) - 8, (height / 2) - 8);
  bullets.clear();
  enemies.clear();
  coins.clear();
  spawner.reset();
  gameState = STATE.RUNNING;
}

//end game
void endGame()
{
  //draw game over text
  String t = "GAME OVER! PRESS ENTER TO PLAY AGAIN!";
  textFont(f, 16);
  fill(#FFFFFF);
  text(t, (width / 2) - (textWidth(t) / 2), (height / 2));
  score = 0;
  lives = 3;
}

//detect key press
void keyPressed()
{
  handleKeyPress(keyCode);
}

//detect key release
void keyReleased()
{
  handleKeyRelease(keyCode);
}

//handle key press
void handleKeyPress(int code)
{
  switch(code)
  {
  case 68: //right
    keyDown[0] = true;
    player.force.x = player.maxForce;
    break;

  case 65: //left
    keyDown[1] = true;
    player.force.x = -player.maxForce;
    break;

  case 83: //down
    keyDown[2] = true;
    player.force.y = player.maxForce;
    break;

  case 87: //up
    keyDown[3] = true;
    player.force.y = -player.maxForce;
    break;

  case 10: //enter
    if (gameState == STATE.START)
    {
      gameState = STATE.RUNNING;
    }
    if (gameState == STATE.END)
    {
      resetGame();
    }
    break;
  }
}

//handle key release
void handleKeyRelease(int code)
{
  if (code == 68) keyDown[0] = false; //right
  if (code == 65) keyDown[1] = false; //left
  if (code == 83) keyDown[2] = false; //down
  if (code == 87) keyDown[3] = false; //up

  if (!keyDown[0] && !keyDown[1])
    player.force.x = 0;
  if (!keyDown[2] && !keyDown[3])
    player.force.y = 0;
}