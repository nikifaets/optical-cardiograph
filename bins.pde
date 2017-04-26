
class bin{
  int len, h,x;
  float y;
  int r = 116,g = 108,b = 153;
  color col = color(r,g,b);
  int data;
  int amount;
  
  void create(int a, float b, int c, int d, int e, int amnt ){
    
    x = a;
    y = b;
    len = c;
    h = d;
    data = e;
    amount = amnt;

  }
  
  void showData(){
    fill(255);
    textSize(10);
    textAlign(CENTER);
    text(data, x+len/2, y+h+10);
    fill(255);
    textSize(10);
    textAlign(CENTER);
    text(amount, x+len/2, y-5);

  }
  
  void Display(){
    

    color colCurr = col;
    noStroke();
    
    if(mouseOver()){
      colCurr = color(r-20, g-20, b-20);
    }
   
    stroke(0);
    fill(colCurr);
    rect(x,y,len,h);
    if(mouseOver()){
      showData();
    }
 ;
    
  }
  
 
    
  boolean mouseOver(){
    if(mouseX <= x+len && mouseX >= x) return true;
    
    return false;
}
}
   
  
 