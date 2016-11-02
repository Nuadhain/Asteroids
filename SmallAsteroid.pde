class SmallAsteroid
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
  SmallAsteroid(PVector p, float which)
  {
    //Instantiate vectors
    dir = PVector.fromAngle(radians(random(361)));
    acc = new PVector(0, 0);
    vel = new PVector(0, 0);
    pos = new PVector(p.x, p.y);
    
    //Instantiate variables
    radius = 25;
    
    //Determine which image to use
    if(which < 33)
    ast = loadImage("SmalAsteroid1.png");
    else if(which > 33 && which < 66)
    ast = loadImage("SmalAsteroid2.png");
    else
    ast = loadImage("SmalAsteroid3.png");
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
    vel.limit(2);
    
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
    
    //Draw it
    pushMatrix();
    translate(pos.x - 25, pos.y - 25);
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