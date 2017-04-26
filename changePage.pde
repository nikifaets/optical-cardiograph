int CPsquareSize=0;

void changePage(){
  background(0);
   if(CPsquareSize<=500){
     fill(20);
     noStroke();
     rect(500-CPsquareSize, 250-CPsquareSize/2, CPsquareSize*2, CPsquareSize);
     CPsquareSize+=40;
     delay(3);
     
   }
   else{
      CPsquareSize=0;
      pgChanged = true;
      if(pageNm == menuPG){
        menu.setMenu();
      }
      if(pageNm == graphicsPG){
        
          graph.setGraphics();
        }   
      
      if(pageNm == archivesMenuPG){
        println("seeeeeet");
        archives.setArchives();
      }

      
   }
}
   