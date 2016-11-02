class Player
{
  //Velocity, accelleration and direction vectors
  PVector vel;
  PVector acc;
  PVector dir;
  PVector pos;
  
  //Image
  PImage ship;
  
  //Other Variables
  int lives;
  int radius;
  int dirAngle = -90;
  
  //Constructor
  Player()
  {
    //Pass in values for velocity and accelleration
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    
    //Instantiate the direction and position
    dir = PVector.fromAngle(radians(dirAngle));
    pos = new PVector(width/2, height/2);
    
    //Load the images
    ship = loadImage("Ship.png");
    
    //Set how many lives the player has
    lives = 3;
    
    //set the radius to be used for collisions
    radius = 25;
  }
  
  //Movement
  void Move()
  {
    //Move it if the w key is pressed
    if(keyPressed == true && keyCode == UP)
    { 
      //Calculate acceleration based on direction
      dir.normalize();
      dir.mult(0.2);
      acc = dir;
      
      //Calculate velocity
      vel.add(acc);
      vel.limit(10);
      
      //Add velocity to posisition
      pos.add(vel);
      
      //Wrapping
      if(pos.x > width + 50)
      {
        pos.x = -50;
      }
      if(pos.x < -50)
      {
        pos.x = width + 50;
      }
      if(pos.y > height + 50)
      {
        pos.y = -50;
      }
      if(pos.y < -50)
      {
        pos.y = height + 50;
      }
    }
    
    //Turn it left if the a key is pressed
    if(keyPressed == true && keyCode == LEFT)
    {
      //Turn
      dirAngle -= 5;
      dir = PVector.fromAngle(radians(dirAngle));
      dir.normalize();
      dir.mult(0.2);
      acc = dir;
      
    }
    
    //Turn it left if the d key is pressed
    if(keyPressed == true && keyCode == RIGHT)
    {
      //Turn
      dirAngle += 5;
      dir = PVector.fromAngle(radians(dirAngle));
      dir.normalize();
      dir.mult(0.2);
      acc = dir;
    }
    
    //Deccelerate if no keys are pressed
    if(keyPressed == false)
    {
      //Calculate acceleration based on direction
      dir.normalize();
      dir.mult(0.2);
      acc = dir;
      
      //Calculate velocity
      vel.sub(acc);
      vel.limit(0);
      
      //Add velocity to posisition
      pos.add(vel);
      
      //Wrapping
      if(pos.x > width + 50)
      {
        pos.x = -50;
      }
      if(pos.x < -50)
      {
        pos.x = width + 50;
      }
      if(pos.y > height + 50)
      {
        pos.y = -50;
      }
      if(pos.y < -50)
      {
        pos.y = height + 50;
      }
    }
    
    //Draw the ship
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(radians(dirAngle + 90));
    translate(-25, -25);
    image(ship, 0, 0);
    popMatrix();
  }
  
  //Return the direction angle
  float DirAngle()
  {
    return dirAngle;
  }
  
  //Return the position
  PVector Pos()
  {
    return pos;
  }
  
  //Return lives
  int Lives()
  {
    return lives;
  }
  
  //Collisions
  void Collide()
  {
    lives --;
  }
}