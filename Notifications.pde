class Notifications{

  PImage notConnected = loadImage("pic\\notConnectedNotif.png");
  int x = 1000/2-200;
  int y = 500/2-100;
  int xlength = 400;
  int ylength = 150;
  int notifID=0;
  
  
  void Display(){
     //println(notifID);
  
      if(notifID==1 ){
        AskIfSave();
      }
      if(notifID==2){
        serialNotFound();
      }
      if(!notify){
        background(20);
      }
  }
    
  void AskIfSave(){
    fill(255);
    noStroke();
    rect(x,y,xlength, ylength);
 
    onClick(x+50,1);
    onClick(x+150,2);
    onClick(x+250,3);
    fill(0);
    textSize(15);
    textAlign(CENTER);
    text("Do you want to save your measures before leaving?",x+xlength/2,y+25);
    textSize(15);
   // textAlign(LEFT);
    text("Yes", x+100, y+135);
    //textAlign(CENTER);
    text("No", x+200,y+135);
    //textAlign(RIGHT);
    text("Cancel",x+300,y+135);
  
  }
  
  void onClick(int x, int BtNm){
    
    if(notifID == 1){
    
      if(mouseX>=x && mouseX <=x+100 && mouseY>=y+115 && mouseY <= y+135){
        fill(190);
        rect(x,y+115, 100,30);
        if(mousePressed && !mouseDragged){
          if(BtNm==1){
            delay(100);
            graph.Write();
            notify=false;
            master.changePage(1);
          }
          if(BtNm==2){
            delay(100);
            notify=false;
            master.changePage(1);
          }
          if(BtNm==3){
            notify=false;
            delay(100);
            background(20);
            notifID=0;
            graph.setGraphics();
          }
          
          
       }
    }
   }
   
   if(notifID == 2){
     if(mouseX>=300 && mouseX<=700 && mouseY>=260 && mouseY<=290){
       fill(190);
       noStroke();
       rect(300,260,400,30);
       if(mousePressed) {         
         notify = false;
         delay(200);
       }
       
     }
   }

      
}

  void serialNotFound(){
    image(notConnected,300,150);
    onClick(490,1);
    fill(0);
    textSize(18);
    text("OK",495,280);
  }
    
    

void getNotif(String notif){
  notify=true;
  if(notif.equals("AskIfSave")){
    notifID=1;
  }
  if(notif.equals("serialNotFound")){
    notifID=2;
  }
    
}
}