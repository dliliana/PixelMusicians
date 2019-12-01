final int displayWidth = 512;
final int displayHeight = 320;

float DOWN_FORCE = 1;
float ACCELERATION = 1.3;
float DAMPENING = 0.75;

void initialize() {
  frameRate(30);
  addScreen("level", new MarioLevel(((float)1364/displayWidth)*width, height));  
}
class MarioLevel extends Level {
  MarioLevel(float levelWidth, float levelHeight) {
    super(levelWidth, levelHeight);
    addLevelLayer("layer", new MarioLayer(this));
    setViewBox(0,0,displayWidth,displayHeight);
    
    
  }
}

class Mario extends Player {
  Mario(float x, float y) {
    super("Mario");
    setupStates();
    setPosition(x,y);
    handleKey('W');
    handleKey('A');
    handleKey('D');
    setForces(0,DOWN_FORCE);
    setAcceleration(0,ACCELERATION);
    setImpulseCoefficients(DAMPENING,DAMPENING);
    
    
 
  }
  void setupStates() {
    addState(new State("idle", "C:/Users/lilid/OneDrive/Asztali gép/Egyetem/2.év/programozas/mariogaem/codebase/allokari.gif"));
    addState(new State("running1", "C:/Users/lilid/OneDrive/Asztali gép/Egyetem/2.év/programozas/mariogaem/codebase/futas4kep1.png"));
    addState(new State("running2", "C:/Users/lilid/OneDrive/Asztali gép/Egyetem/2.év/programozas/mariogaem/codebase/futas4kep2.png"));
    addState(new State("running3", "C:/Users/lilid/OneDrive/Asztali gép/Egyetem/2.év/programozas/mariogaem/codebase/futas4kep3.png"));
    
    State jumping=new State("jumping", "C:/Users/lilid/OneDrive/Asztali gép/Egyetem/2.év/programozas/mariogaem/codebase/ugras.gif");
    jumping.setDuration(15);
    addState(jumping);
    
    addState(new State("dead", "C:/Users/lilid/OneDrive/Asztali gép/Egyetem/2.év/programozas/mariogaem/codebase/halotti.gif",1,2));
    setCurrentState("idle");  
  }
  
  
   
  void futas(){
    if(active.name=="running1"){
      setCurrentState("running2");
      //System.out.println("1");
    }
    else if (active.name=="running2"){
       setCurrentState("running3");
       //System.out.println("2");
    }
    else if(active.name=="running3"){
      setCurrentState("running1");
      //System.out.println("3");
    }
    else if(active.name=="idle"){
      setCurrentState("running1");
      //System.out.println("4");
    }
    else if(active.name=="jumping"){
      setCurrentState("running1");
      //System.out.println("5");
    }
  }
  
  
  void handleInput() {
    //if (isKeyDown('A')) { addImpulse(-2, 0); }
    //if (isKeyDown('D')) { addImpulse(2, 0); }
    //if (isKeyDown('W')) { addImpulse(0,-10); }
    
      if(isKeyDown('A') || isKeyDown('D')) {

      if (isKeyDown('A')) {
        setHorizontalFlip(true);
        addImpulse(-2, 0);
      }
      if (isKeyDown('D')) {
        setHorizontalFlip(false);
        addImpulse(2, 0);
      }
      
    }

    // handle jumping
    if(isKeyDown('W') && active.name!="jumping" && boundaries.size()>0) {
      addImpulse(0,-35);
      setCurrentState("jumping");
    }else {  futas(); }

    if(!isKeyDown('A') && !isKeyDown('D') && !isKeyDown('W')) {
       setCurrentState("idle");
    }
      if (active.mayChange()) {
      if(isKeyDown('A') || isKeyDown('D')) {
        futas();
      }else {  setCurrentState("idle"); }
      }
  
}
}

