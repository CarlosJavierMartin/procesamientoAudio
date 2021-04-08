import processing.sound.*;

Pulse pulso;
SinOsc sinu;
SawOsc sier;
SqrOsc cuad;
TriOsc tria;
ArrayList<myKey> soundList;
int[] levelList;

int diff, total, actualLevel, sound, current = 0;
float frequ;
boolean alreadyPressed, gameStarted, levelPlaying, displaySound;

myKey key1;

void setup(){
  size(800,500);

  pulso = new Pulse(this);
  sinu = new SinOsc(this);
  sier = new SawOsc(this);
  cuad = new SqrOsc(this);
  tria = new TriOsc(this);
  
  soundList = new ArrayList<myKey>();
  
  diff = 2;
  sound = 1;
  
  createSoundList();
  
  displayMenu();
  
  alreadyPressed = false;
  gameStarted = false;
  levelPlaying = false;
  
}

void createSoundList(){
  soundList.add(new myKey(0,200,100,350,1,0,0,0));
  soundList.add(new myKey(0,350,100,500,2,23,32,42));
  soundList.add(new myKey(100,200,200,350,3,33,47,60));
  soundList.add(new myKey(100,350,200,500,4,66,73,73));
  soundList.add(new myKey(200,200,300,350,5,123,125,125));
  soundList.add(new myKey(200,350,300,500,6,220,118,51));
  soundList.add(new myKey(300,200,400,350,7,235,152,78));
  soundList.add(new myKey(300,350,400,500,8,244,208,63));
  soundList.add(new myKey(400,200,500,350,9,88,214,141));
  soundList.add(new myKey(400,350,500,500,10,82,190,128));
  soundList.add(new myKey(500,200,600,350,11,69,179,157));
  soundList.add(new myKey(500,350,600,500,12,93,173,226));
  soundList.add(new myKey(600,200,700,350,13,84,153,199));
  soundList.add(new myKey(600,350,700,500,14,165,105,189));
  soundList.add(new myKey(700,200,800,350,15,203,67,53));
  soundList.add(new myKey(700,350,800,500,16,100,30,22));
}

void draw(){
  if(displaySound){
      displaySound = false;
      
      switch(sound){
        case 1:
        pulso.amp(0.5);
        pulso.freq(frequ);
        pulso.play();
        delay(1000);
        pulso.stop();
        break;
        
        case 2:
        sinu.amp(0.5);
        sinu.freq(frequ);
        sinu.play();
        delay(1000);
        sinu.stop();
        break;
        
        case 3:
        sier.amp(0.5);
        sier.freq(frequ);
        sier.play();
        delay(1000);
        sier.stop();
        break;
        
        case 4:
        cuad.amp(0.5);
        cuad.freq(frequ);
        cuad.play();
        delay(1000);
        cuad.stop();
        break;
        
        case 5:
        tria.amp(0.5);
        tria.freq(frequ);
        tria.play();
        delay(1000);
        tria.stop();
        break;
      }
      
      
      key1.display(true);
  }
  if(gameStarted){
    if (mousePressed && !alreadyPressed && !levelPlaying){
      alreadyPressed = true;
      int x = mouseX;
      int y = mouseY;
      if(x < 800 && x > 0 && y < 500 && y > 200){
        if (checkSound(x,y)){
          if (levelList[actualLevel-1] == -1){
            updateScore(actualLevel);
            actualLevel++;
            levelPlaying = true;
          }
        } else {
          youLose();
          
        }
      } 
    } else {
      if(levelPlaying){
        if (actualLevel > total){
          youWin();
        } else {
          if (current == 0){
            levelList = new int[actualLevel];
          }
          if (current != actualLevel){
            nextAudio();
          } else{
            levelPlaying = false;
            current = 0;
          }
        }
      }
    }
  }
}

