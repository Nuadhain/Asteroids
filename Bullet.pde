class Bullet
{
  //Vectors
  PVector vel;
  PVector acc;
  PVector dir;
  PVector pos;
  
  //Image
  PImage pew;
  
  //Other variables
  float dirAngle;
  int radius;
  int time;
  
  //Constructor
  Bullet(float dA, PVector p)
  {
    //Pass in the angle of direction
    dirAngle = dA;
    
    //Instantiate the vectors
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    dir = PVector.fromAngle(radians(dirAngle));
    
    //Pass in the position
    pos = new PVector(p.x, p.y);
    
    //Load the image
    pew = loadImage("Pew.png");
    
    //Instantiate other variables
    radius = 5;
    time = 0;
  }
  
  //Move
  boolean Move(int timer)
  {
    //Increment the timer
    time++;
    
    //Move the bullet if the timer is less than the allotted time
    if(time < timer)
    {
      //Calculate acceleration based on direction
      dir.normalize();
      dir.mult(0.5);
      acc = dir;
      
      //Calculate velocity
      vel.add(acc);
      vel.limit(10);
      
      //Add velocity to posisition
      pos.add(vel);
      
      //Wrapping
      if(pos.x > width + 10)
      {
        pos.x = -10;
      }
      if(pos.x < -10)
      {
        pos.x = width + 10;
      }
      if(pos.y > height + 10)
      {
        pos.y = -10;
      }
      if(pos.y < -10)
      {
        pos.y = height + 10;
      }
      
      //Draw bullet
      pushMatrix();
      translate(pos.x - 5, pos.y - 5);
      image(pew, 0, 0);
      popMatrix();
      
      return true;
    }
    else
    {
      return false;
    }
  }
  
  //Return position
  PVector Pos()
  {
    return pos;
  }
  
  //Collisions
  boolean Collide(ArrayList<Asteroid> ast)
  {
    for(int c = 0; c < ast.size(); c++)
    {
      //Variables
      float radi = ast.get(c).Radius();
      PVector p = ast.get(c).Pos();
      
      //Get the distance between the input position and bullet position
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
    return false;
  }
}