public abstract class Organism{

PVector pos;
PVector vel;
double age;
double sizeFactor;//to scale the ratio of siz to energy level
boolean isAlive = true;
boolean feeding = false;
float minEnergy = 0;//amount of energy to be born at; if health becomes less than half of this amount, death
double energyLevel;//uses for current energy
double growthRate;//replace with feedeff
double decayRate;//rate at which energy is removed from animal
double reproductionEnergy;//
double reproductionEnergyMantained;//amount needed to be able to reproduce
double eatSpeed;//amount of energy taken each frame
float sight;//used for hunting and perhaps sporing
float speed;//movement
float siz;//effective size on the screen, based on energy level
int maxAge = 0;//age where becomes dead regardless of health

int travelFrames; //number of used for birthing and hunting

float social;//used for having organisms cluster or flee each other
color col; //color used for drawing
color dCol; //color when dead
color armorCol = color (150,200,200,150);
float hunger;
float health;
float healRate;
float armor = 2;
float maxHealth;
float attack;
float animFreq;

abstract void update();
abstract void decay();
abstract void eat();
abstract void move();
abstract void reproduce();
abstract void killSelf();
//age as a method is removed and age is adjusted in decay
}
