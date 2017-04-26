class Archive{
 
  
  String path;
  String name;
  Table table;
  PGraphics thumbn = createGraphics(300,200);
  int [] points = new int[200];
  int x,y;
  int xlength = 330, ylength = 260; 
  int pageScrolled = 0;
  
 
  
  
  void SetCoord(int currx, int curry){
    x = currx;
    y = curry;
  }
  
  void ReadFrom(String a, String b){
    path = a;
    name = b;
    table = loadTable("data\\"+path+"\\measures.csv");
    //println("read from","data\\"+path+"\\measures.csv");
    
    
    int rows = table.getRowCount();
    
    if(rows>=300){
      int pointer = rows-rows/3;
      while(rows-pointer<=300){
        pointer--;
      }
      thumbn.beginDraw();
      thumbn.background(20);
      thumbn.endDraw();
      for(int i=pointer; i<pointer+300; i++){
        
        int thumbY = table.getInt(i,0)/5;
        int thumbX = i-pointer;
        int thumbY1 = table.getInt(i+1,0)/5;
        int thumbX1 = i+1-pointer;
        //println(thumbX,100+thumbY,thumbX1,100+thumbY1);
        
        thumbn.beginDraw();
        thumbn.stroke(255);
        //thumbn.ellipse(100,100,100,100);
        
        thumbn.stroke(100,100,0);
        thumbn.strokeWeight(2);
        thumbn.line(thumbX,100+thumbY,thumbX1,100+thumbY1);
        thumbn.endDraw();
          
      }
    }
    else{
      thumbn.beginDraw();
      thumbn.background(20);
      thumbn.endDraw();
    }
    
    
    
    
  }
  
  void Display(int pageScrolled){
    
    textSize(20);
    stroke(0);
    noStroke();
    fill(250);
    if(mouseOver(pageScrolled)){
      fill(220);
      rect(x,pageScrolled+y,xlength,ylength);
      textAlign(LEFT);
      fill(0);
      text(name,x+20,y+40+pageScrolled);
      if(mousePressed && !mouseDragged){
          if(mouseButton==LEFT){
            delay(200);
            master.changePage(archivesSelectPG,path);
            mousePressed = false;
          }
      }
       
    }
    else{
    fill(20);
    stroke(180);
    strokeWeight(2);
    rect(x, pageScrolled+y, xlength, ylength); 
    textAlign(LEFT);
    fill(180);
    text(name,x+20,y+40+pageScrolled);
    }
    Thumbnail(pageScrolled);
    
    
}
  

  boolean mouseOver(int pageScrolled){
    if(mouseX > x && mouseX < x+xlength && mouseY <y+ylength+pageScrolled && mouseY > y+pageScrolled){
     return true;
    }
    return false;
  }
  
  
  
 void Thumbnail(int pgscr){

   image(thumbn,x+15,y+pgscr+50);
 }
}