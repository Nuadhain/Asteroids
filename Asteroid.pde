class Asteroid
{
  //Velocity, acceleration, position, and direction vectors
  PVector dir;
  PVector acc;
  PVector vel;
  PVector pos;
  
  //Image
  PImage ast;
  
  //Other variables
  float radius;
  
  //Constructor
  Asteroid(float which)
  {
    //Instantiate vectors
    dir = PVector.fromAngle(radians(random(361)));
    acc = new PVector(0, 0);
    vel = new PVector(0, 0);
    pos = new PVector(random(width - 75), random(height - 75));
    
    //Instantiate variables
    radius = 37.5;
    
    //Determine which image to use
    if(which < 33)
    ast = loadImage("Asteroid1.png");
    else if(which > 33 && which < 66)
    ast = loadImage("Asteroid2.png");
    else
    ast = loadImage("Asteroid3.png");
  }
  
  //Movement
  void Move()
  {
    //Calculate acceleration based on direction
    dir.normalize();
    dir.mult(0.5);
    acc = dir;
    
    //Calculate velocity
    vel.add(acc);
    vel.limit(3);
    
    //Add velocity to posisition
    pos.add(vel);
    
    //Wrapping
    if(pos.x > width + 75)
    {
      pos.x = -75;
    }
    if(pos.x < -75)
    {
      pos.x = width + 75;
    }
    if(pos.y > height + 75)
    {
      pos.y = -75;
    }
    if(pos.y < -75)
    {
      pos.y = height + 75;
    }
    
    //Draw it
    pushMatrix();
    translate(pos.x - 37.5, pos.y - 37.5);
    image(ast, 0, 0);
    popMatrix();
  }
  
  //Return Position
  PVector Pos()
  {
    return pos;
  }
  
  //Return Radius
  float Radius()
  {
    return radius;
  }

  //Collisions
  boolean Collide(PVector p, float radi)
  {
    //Get the distance between the input position and asteroid position
    float dist = sqrt(sq(p.x - pos.x) + sq(p.y - pos.y));
    
    //Check for collision
    if(radi + radius > dist)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
}