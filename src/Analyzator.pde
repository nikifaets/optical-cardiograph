class Analyzator{
  
  int bestRate = 0;
  int data[];
  
  void setRate(int currRate, Table tab){
    bestRate = currRate;
    int size = tab.getRowCount();
    data = new int[size];
    for(int i=0; i<size; i++){
      data[i] = tab.getInt(i,0);
  }
  }

  
}