class goBack{
  PImage bArrow = loadImage("pic\\arrow.png");
  PGraphics field = createGraphics(50,50);
  int x=30;
  int y=0;
  int rad=25;
  void Display(){
    onClick();
    
    fill(0);
    field.beginDraw();
    field.background(20);
    Hover();
    field.image(bArrow,2,4);
    field.endDraw();
    image(field,30,10);
    
  }
  
  void onClick(){
    if(dist(mouseX,mouseY,x+rad,y+rad)<=rad && mousePressed && !mouseDragged && mouseButton==LEFT){
   
      if(pageNm==graphicsPG){
        if(!graph.saved){
          notify=true;
          notif.getNotif("AskIfSave");
        }
        else{
          master.changePage(menuPG);
      }
      }
      
      if(pageNm==archivesMenuPG){
        //archives.clearArchives();
        master.changePage(menuPG);
      }
      
    
    
    if(pageNm == archivesSelectPG){
        master.changePage(archivesMenuPG);
        
      }
    if(pageNm == measureInspectPG){
      master.changePage(archivesSelectPG, measureMenu.fullpath);
    }
    
    
    if(pageNm == histogrammPG){
      histogram.closehistogramm();
      master.changePage(archivesSelectPG);
    }
    
    if(pageNm == settingsPG){
      master.changePage(menuPG);
    }
     
    
    }
  }
  
  void Hover(){
    if(dist(mouseX, mouseY, x+rad, y+rad)<=rad){
      
      field.fill(240);
      field.noStroke();
      field.ellipse(25,25,rad*2,rad*2);
     // field.background(255);
     
    }
  
}
}
    