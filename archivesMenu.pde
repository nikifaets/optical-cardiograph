class archivesMenu{
   PImage logo = loadImage("pic\\logo.png");
   PImage delete = loadImage("pic\\Bin.png");
   Table objtable;
   int objectsnum;
   ArrayList <Archive> objs = new ArrayList <Archive>();
   int pageScrolled=0;
   int select = -1;
   float mouseLocked = -1;
   float lockedDist = 0;
   int maxScrolled;

void setArchives(){
    pageScrolled = 0;
    objtable = loadTable("data\\folders.csv");
 
    select = -1;
    objectsnum = objtable.getRowCount();
    //println(objectsnum);
    
    //objectsnum++;
    //objs = new Archive[objectsnum];

  
    
  int Sety = 150;
  
  for(int objectcount=1; objectcount < objectsnum; objectcount++){
    String path = objtable.getString(objectcount,0);
    String name = objtable.getString(objectcount,1);
    
    int Arridx = objectcount-1;
    
    
    
    //println(path);
    objs.add(new Archive());
    objs.get(Arridx).ReadFrom(path, name);
    
     //Sety = (Arridx)*150+100;
    
    if(Arridx%2==0){
       if(Arridx>0){
          Sety+=310;
        }
      objs.get(Arridx).SetCoord(140, Sety);
  
}
  else{
    objs.get(Arridx).SetCoord(530,objs.get(Arridx-1).y);
}
  }
  
  maxScrolled = (objectsnum/2)*310-250;
}

void drawArchives(){
  background(20);

  for(int objcount = 1; objcount<objectsnum; objcount++){
    int Arridx = objcount-1;
    objs.get(Arridx).Display(pageScrolled);
    
}

  mouseClick();
  menuLent();
  int arg = 1;
  if(objectsnum>0) arg = objectsnum;
  scrollRect(arg);
  if(mouseReleased && mouseLocked != -1) mouseLocked = -1;

}

void Scroll(float e){
  if(e > 0 && pageScrolled > -maxScrolled){pageScrolled -= 40; } //background(200); }
  else if(e <0 && pageScrolled <0) {pageScrolled +=40;  } //background(200);}
  //println(pageScrolled);
   
  if(pageScrolled< -maxScrolled){
    pageScrolled = -maxScrolled;
  }
  if(pageScrolled > 0){
    pageScrolled = 0;
  }
   

  }
  
  void scrollRect(int objs){
  
  
  float scrSize = 310*(objs/2)+250;
  //println(scrSize);
  
  float vz = 1;
  if(scrSize/500>0) vz = scrSize/500;
  float recSize = 420/(vz);
  if(recSize<1) recSize=1;
  float recY=80;
  if(pageScrolled != 0)  recY = 80+abs(pageScrolled/scrSize)*420;
 
  
  
  boolean mouseOver = false;
  //boolean mouseOverScroll = false;
  float center = (recY+recY+recSize)/2;
  if(mouseX<=990 && mouseX>=970 && mouseY<=recY+recSize && mouseY>=recY) mouseOver = true;
  //if(mouseX<=990 && mouseX>=970) mouseOverScroll = true;
  
  if(mouseOver || mouseLocked != -1){
    fill(160);
    noStroke();
    rect(970, recY, 20, recSize);
  }
  
  if(mousePressed && mouseButton==LEFT && mouseOver){
     if(mouseLocked==-1){
       mouseLocked = mouseY;
       lockedDist = mouseY-center;
     }
   }
  
  
  if(mouseDragged && mouseLocked != mouseY && mouseLocked!=-1){
    if(pageScrolled - (mouseY-mouseLocked)*(scrSize/500) < 0 && pageScrolled - (mouseY-mouseLocked)*(scrSize/500) > -maxScrolled){
       pageScrolled -= (mouseY-mouseLocked)*(scrSize/500);
       mouseLocked = mouseY;
    }
   }
    
  
if(!mouseOver && mouseLocked == -1){
    fill(190);
    noStroke();
    rect(970, recY, 20, recSize);
  }
  
  
/*if(!mouseOverScroll && mouseLocked == -1){
  fill(20);
  rect(970,0, 990, 1000);
}*/
}
  
  
void menuLent(){
  fill(20);
  noStroke();
  rect(0,0,1000,80);
  button.Display();
  //backG.showSmall();
  noStroke();
  /*fill(60);
  rect(0,60,1000,20);*/
  image(logo,400,10);
  //println(select);
  if(select>=0){
    showData(objs.get(select));
  }
  
}

void showData (Archive selected){
  fill(240);
  textSize(18);
  text("Selected:", 700,20);
  text(selected.name,700,60);
  deleteButton(900,30);
}

void mouseClick(){
  boolean on = false;
  if(mousePressed && !mouseDragged){
    if(mouseButton==RIGHT){
      for(int i=0; i<objectsnum-1;i++){
        if(objs.get(i).mouseOver(pageScrolled)){
          select = i;
          on = true;
        }
      }
    }
    else on = false;
    
    if(!on && mouseY>=80) select = -1;
    
  }
  
}

void deleteButton(int x, int y){
  if(mouseX>=x && mouseX <= x+50 && mouseY >=y && mouseY <=y+50){
    fill(240);
    ellipse(x+50/2-5, y+50/2-5, 40,40);
    if(mousePressed && mouseButton==LEFT && !mouseDragged){
      println("to delete: ", objs.get(select).path);
      delay(100);
      deleteFile(objs.get(select).path);
      clearArchives();
      setArchives();
      
      
    }
  }
  else{
    fill(20);
    ellipse(x+50/2-5, y+50/2-5, 40,40);
  }
  image(delete,x,y);
}

void clearArchives(){
  objs.clear();
 
  
}
}