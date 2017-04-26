class Menu {
  
  boolean animRdy = false;
  int xpos = 0;
  String Graphics = "Make a measure";
  String Archives = "View archives";
  String Exit = "Exit";
  String Settings = "Settings";

  int xlen = 200, ylen = 40;
  masterUI master = new masterUI();
  archivesMenu archives = new archivesMenu();
  
  void setMenu(){
    animRdy=false;
    xpos=0;
  }
  
  void showMenu(){
    background(20);
    if(!animRdy){
      Intro();
    }
    else{
    backG.showBig();
    drawBox(400,70,Graphics);
    drawBox(400,135,Archives);
    drawBox(400,200,Settings);
    drawBox(400,265,Exit);

    }
  }
    

  void Intro() {
    if(mousePressed) xpos=400;
    if (xpos<=400) {
      stroke(100, 100, 0);
      strokeWeight(3);
      line(xpos, 250, xpos+200, 250);
      xpos+=10;
      if (xpos>=400) {
        animRdy=true;
        delay(120);
      }
      
    }
  }
  

  
  
  void drawBox(int x, int y, String text){
      textAlign(LEFT);
      strokeWeight(1);
    if(mouseOver(x,y)){
      stroke(0);
      fill(190);
      rect(x,y,xlen,ylen);
      
      textSize(20);
      fill(0);
      
      text(text, x+(200-text.length()*11)/2, y+30); 
      if(mousePressed && !mouseDragged && mouseButton==LEFT){
        
        if(text.equals(Graphics)){
          delay(200);
          master.changePage(graphicsPG);
          
        }
        
        if(text.equals(Archives)){
          delay(200);
          master.changePage(archivesMenuPG);
          
        }
        if(text.equals(Exit)){
          delay(200);
          exit();
          
        }
        if(text.equals(Settings)){
          delay(200);
          master.changePage(settingsPG);
        }
        
      }
      mousePressed = false;
      
    }
    else{
      fill(230);
      stroke(0);
      rect(x,y,xlen,ylen);
      textSize(20);
      fill(0);
      text(text, x+(200-text.length()*11)/2, y+30);
    }
  }
      
        
        
    
/*void connectButton(){
  if(!Connected){
    if(dist(mouseX,mouseY,800,200)<=42){
      fill(80,0,0);
      if(mousePressed && mouseButton==LEFT && !mouseDragged){
        if(Connect()){
          port.write(50);
        }
      }
    }
    else{
      fill(150,0,0);
    }
    ellipse(800,200,85,85);
    fill(255);
    textSize(16);
    textAlign(CENTER);
    text("Connect", 800,200);
  }
  if(Connected){
    fill(0,200,0);
    ellipse(800,200,85,85);
    fill(255);
    textSize(16);
    textAlign(CENTER);
    text("Connected", 800,200);
  }
}*/
    

boolean mouseOver(int x, int y){
  if(mouseX>x && mouseX<x+xlen && mouseY>y && mouseY < y+ylen){
    return true;
}
    return false;
}
}