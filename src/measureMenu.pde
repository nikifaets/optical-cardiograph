class measureMenu{
 
  PImage heartrate;
  PImage histogramm;
  PImage heart;
  String inspect;
  String histogram;
  String fullpath;
  String name;
  int rate;
  int timeLen;
  int w = 700;
  int h = 100;
  
  
  
  void setMenu(String path){
    
    
    background(20);
    fullpath = path;
    inspect = path+"\\measures.csv";
    histogram = path+"\\hits.csv";
    heartrate = loadImage("pic\\heartrate.png");
    histogramm = loadImage("pic\\histogram.png");
    heart  = loadImage("pic\\hearticon.png");
    Table tab = loadTable("data\\folders.csv");
    int size = tab.getRowCount();
    for(int i=1; i<size; i++){
      if(tab.getInt(i,0)==int(path)){
        name = tab.getString(i,1);
        break;
      }
    }
    
    
    
    
  }
  
  void Display(){
    
    background(20);
    
   menu(100, 100, 5, "Review Measure", heartrate);
   menu(100,230,6, "Histogramm", histogramm);
   button.Display();
   displayChar();
  }
  
  
  void menu(int x, int y, int pg, String name, PImage pic){
    
    boolean mouseOver = false;
    
    if(mouseX<=x+w && mouseX >= x && mouseY <= y+h && mouseY >=y){
      mouseOver = true;
    }
    
    noStroke();
    
    if(!mouseOver) fill(200);
    if(mouseOver)  fill(150);
    
    rect(x,y,w,h);
    textSize(30);
    textAlign(LEFT);
    fill(0);
    text(name, x+20, (y+y+h)/2);
    image(pic, x+w-70, y+(h-50)/2);
    
    
    if(mouseOver && mousePressed && mouseButton == LEFT && !mouseDragged){
      master.changePage(pg, fullpath);
    }
  }
  
  void displayChar(){
    
    String time = time();
    textSize(20);
    fill(210);
    textAlign(LEFT);
    text("Measure from: ", 200, 30);
    text("Length:", 440, 30);
    text("Average heart rate", 600,30);
    
    fill(255);
    text(name, 200,60);
    text(time, 440,60);
    text(rate, 600,60);
    image(heart, 630,40);
    
    
    
   
  }
  
  void setPar(int len, int pulse){
    timeLen = len;
    rate = pulse;
  }
  
  String time(){
    
    int milSec = timeLen%1000;
    int t = timeLen/1000;
    if(milSec >= 500){
      t++;
    }
    
    int  s = 0;
    s = t%60;
    String len = s+"s";
    
    if(t/60>0){
      len = (t/60)%60+"m"+" "+len;
    }
    
    if(t/3600>0){
      len = t/3600+"h"+" "+len;
    }
    
    return len;
  }
    
      

}