class Koopa extends Interactor {
  // we construct a Koopa trooper pretty much the same way we did Mario:
  Koopa(float x, float y) {
    super("Koopa Trooper");
    setStates();
    setForces(-0.25, DOWN_FORCE);    
    setImpulseCoefficients(DAMPENING, DAMPENING);
    setPosition(x,y);
  }
  // And we use states.
  void setStates() {
    // walking state
    State walking = new State("idle", "boss.gif", 1, 2);
    walking.setAnimationSpeed(0.12);
    addState(walking);

  }

}

class MarioLayer extends LevelLayer {
  
   void addGround(float x1, float y1, float x2, float y2) {
    Sprite filler = new Sprite("C:/Users/lilid/OneDrive/Asztali gép/Egyetem/2.év/programozas/mariogaem/codebase/padlo1.png");
    TilingSprite groundfiller = new TilingSprite(filler, x1,y1,x2,y2);
    addBackgroundSprite(groundfiller);
    addBoundary(new Boundary(x1,y1,x2,y1));
  }  
  
   void addGround2(float x1, float y1, float x2, float y2) {
    Sprite filler = new Sprite("C:/Users/lilid/OneDrive/Asztali gép/Egyetem/2.év/programozas/mariogaem/codebase/padlo2.png");
    TilingSprite groundfiller = new TilingSprite(filler, x1,y1,x2,y2);
    addBackgroundSprite(groundfiller);
    //addBoundary(new Boundary(x1,y1,x2,y1));
  }  
  
  void addAkadaly1(float x1, float y1, float x2, float y2) {
    Sprite filler = new Sprite("C:/Users/lilid/OneDrive/Asztali gép/Egyetem/2.év/programozas/mariogaem/codebase/akadalyhsz1.png");
    TilingSprite groundfiller = new TilingSprite(filler, x1,y1,x2,y2);
    addBackgroundSprite(groundfiller); //37*36
  }
  
  void addAkadaly2(float x1, float y1, float x2, float y2) {
    Sprite filler = new Sprite("C:/Users/lilid/OneDrive/Asztali gép/Egyetem/2.év/programozas/mariogaem/codebase/akadalyhsz2.png");
    TilingSprite groundfiller = new TilingSprite(filler, x1,y1,x2,y2);
    addBackgroundSprite(groundfiller); //36w*35h
  }
  
  void addAkadaly3(float x1, float y1, float x2, float y2) {
    Sprite filler = new Sprite("C:/Users/lilid/OneDrive/Asztali gép/Egyetem/2.év/programozas/mariogaem/codebase/akadalyhsz3.png");
    TilingSprite groundfiller = new TilingSprite(filler, x1,y1,x2,y2);
    addBackgroundSprite(groundfiller); //32w*27h
  }
  
  void addAkadaly4(float x1, float y1, float x2, float y2) {
    Sprite filler = new Sprite("C:/Users/lilid/OneDrive/Asztali gép/Egyetem/2.év/programozas/mariogaem/codebase/akadalyhsz4.png");
    TilingSprite groundfiller = new TilingSprite(filler, x1,y1,x2,y2);
    addBackgroundSprite(groundfiller); //106w*43h
  }
  
  void addAkadaly5(float x1, float y1, float x2, float y2) {
    Sprite filler = new Sprite("C:/Users/lilid/OneDrive/Asztali gép/Egyetem/2.év/programozas/mariogaem/codebase/akadalyhsz6.png");
    TilingSprite groundfiller = new TilingSprite(filler, x1,y1,x2,y2);
    addBackgroundSprite(groundfiller); //51w*51h
  }
  
   void addAkadaly6(float x1, float y1, float x2, float y2) {
    Sprite filler = new Sprite("C:/Users/lilid/OneDrive/Asztali gép/Egyetem/2.év/programozas/mariogaem/codebase/akadalyhsz5.png");
    TilingSprite groundfiller = new TilingSprite(filler, x1,y1,x2,y2);
    addBackgroundSprite(groundfiller); //51w*43h
  }
  
