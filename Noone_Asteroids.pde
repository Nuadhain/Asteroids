//Create objects and object arrays
Player play;
ArrayList<Bullet> bull;
ArrayList<Asteroid> ast;
ArrayList<SmallAsteroid> sAst;

//Image for player lives
PImage life;

void setup()
{
  //create size
  size(800, 600);
  
  //Create the objects and object arrays
  play = new Player();
  bull = new ArrayList<Bullet>(0);
  ast = new ArrayList<Asteroid>(0);
  sAst = new ArrayList<SmallAsteroid>(0);
  
  //Add the asteroids
  ast.add(new Asteroid(random(100)));
  ast.add(new Asteroid(random(100)));
  ast.add(new Asteroid(random(100)));
  ast.add(new Asteroid(random(100)));
  ast.add(new Asteroid(random(100)));
  ast.add(new Asteroid(random(100)));
  ast.add(new Asteroid(random(100)));
  
  //Load image
  life = loadImage("Ship.png");
}

void draw()
{
  //Draw the background and the player
  background(0, 0, 61);
  play.Move();
  
  //Fire the weapon if space is pressed
  if(keyPressed == true && key == ' ')
  {
    //Add a bullet object to the arraylist if there is space
    if(bull.size() < 1)
    {
      bull.add(new Bullet(play.DirAngle(), play.Pos()));
    }
  }
  
  //Loop for Asteroids
  for(int c = 0; c < ast.size(); c++)
  {
    //Check if there are still asteroids in the array
    if(c < 0)
    {
      break;
    }
    
    //Move it
    ast.get(c).Move();
    
    //Delete the asteroid if it collides with the player
    if(ast.get(c).Collide(play.Pos(), 25) == true)
    {
      sAst.add(new SmallAsteroid(ast.get(c).Pos(), random(100)));
      sAst.add(new SmallAsteroid(ast.get(c).Pos(), random(100)));
      sAst.add(new SmallAsteroid(ast.get(c).Pos(), random(100)));
      play.Collide();
      ast.remove(c);
      c--;
    }
    
    //Check if there are still asteroids in the array
    if(c < 0)
    {
      break;
    }

    //Delete the asteroid if it collides with a bullet
    for(int c2 = 0; c2 < bull.size(); c2++)
    {
      if(ast.get(c).Collide(bull.get(c2).Pos(), 5) == true)
      {
        sAst.add(new SmallAsteroid(ast.get(c).Pos(), random(100)));
        sAst.add(new SmallAsteroid(ast.get(c).Pos(), random(100)));
        sAst.add(new SmallAsteroid(ast.get(c).Pos(), random(100)));
        ast.remove(c);
        c--;
      }
    }
  }
  
  //Loop for Small Asteroids
  for(int c = 0; c < sAst.size(); c++)
  {
    //Check if there are still asteroids in the array
    if(c < 0)
    {
      break;
    }
    
    //Move it
    sAst.get(c).Move();
    
    //Delete the asteroid if it collides with the player
    if(sAst.get(c).Collide(play.Pos(), 25) == true)
    {
      play.Collide();
      sAst.remove(c);
      c--;
    }
    
    //Check if there are still asteroids in the array
    if(c < 0)
    {
      break;
    }

    //Delete the asteroid if it collides with a bullet
    for(int c2 = 0; c2 < bull.size(); c2++)
    {
      if(sAst.get(c).Collide(bull.get(c2).Pos(), 5) == true)
      {
        sAst.remove(c);
        c--;
      }
    }
  }
  
  //Go through the arraylist of bullets and draw the bullets
  for(int c = 0; c < bull.size(); c++)
  {
    //Check if the bullet can still move
    if(bull.get(c).Move(45) == false)
    {
      bull.remove(c);
      c--;
    }
    //Check if there are still bullets in the array before moving
    if(c < 0)
    {
      break;
    }
    //Move
    bull.get(c).Move(45);
    
    //Delete the bullet if it collides with an asteroid
    if(bull.get(c).Collide(ast) == true)
    {
      bull.remove(c);
      c--;
    }
  }
  
  //Display the player's lives
  if(play.Lives() == 3)
  {
    image(life, 10, 10);
    image(life, 70, 10);
    image(life, 130, 10);
  }
  if(play.Lives() == 2)
  {
    image(life, 10, 10);
    image(life, 70, 10);
  }
  if(play.Lives() == 1)
  {
    image(life, 10, 10);
  }
  
  //If the player has no lives end the game
  if(play.Lives() < 0)
  {
    textSize(32);
    text("GAME OVER", width/2 - 100, height/2);
    stop();
  }
  
  //Check if all the asteroids have been destroyed
  if(ast.size() == 0 && sAst.size() == 0)
  {
    textSize(32);
    text("CONGRATULATIONS", width/2 - 165, height/2 - 50);
    text("YOU WIN", width/2 - 90, height/2);
    stop();
  }
}