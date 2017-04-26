class Settings{
  
  PImage perm = loadImage("pic\\iconperm.png");
  PImage mirror = loadImage("pic\\iconmirror.png");
  
  void Display(){
    background(20);
    showImage(mirror, 100,75);
    showImage(perm,300,75);
    button.Display();
  }
  
  
  void showImage(PImage img, int x,int y){
    if(mouseX>=x && mouseX <=x+150 && mouseY>=y && mouseY<=y+150){
      stroke(100,100,0);
      if(mousePressed && !mouseDragged && mouseButton==LEFT){
        if(img==perm){
          delay(200);
          port.write(25);
          
        }
        if(img==mirror){
          delay(200);
          port.write(26);
        }
      }
          
    }
    else{
      noStroke();
    }
    
    fill(20);
    rect(x,y,150,150);
    image(img,x,y);
  }
}
    