void nextAudio(){
  int r;
  if (current > 0){ 
    r = levelList[current-1];
    while (r == levelList[current-1]){
      r = (int) random(1,16);
    }
  } else{
    r = (int) random(1,16);
  }
  for( myKey k : soundList){
    if(k.getCount() == r){
      k.display(false);
      displaySound = true;
      frequ = ((k.getfinX()-k.getX())*k.getCount() - k.getfinY()-k.getY())/(0.5*k.getCount());
      key1 = k;
      levelList[current] = k.getCount();
      current++;
      break;
    }   
  }
}


void mouseReleased(){
  alreadyPressed = false;

}

boolean checkSound(int x, int y){
 for( myKey k : soundList){
   if(k.isInside(x,y)){
      for (int i = 0; i < actualLevel; i++) {
        if(levelList[i] != -1){
          if (levelList[i] == k.getCount()){
            levelList[i] = -1;
            
            k.display(false);
            displaySound = true;
            frequ = ((k.getfinX()-k.getX())*k.getCount() - k.getfinY()-k.getY())/(0.5*k.getCount());
            key1 = k;
            
            return true;
          } else {
            return false;
          }
        }
      }
      
    }   
  }
 
  return false;
}

void launchSound(int x, int y){
  //Metodo para probar los sonidos
  for( myKey k : soundList){
    if(k.isInside(x,y)){
      k.display(false);
      displaySound = true;
      frequ = ((k.getfinX()-k.getX())*k.getCount() - k.getfinY()-k.getY())/(0.5*k.getCount());
      key1 = k;
      break;
    }   
  }

}

void displayMenu(){
  background(0);
  textAlign(LEFT);
  fill(255);
  rect(0,0,800,200);
  fill(0);
  textSize(18);
  text("Selecciona el nivel de dificultad usando las flechas del teclado.",5,25);
  text("Usa los numeros del 1 al 5 para cambiar sonidos",5,50);
  text("Pulsa enter para empezar la partida",5,75);
  text("Pulsa retroceso para resetear el juego",5,100);
  switch(diff){
    case 1:
      fill(120,120,120);
      rect(525,50,100,100);
      fill(255);
      rect(525,55,100,25);
      fill(0);
      
      textAlign(CENTER);
      text("Facil",575, 75);
      text("Normal",575, 100);
      text("Dificil",575, 125);
      total = 3;
      updateScore(0);
    break;
    case 2:
      fill(120,120,120);
      rect(525,50,100,100);
      fill(255);
      rect(525,80,100,25);
      fill(0);
      
      textAlign(CENTER);
      text("Facil",575, 75);
      text("Normal",575, 100);
      text("Dificil",575, 125);
      total = 6;
      updateScore(0);
      
    
    break;
    case 3:
      fill(120,120,120);
      rect(525,50,100,100);
      fill(255);
      rect(525,105,100,25);
      fill(0);
      
      textAlign(CENTER);
      text("Facil",575, 75);
      text("Normal",575, 100);
      text("Dificil",575, 125);
      total = 9;
      updateScore(0);
      
    break;
  }
  
  switch(sound){
     case 1:
      fill(120,120,120);
      rect(650,25,100,150);
      fill(255);
      rect(650,30,100,25);
      fill(0);
              
      textAlign(CENTER);
      text("Pulso",700, 50);
      text("Sinusoidal",700, 75);
      text("Cierra",700, 100);
      text("Cuadratico",700, 125);
      text("Triangular",700, 150);
     break;
     case 2:
      fill(120,120,120);
      rect(650,25,100,150);
      fill(255);
      rect(650,55,100,25);
      fill(0);
              
      textAlign(CENTER);
      text("Pulso",700, 50);
      text("Sinusoidal",700, 75);
      text("Cierra",700, 100);
      text("Cuadratico",700, 125);
      text("Triangular",700, 150);
       
     break;
     case 3:
      fill(120,120,120);
      rect(650,25,100,150);
      fill(255);
      rect(650,80,100,25);
      fill(0);
              
      textAlign(CENTER);
      text("Pulso",700, 50);
      text("Sinusoidal",700, 75);
      text("Cierra",700, 100);
      text("Cuadratico",700, 125);
      text("Triangular",700, 150);
       
     break;
     case 4:
      fill(120,120,120);
      rect(650,25,100,150);
      fill(255);
      rect(650,105,100,25);
      fill(0);
              
      textAlign(CENTER);
      text("Pulso",700, 50);
      text("Sinusoidal",700, 75);
      text("Cierra",700, 100);
      text("Cuadratico",700, 125);
      text("Triangular",700, 150);
      
     break;
     case 5:
      fill(120,120,120);
      rect(650,25,100,150);
      fill(255);
      rect(650,130,100,25);
      fill(0);
              
      textAlign(CENTER);
      text("Pulso",700, 50);
      text("Sinusoidal",700, 75);
      text("Cierra",700, 100);
      text("Cuadratico",700, 125);
      text("Triangular",700, 150);
       
     break;
  
  
  
  }
  
  displayKeyboard();
}


