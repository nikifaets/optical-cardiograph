

boolean Connect(){
  String Coms[] = Serial.list();
  for(int i=0; i<Coms.length; i++){
    Serial temp = ports.get(i);
    if(temp.available()>0){
      if(temp.read()==150){
        delay(17);
        port = temp;
        port.clear();
        port.write(13);
        //port.clear();
        
        
        Connected = true;
        
        return true;
      }
    }
  }
 Connected = false;
 return false;
}
    