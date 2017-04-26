class Histogramm{
  

  ArrayList <bin> bins = new ArrayList();
  
  
  int max = 0, min = 132123;
  int hits[];
  int size;
  int zero = 440;
  boolean imp = false;
  int avgRate;
  int time;
  
  

  void setHistogramm (String path, boolean create){
    Table table = loadTable(path+"\\hits.csv");
    max = 0;
    min = 123123;
    avgRate = 0;
    time = 0;
    histogramm(table, create);
    time = getTime(path);
    
    measureMenu.setPar(time, avgRate);
   // println(avgRate, time);
      
    
    background(20);
  }
  
  void Display(){

    
    background(20);
    
    if(imp){
      showMessage();
    }
    else{
    drawCord();
    for(int i=0; i<bins.size(); i++){
     
      bins.get(i).Display();
    }
    }
    button.Display();
    
  }
  
  
  void drawCord(){
    stroke(255);
    strokeWeight(1);
    fill(255);
    line(35,460, 35,50);
    textSize(10);
    textAlign(LEFT);
    text(10, 20,zero-100);
    text(20,20,zero-200);
    text(30,20,zero-300);
    text(0,20,zero);
    
   
    
    textAlign(CENTER);
    textSize(14);
    
    line(35,460, 950, 460);
    text(min, 50 ,480);
    text((min+max)/2 , 500, 480);
    text(max, 950, 480);
  }
  
  void closehistogramm(){
    bins.clear();
  }
  void histogramm(Table table, boolean create){
  
  
 
    size = table. getRowCount();
    
    
    if(size<10){
      imp = true;
    }
    else{
      imp = false;
    
      hits  = new int[size];
    
    for(int i=1; i<size; i++){
      int curr = table.getInt(i,0);
      int prev = table.getInt(i-1,0);
      
      int hBeat = 60000/(curr-prev);
       hits[i-1] = hBeat;
       if(hBeat < min){
         min = hBeat;
       }
       if(hBeat>max){
         max = hBeat;
       }
       
    }
    
    final int binsNum = (max-min)/4+1;
   
    //printArray(hits);
    //println("max: ", max, "min: ", min);
   // println("binsNum: ", binsNum);
    
    
    int datas[] = new int[binsNum];
    for(int i=0; i<binsNum; i++){
      datas[i] = 0;
    }
    
    int biggest = 0;
    
    for(int i=0; i<size; i++){
      int curr = hits[i];
  
      int idx = (curr-min)/4;
     
     //println("curr: ", i, curr, min);
     if(idx>0){
      datas[idx]++;
      if(datas[idx]>biggest){
        biggest = datas[idx];
        avgRate = min+idx*4;
      }
     }
      
    }

   if(create == true){
       int unitX = 900/binsNum;
       float unitY = float(300000)/biggest;
       unitY/=1000;
     
       //println(size, unitY, float(300/53));
       
      
      for(int i=0; i<binsNum; i++){
        bin currbin = new bin();
        
        int x = i*unitX;
        float y = zero-datas[i]*unitY-2*unitY;
        //println(y, datas[i]);
        
        int endY = int(zero-y);
        currbin.create(50+x,y, unitX, endY, min+i*4, datas[i]);
        bins.add(currbin);
    }
   }
    
  
  }

}

void showMessage(){
  textSize(45);
  textAlign(CENTER);
  fill(240);
  text("Measure too short to make a histogram ;(" , 500,250);
}

int getTime(String path){
  
  Table tab = loadTable("data\\"+path+"\\measures.csv");
  int size = tab.getRowCount();
  return tab.getInt(size-1,1);
  
}

int getRame(){
  return avgRate;
}
}