class masterUI{

  
  void changePage(int pgNm){
    
    if(pageNm == graphicsPG) {graph.setNull(); println("null");}
    
    
    
    if(pgNm == graphicsPG){
      if(Connected == false) Connect();
      if(Connected == true){
        port.clear();
        port.write(13);
        pageNm = graphicsPG;
        CPsquareSize=0;
        pgChanged=false;
      }
      else{
        pageNm = menuPG;
        notify = true;
        notif.getNotif("serialNotFound");
      }
    }
    
    if(pgNm==settingsPG){
      if(Connected == false) Connect();
      if(Connected == true){
        port.write(50);
        pageNm = settingsPG;
        CPsquareSize=0;
        pgChanged=false;
      }
      else{
        pageNm = menuPG;
        notify = true;
        notif.getNotif("serialNotFound");
      }
    }
    
    else if(pgNm!=settingsPG && pgNm!=graphicsPG){
    pageNm = pgNm;
    CPsquareSize=0;
    pgChanged = false;
    }
  }
  
  void changePage(int pgNm, String a){
    
    if(pgNm == archivesSelectPG){
      inspect.setInspect(a);
      histogram.setHistogramm(a, false);
      measureMenu.setMenu(a);
    }
    /*if(pgNm == measureInspectPG){
      inspect.setInspect(a);
    }*/
    
    if(pgNm == histogrammPG){
      histogram.setHistogramm(a, true);
    }
    
    delay(200);
    pageNm = pgNm;
    CPsquareSize = 0;
    pgChanged = false;
}
}