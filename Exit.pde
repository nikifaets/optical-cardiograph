void Exit(){
  
  graph.setNull();
  archives.clearArchives();
  if(Connected){
  port.clear();
  port.write(50);
  Connected = false;
  }
  exit();
}
  