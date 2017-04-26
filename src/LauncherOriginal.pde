import processing.serial.*;
import java.io.File;

Serial port;
Graphics graph;
masterUI master;
archivesMenu archives;
Menu menu;
Notifications notif;
goBack button;
Inspect inspect;
drawBG backG;
Settings settings;
measureMenu measureMenu;
Histogramm histogram;

final int menuPG = 1, graphicsPG = 2, archivesMenuPG = 3, archivesSelectPG = 4, measureInspectPG = 5, histogrammPG = 6,
settingsPG = 7;

int pageNm=1;
boolean pgChanged = true;
boolean notify = false;
boolean Connected = false;
boolean mouseDragged = false;
boolean mouseReleased = false;

ArrayList <Serial> ports;


void setup(){
  graph = new Graphics();
  //printArray(Serial.list());
  master = new masterUI();
  menu = new Menu();
  archives = new archivesMenu();
  notif = new Notifications();
  button = new goBack();
  inspect = new Inspect();
  backG = new drawBG();
  settings = new Settings();
  measureMenu = new measureMenu();
  histogram = new Histogramm();
  
  ports = new ArrayList();
  String[] list = Serial.list();
  int listSize = list.length;
  for(int i=0; i<listSize; i++){
    Serial temp = new Serial(this,Serial.list()[i], 9600);
    ports.add(temp);
  }
  
 
  size(1000,500);
  background(20);
 
  
}

void draw(){
 
  //println(Connected);
  if(!pgChanged){
    changePage();
  }

 if(notify){
   notif.Display();
 }
   
 else if(!notify && pgChanged) {
  if(pageNm==menuPG){
    menu.showMenu();
}
  if(pageNm == graphicsPG){
    graph.drawGraphics();
  }
  
  if(pageNm == archivesMenuPG){
    archives.drawArchives();
    //println("drawwa");
  }
  
  if(pageNm == archivesSelectPG){
    measureMenu.Display();
  }
  
  if(pageNm == measureInspectPG){
    inspect.Display();
  }
  
  if(pageNm == histogrammPG){
    histogram.Display();
  }
  
  if(pageNm == settingsPG){
    settings.Display();
  }
  }
}

void mouseWheel(MouseEvent event){
  float e = event.getCount();
  if(pageNm == archivesMenuPG){
    archives.Scroll(e);
  }
  if(pageNm == graphicsPG){
    graph.Scroll(e);
  }
  
  if(pageNm == measureInspectPG){
    inspect.Scroll(e);
  }
}

void mouseDragged(){
  mouseDragged = true;
}
void mouseReleased(){
  mouseDragged = false;
  mouseReleased = true;
}

void mousePressed(){
  mouseReleased = false;
}