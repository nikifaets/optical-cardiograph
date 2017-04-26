

class Graphics{
  
  Table write;
  Table writePulse;
  Table objtable = loadTable("data\\folders.csv");
  PGraphics zoomIMG = createGraphics (15,100);
  
  PImage saveIcon = loadImage("pic\\saveIcon.png");
  
  IntList val = new IntList();
  IntList time = new IntList();
  IntList hit = new IntList();
 
  
  float prevy=0, prevx = 0, y1=0;
  int maxprevy=1;
  float Scroll = 40;
  float prevScroll = 40;
  boolean pause = false;
  boolean zmd = false;
  boolean symb = true;
  float upPoint;
  float downPoint;
  float zoomk = 1,zoomy = -0.6; 
  float middleHit[] = new float[15];
  int HeartBeats[] = new int [5];
  int zoomCount = 0;
  int MidPointSum=0;
  int MidPointCount=0;
  
  int heartr = 0;
  int heartrCurr = 0;
  int HeartBeatsCount = 0;
  int HeartBeatsSumm=0;
  
  int RecMillis = 0;
  int BMillis = 0;
  float i=0;
  int oldData=0;
  int data=0;
  
  boolean saved = false;
  
  
  void setGraphics(){
    
    port.clear();
    for(int k = 0; k<15; k++){
    middleHit[k] = 0;    
  }
    background(20);
 
    i=0;
    pause = false;
    zoomy = -0.6;
    zoomk = 1;
    HeartBeatsCount = 0;
    HeartBeatsSumm=0;
    BMillis = 0;
    RecMillis=0;
    heartr=0;
    saved = false;
    
    
    
  }
  
  void drawGraphics(){
   
    if(port.available()>0){
          
          data = port.read();
          //println(data);
          if(data==255){ 
            data=0;  
            oldData=0;
      
          }
          
          else{
          data+=oldData-128;
          oldData=data;
          
          }
          BMillis+=17;
          println(data);

   }
   else{
     println("00000000000000000");
   }
   
    if(!pause){
    
    
      
    Clear();
    if(i%(2*zoomk)==0)
    Coord();
    dataHandle();
    zoomScr();
    Text();
   
    i+=zoomk;

    if(i>=1000){
     
        i = 0;
      }
    }
    menuBar();
    //button.Display();

    if(((mouseX>917 || mouseX <900) && (mouseY<80 || mouseY>110) ) && ((mouseX<=160 && mouseY>=50 ) || (mouseX>=160 && mouseY>=0))){
      if(mousePressed && !mouseDragged && pause ) {pause = false; port.clear(); port.write(20); delay(200);}
      else if(mousePressed && !mouseDragged && !pause ){ pause = true; port.clear(); port.write(21); delay(200); }
    }
    
   
  }
  
  void dataHandle(){
    
    
    y1 = data;
    float x1 = i+zoomk;
    prevx = i;
    
    if(abs(zoomy*y1)>maxprevy) maxprevy=(int)abs(zoomy*y1);
    
    zoomCount++;
    if(zoomCount>=90){
      if(maxprevy<100&&maxprevy>2) zoomy/=0.7;
      if(maxprevy>220) zoomy*=0.7;
      zoomCount=0;
      maxprevy=1;
    }
     
   /* prevx*=10*zoomk;
    x1*=10*zoomk;*/
    
    
   if(symb==true && prevy-y1<0){
     stroke(0,0,255);
     strokeWeight(5);
     //point(prevx,250-prevy*zoomy);
     upPoint=prevy;
     symb=false;
   }
   if(symb==false && prevy-y1>0){
     stroke(0,0,255);
     strokeWeight(5);
     //point(prevx,250-prevy*zoomy);
     downPoint=prevy;
     stroke(0,255,0);
     //point(prevx,250-(downPoint-upPoint)*zoomy/3);
     
     
     MidPointSum-=middleHit[MidPointCount];
     middleHit[MidPointCount]=downPoint-upPoint;
     MidPointSum+=middleHit[MidPointCount];
     
     MidPointCount++;
     if(MidPointCount>=15){ MidPointCount=0;}
     
     
     if(downPoint-upPoint>1.4*(MidPointSum/15) && BMillis-RecMillis>350){
       int Millis = BMillis;
       
       //println("pulse");
       HeartBeatsSumm-=HeartBeats[HeartBeatsCount];
       HeartBeats[HeartBeatsCount] = Millis-RecMillis;
       HeartBeatsSumm+=HeartBeats[HeartBeatsCount];
       RecMillis = Millis;
       HeartBeatsCount++;
       
     if(HeartBeatsCount>=4){
       heartr= (4*60*1000)/(HeartBeatsSumm);
       HeartBeatsCount=0;
     }
     
     if(HeartBeats[HeartBeatsCount]!=0)
     heartrCurr = 60000/HeartBeats[HeartBeatsCount];
     
     hit.append(BMillis);

     }

     stroke(255,0,0);
    // point(prevx,250-1.4*(MidPointSum/15)*zoomy/3);
     symb=true;
   }
    
    
    stroke(100,100,0);
    strokeWeight(2);
     line(prevx,250-zoomy*prevy,x1,250-zoomy*y1);
     val.append(int(zoomy*y1));
     time.append(int(BMillis));
    //point(prevx, 250-zoomy*prevy);
    strokeWeight(1);
    
    prevy = y1;
  }
  