void updateScore(int actual){
  textAlign(LEFT);
  textSize(18);
  fill(0);
  text("Marcador:",5,180);
  fill(120,120,120);
  rect(100,150, total*20+total*10, 40);
  for (int i = 1; i <= total; i++){
    if (i <= actual){
      fill(0,255,0);
    } else {
      fill(255,0,0);
    }
    circle(110+i*15+((i-1)*10), 170,15);
  }
  
}

void displayKeyboard(){
  fill(255);
  for(int i = 0; i < width; i+=100){
    rect(i,200, 100,150);
    rect(i,350, 100,150);
  }
}

void youWin(){
  gameStarted = false;
  displayMenu();
  textSize(32);
  fill(0);
  text("Haz ganado",400,165);
}

void youLose(){
  gameStarted = false;
  displayMenu();
  textSize(32);
  fill(0);
  text("Haz perdido",400,165);
}

void reset(){
  diff = 2;
  gameStarted = false;
  displayMenu();
}

void keyPressed(){
  if (keyCode == UP){
    if (diff == 1){ 
      diff = 3;
    } else {
      diff--;
    }
    displayMenu();
  }
  if (keyCode == DOWN){
    if (diff == 3){ 
      diff = 1;
    } else {
      diff++;
    }
    displayMenu();
  }
  
  if (key == '1'&& !gameStarted){
    sound = 1;
    displayMenu();
  }
  if (key == '2'&& !gameStarted){
    sound = 2;
    displayMenu();
  }
  if (key == '3'&& !gameStarted){
    sound = 3;
    displayMenu();
  }
  if (key == '4'&& !gameStarted){
    sound = 4;
    displayMenu();
  }
  if (key == '5' && !gameStarted){
    sound = 5;
    displayMenu();
  }
  
  if (keyCode == ENTER && !gameStarted){
    gameStarted = true;
    levelPlaying = true;
    actualLevel = 1;
  }
  
  if (keyCode == BACKSPACE){
    reset();
  }

}

class myKey{

  int x, y, finx, finy, count, R, G, B;
  
  
  
  myKey(int x, int y, int finx, int finy, int count, int R, int G, int B){
    this.x = x;
    this.y = y;
    this.finx = finx;
    this.finy = finy;
    this.count = count;
    this.R = R;
    this.G = G;
    this.B = B;
  }

  boolean isInside(int x, int y){
    if(x > this.x && x < this.finx && y > this.y && y < this.finy){
      return true;
    }
    return false;
  }
  
  void display(boolean b){
    if(b){
      fill(255);
    } else {
      fill(R,G,B);
    }
    rect(x,y, finx - x,finy - y);

  }
  
  int getX(){
    return x;
  }
  
  int getY(){
    return y;
  }
  
  int getfinX(){
    return finx;
  }
  
  int getfinY(){
    return finy;
  }
  
  int getCount(){
    return count;
  }
  
}
