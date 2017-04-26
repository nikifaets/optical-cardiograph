String Date(String point ){
  int y = year();
  int d = day();
  int m = month();
  int h = hour();
  int min = minute();
  int sec = second();
  if(point.equals("name")){
  return str(y)+"/"+str(d)+"/"+str(m)+"/"+str(h)+":"+str(min);
  }
  return  str(y)+str(d)+str(m)+str(h)+str(min)+str(sec);
}