  void zoomScr(){
  
    zoomIMG.beginDraw();
    zoomIMG.background(100);
    zoomIMG.fill(220);
   
    zoomIMG.rect(0,Scroll,17,17);
    zoomIMG.endDraw();
    image(zoomIMG, 900,80);
    
    if((mouseX<=920 && mouseX >=900)&&  mousePressed){
      
      Scroll = mouseY-88;
      if(mouseY>165) Scroll = 85;
      if(mouseY<72) Scroll = 9;
      
  }
  
  
   if(prevScroll != Scroll && !mousePressed ){
     if(Scroll>=78){zoomk = 0.1;}
      else if(Scroll >= 63){ zoomk = 0.3;}
      else if(Scroll >= 48){ zoomk = 0.7;}
      else if(Scroll >= 33){ zoomk = 1;}
      else if(Scroll >= 18){ zoomk = 2;}
      else if(Scroll <18){ zoomk = 4; }
    
      prevScroll = Scroll;
      i = 1000;
      
      zmd = true;
   }
  }
  
  void Clear(){
  
    fill(20);
    noStroke();
    rect((i+zoomk),0,30, 500);
  
  }
  
  void Coord(){
    stroke(100);
    strokeWeight(1);
    for(float x = 0; x<=1000; x+=10){
      for(float y = 0; y<=500; y+=50){
        point(x,y);
      }
    }
    for(float x = 0; x<=1000; x+=50){
      for(float y = 0; y<=500; y+=10){
        point(x,y);
      }
    }
  
  }
  
  void Text(){
    fill(20);
    noStroke();
    rect(350,10,250,60);
    fill(255);
    textSize(15);
    text("Pulse:", 410,50);
    textSize(35);
    text(heartr, 470,45);
    textSize(20);
    fill(190);
    text(heartrCurr,550,45);
  }
  
  void Scroll(float e){
    if(e>0){Scroll+=15; i = 100;}
      else{Scroll-=15; i = 100;}
      if(Scroll>85) Scroll = 85;
      if(Scroll<0) Scroll = 0;
      zmd = true;
  }
  
void Write(){
  
  TableRow newrow = objtable.addRow();
  String name = Date("name");
  String path = Date("path");
  newrow.setString(1, name);
  newrow.setString(0, path);
  
  //println(files);
  saveTable(objtable, "data\\folders.csv");
  write = new Table();
  write.addColumn();
  write.addColumn();
 
  
  for(int idx = 0; idx<val.size(); idx++){
   TableRow row = write.addRow();
   
    row.setInt(0,val.get(idx));
    row.setInt(1,time.get(idx));
  
  }
  saveTable(write,"data\\"+path+"\\measures.csv");
  
  writePulse = new Table();
  writePulse.addColumn();
  for(int idx = 0; idx<hit.size(); idx++){
    TableRow row = writePulse.addRow();
    
    row.setInt(0, hit.get(idx));
  }
  saveTable(writePulse, "data\\"+path+"\\hits.csv");
    
  saved = true;
  
}

 void Save(){
 if(mouseX>=70 && mouseX<=150 && mouseY >=0 && mouseY <=50){
   fill(20);
   strokeWeight(2);
   stroke(200);
   rect(90,10,50,45);
   if(mousePressed && mouseButton==LEFT){
    Write();
    delay(200);
     
   }
 }
 else{
   noStroke();
   fill(20);
   rect(88,10,54,50);
 }
 
 
 image(saveIcon, 100,20);
 }

void menuBar(){
  fill(20);
  noStroke();
  rect(0,0,160,70);
  button.Display();
  Save();
  
}
  
  

void setNull(){
  for(int idx = 0; idx<5; idx++){
    HeartBeats[idx]=0;
  }
  for(int idx = 0; idx<15; idx++){
    middleHit[idx]=0;
  }
  val.clear();
  time.clear();
  data=0;
  RecMillis=0;
  BMillis=0;
  //Connected = false;
  port.write(50);
}
}