  void FeketeDoboz1(){
  addAkadaly1(230,height-100, 266,height-63);
     addBoundary(new Boundary(230,height-100,266,height-100)); //teteje
     addBoundary(new Boundary(230,height-63,230,height-85)); //eleje
     addBoundary(new Boundary(266,height-85,266,height-63)); //hatulja
  }
  
  void FeketeDoboz1_2(){
  addAkadaly1(340,height-143, 370,height-106);
     addBoundary(new Boundary(340,height-143,370,height-143)); //teteje
     addBoundary(new Boundary(340,height-106,340,height-136)); //eleje
     addBoundary(new Boundary(375,height-136,375,height-106)); //hatulja
  }
  
  void FeketeDoboz2(){
  addAkadaly2(395,height-184, 431,height-151);
     addBoundary(new Boundary(395,height-184,431,height-184)); //teteje
     addBoundary(new Boundary(395,height-151,395,height-181)); //eleje
     addBoundary(new Boundary(431,height-181,431,height-151)); //hatulja
  }
  
  void FeketeDoboz4(){
  addAkadaly4(330,height-106, 436,height-63);
     addBoundary(new Boundary(330,height-106,436,height-106)); //teteje
     addBoundary(new Boundary(330,height-63,330,height-93)); //eleje
     addBoundary(new Boundary(436,height-93,436,height-63)); //hatulja
  }

 void FeketeDoboz3(){
  addAkadaly3(360,height-90, 387,height-63);
     addBoundary(new Boundary(360,height-90,387,height-90)); //teteje
    // addBoundary(new Boundary(255,height-63,255,height-85)); //eleje
    // addBoundary(new Boundary(290,height-85,290,height-63)); //hatulja
  }
 
 void FeketeDoboz5(){
  addAkadaly5(480,height-114, 531,height-63);
     addBoundary(new Boundary(480,height-114,531,height-114)); //teteje
     addBoundary(new Boundary(480,height-63,480,height-93)); //eleje
     addBoundary(new Boundary(531,height-93,531,height-63)); //hatulja
  }
 
 void FeketeDoboz6(){
  addAkadaly6(385,height-149, 428,height-106);
     //addBoundary(new Boundary(255,height-100,285,height-100)); //teteje
     //addBoundary(new Boundary(255,height-63,255,height-85)); //eleje
     addBoundary(new Boundary(433,height-146,433,height-106)); //hatulja
  }
 
Mario mario;

  MarioLayer(Level owner) {
    super(owner);
    
    addBoundary(new Boundary(0,height-63,538,height-63));
    addBoundary(new Boundary(619,height-63,1364,height-63));
    addBoundary(new Boundary(-1,0, -1,height));
    addBoundary(new Boundary(width+1,height, width+1,0));
    showBoundaries = true;
    mario = new Mario(width/4, height/2);
    addPlayer(mario);
    
    
    
   // C:/Users/lilid/OneDrive/Asztali gép/Egyetem/2.év/programozas/mariogaem/codebase/
    setBackgroundColor(color(0, 100, 190));
    Sprite background_picture = new Sprite("hatterjo.png");
    TilingSprite background = new TilingSprite(background_picture,0,0,width,height);
    addBackgroundSprite(background);
    Mario mario = new Mario(width/4, height/2);
    addPlayer(mario);
    
    Koopa koopa = new Koopa(1200, height-200);
    addInteractor(koopa);
    
      addGround(0,height-63, 538,height);
      addBoundary(new Boundary(538,height-63,538,height));
    
      addGround2(30,height-63, width,height);
      addBoundary(new Boundary(619,height,619,height-63));
     
     
      addBoundary(new Boundary(930,height-109,1231,height-109));
     
    FeketeDoboz1();
    FeketeDoboz1_2();
    FeketeDoboz2();
    FeketeDoboz4();
    FeketeDoboz3();
    FeketeDoboz5();
    FeketeDoboz6();
  
  
  }
    void draw() {
    super.draw();
    viewbox.track(parent, mario);
  }
}
