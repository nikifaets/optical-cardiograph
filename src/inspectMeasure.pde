class Inspect {
  String path;
  FloatList arr;
  Table read;
  PGraphics layer;
  PGraphics Time;
  PGraphics tools;
  PImage scrIcon;
  String line;
  int idx=0;
  boolean press = false;
  boolean locked = false;
  float lockedx = 0, lockedy = 0;
  int scr = 0;
  int scrollY = 0, scrollX=0;
  int zoomk = 1;
  int mouseCentr;
  float s;
  

  void setInspect(String a) {
   
    scrollX = 0;

    path = a;
    read = loadTable("data\\"+path+"\\measures.csv");
    idx = read.getRowCount();
    zoomk=1;
    
    layer = createGraphics(int((idx*zoomk+200)), int(500*zoomk));
    Time = createGraphics(100,40);
    tools = createGraphics(1000,50);
    
    scrIcon = loadImage("pic\\fastscroll.png");
    background(20);
    
    drawGraph();
  }

  void Display() {
  
    //println(scrollY, scrollX);
    //if(press) refresh();
    //showTime();
    
    image(layer, 0+scrollX, 0+scrollY);
    Move();
    button.Display();
    showTime();
    
  }

  void Move() {
    if (!mousePressed){ lockedx = mouseX; lockedy = mouseY;}
    
    if (mousePressed && mouseButton==LEFT) {
      scrollX += mouseX-lockedx;
      scrollY += mouseY-lockedy;
      lockedx = mouseX;
      lockedy = mouseY;
      
      
      if(scrollX< -idx*zoomk+800) scrollX = -idx*zoomk+800;
      if(scrollX>0) scrollX=0;
      if(scrollY< -(500*zoomk-500)) scrollY = -500*zoomk+500;
      if(scrollY>500*zoomk-1000) scrollY=0;
      //refresh();
    }
    
    if(mousePressed && mouseButton==CENTER){
      scrollX -= (mouseX-lockedx)/7;
      scrollY += (mouseY-lockedy)/7;
      //lockedx = mouseX;
      //lockedy = mouseY;
      if(mouseX<=idx*zoomk+160){
      image(scrIcon, mouseX-40, mouseY-50);
      }

      
      
      if(scrollX< -idx*zoomk+800) scrollX = -idx*zoomk+800;
      if(scrollX>0) scrollX=0;
      if(scrollY< -(500*zoomk-500)) scrollY = -500*zoomk+500;
      if(scrollY>500*zoomk-1000) scrollY=0;
      if(zoomk<=1) scrollY=0;
    }
    //background(20);
  }
  
  void showTime(){
    if(mousePressed && mouseButton==RIGHT && -scrollX+mouseX<idx*zoomk && -scrollX+mouseX>0){
      int x = int(-scrollX+mouseX);
      //println(x);
      press=true;
      Time.beginDraw();
      Time.background(255);
      //Time.noStroke();
      Time.fill(255);
      Time.stroke(180);
      Time.strokeWeight(6);
      Time.rect(0,0,100,40);
      Time.fill(0);
      Time.textAlign(CENTER);
      Time.textSize(20);
      s = float(read.getInt(int(x/zoomk),1))/1000;
      Time.text(s,50,30);
      //press=true;
      Time.endDraw();
      image(Time,460,20);
     
    }
    else{
      press=false;
    }
}

void Scroll(float e){
  if(e<0){
  
    if(zoomk<2){
      mouseCentr = -scrollX/zoomk+mouseX;
      zoomk+=1;
      scrollX = (mouseCentr*zoomk-mouseX)*(-1) ;
      scrollY=-250;
      layer = createGraphics(int((idx*zoomk+200)), int(500*zoomk));
      drawGraph();
    }
    
  }
  if(e>0){
    if(zoomk>1){
      
      mouseCentr = -scrollX+mouseX;
      scrollX= (mouseCentr/zoomk-mouseX)*(-1);
      zoomk-=1;
      scrollY = -250;
      
   
      layer = createGraphics(int((idx*zoomk+200)), int(500*zoomk));
      drawGraph();
    }
  }
  
}

void drawGraph(){
      background(20);
      if(scrollX< -idx*zoomk+800) scrollX = -idx*zoomk+800;
      if(scrollX>0) scrollX=0;
      if(scrollY< -(500*zoomk-500)) scrollY = -500*zoomk+500;
      if(scrollY>500*zoomk-1000) scrollY=0;
      layer.beginDraw();
      layer.background(20);
      layer.stroke(100, 100, 0);
      layer.strokeWeight(2);

      for (int i=0; i<idx-1; i+=1) {
        float y = read.getInt(i, 0);
        float y1 = read.getInt(i+1, 0);
        layer.line(i*zoomk, 250*zoomk-y*zoomk, (i+1)*zoomk, 250*zoomk-y1*zoomk);
      }
      
      layer.endDraw();
}

void refresh(){
      layer.beginDraw();
      layer.background(20);
      layer.stroke(100, 100, 0);
      layer.strokeWeight(2);
      
      for (int i=-scrollX/zoomk; i<-scrollX/zoomk+1000 && i<idx-1; i+=1) {
        float y = read.getInt(i, 0);
        float y1 = read.getInt(i+1, 0);
        layer.line(i*zoomk, 250*zoomk-y*zoomk, (i+1)*zoomk, 250*zoomk-y1*zoomk);
      }
      
      layer.endDraw();
}

void Toolbar(){
  tools.beginDraw();
  tools.background(0);
  if(press){
    tools.fill(240);
    tools.stroke(0,200,180);
    tools.strokeWeight(2);
    tools.rect(500,20,100,60);
    tools.textSize(20);
    tools.fill(0);
    tools.textMode(CENTER);
    tools.text(s,550,60);
  }
  tools.endDraw();
  image(tools,0,0);
}

  
   
  
}