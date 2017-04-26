class drawBG {
    boolean animRdy=false;
    int xpos = 0;
    float [][] pointBig =  { {350, 250}, {420, 250}, {450, 250}, {500, 250}, {520, 250}, {560, 250}, {565, 235}, {575, 260}, {585, 250}, {650, 250} };
    float [][] pointSmall = { {400,30},{445,30},{465,30},{500,30},{515,30},{555,30},{565,35},{570,60},{575,30},{600,30}};
    int lastBeat=0;
    void showBig(){

    if ((millis()-lastBeat)>=3500) {


      int symb = int(random(1, 3));
      if (symb==1) {
        pointBig[2][1] = 250+int(random(60, 200));
        pointBig[3][1] = 250-int(random(60, 200));
      } else {
        pointBig[3][1] = 250+int(random(60, 200));
        pointBig[2][1] = 250-int(random(60, 200));
      }

    

      lastBeat = millis();
    }

    if (millis()-lastBeat<1500) {

      if (abs(pointBig[2][1]-250)>0) {
        float step = abs((pointBig[2][1]-250))/35;
        if (pointBig[2][1]>250) {

          pointBig[2][1]-=step;
        } else if (pointBig[2][1]<250) {
          pointBig[2][1]+=step;
        }
      }

      if (abs(pointBig[3][1]-250)>0) {
        float step = abs(pointBig[3][1]-250)/35;
        if (pointBig[3][1]>250) {
          pointBig[3][1]-=step;
        } else if (pointBig[3][1]<250) {
          pointBig[3][1]+=step;
        }
      }
    } 
    else {
      pointBig[2][1]=250;
      pointBig[3][1]=250;
    }



    int symb = int(random(1, 3));
    if (symb==1) {
      pointBig[6][1] = 250-int(random(2, 10));
      pointBig[7][1] = 250+int(random(2, 10));
    } 
    else {
      pointBig[6][1] = 250+int(random(2, 10));
      pointBig[7][1] = 250-int(random(2, 10));
    }
    for (int i=0; i<9; i++) {
      strokeWeight(3);
      stroke(100, 100, 0);
      line(pointBig[i][0], pointBig[i][1], pointBig[i+1][0], pointBig[i+1][1]);
    }
  }
  
  void showSmall(){

    if ((millis()-lastBeat)>=3500) {


      int symb = int(random(1, 3));
      if (symb==1) {
        pointSmall[2][1] = 30+int(random(10, 30));
        pointSmall[3][1] = 30-int(random(10, 30));
      } else {
        pointSmall[3][1] = 30+int(random(10, 30));
        pointSmall[2][1] = 30-int(random(10, 30));
      }

    

      lastBeat = millis();
    }

    if (millis()-lastBeat<1500) {

      if (abs(pointSmall[2][1]-30)>0) {
        float step = abs((pointSmall[2][1]-30))/35;
        if (pointSmall[2][1]>30) {

          pointSmall[2][1]-=step;
        } else if (pointSmall[2][1]<30) {
          pointSmall[2][1]+=step;
        }
      }

      if (abs(pointSmall[3][1]-30)>0) {
        float step = abs(pointSmall[3][1]-30)/35;
        if (pointSmall[3][1]>30) {
          pointSmall[3][1]-=step;
        } else if (pointSmall[3][1]<30) {
          pointSmall[3][1]+=step;
        }
      }
    } 
    else {
      pointSmall[2][1]=30;
      pointSmall[3][1]=30;
    }



    int symb = int(random(1, 3));
    if (symb==1) {
      pointSmall[6][1] = 30-int(random(1, 5));
      pointSmall[7][1] = 30+int(random(1, 5));
    } 
    else {
      pointSmall[6][1] = 30+int(random(1, 5));
      pointSmall[7][1] = 30-int(random(1, 5));
    }
    for (int i=0; i<9; i++) {
      strokeWeight(2);
      stroke(100, 100, 0);
      line(pointSmall[i][0], pointSmall[i][1], pointSmall[i+1][0], pointSmall[i+1][1]);
    }
  }
}
  