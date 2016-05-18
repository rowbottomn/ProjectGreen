public abstract class Organism{

PVector pos;
PVector vel;
double age;
double sizeFactor;
boolean isAlive = true;
boolean feeding = false;
double energyLevel;
double growthRate;
double decayRate;
double reproductionEnergy;
double reproductionEnergyMantained;
double eatSpeed;
double sight;
float speed;
float siz;
int maxAge = 0;
float minEnergy = 0;
float social;


abstract void drawSelf();
abstract void update();
abstract void decay();
abstract void eat();
abstract void move();
abstract void reproduce();
abstract void killSelf();

}
