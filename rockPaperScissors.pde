ArrayList<Element> element = new ArrayList<Element>();
int rockTotal = 0;
int paperTotal = 0;
int scissorsTotal = 0;
boolean gameOver = true;
Button reset = new Button ("Start", width * 12.5, 10, 325, 160, color(139, 119, 18), false);
Button[] counters; 

PImage rockImg;
PImage paperImg;
PImage scissorsImg;
void setup(){
  size(1600, 1200);
  counters = new Button[6]; 
  counters[0] = new Button("addSign.png", width/2+200, 0, 100, 75, color(255), true);
  counters[1] = new Button("subtractSign.png", width/2-200, 0, 100, 75, color(255), true);
  counters[2] = new Button("addSign.png", width/2+200, 100, 100, 75, color(255), true);
  counters[3] = new Button("subtractSign.png", width/2-200, 100, 100, 75, color(255), true);
  counters[4] = new Button("addSign.png", width/2+200, 200, 100, 75, color(255), true);
  counters[5] = new Button("subtractSign.png", width/2-200, 200, 100, 75, color(255), true);
  rockImg = loadImage("images/rock.png");
  paperImg = loadImage("images/paper.png");
  scissorsImg = loadImage("images/scissors.png");
}

void draw(){
  background(255);
  drawTop();
  reset.display();
  if(element.size() == 0)return;
  
  runCollisions();
  
  runRockPaperScissors(gameOver);
  
}

void mousePressed(){
  if(reset.clicked() && gameOver && reset.label == "Start"){
    gameOver = false;    
    reset.clr = color(139, 119, 18);
    reset.label = "Game Active";
  }
  
  if(counters[0].clicked()){
    rockTotal++;
    element.add(new Element(randomizeValue("x"), randomizeValue("y"), randomizeValue("vel"), randomizeValue("vel"), "rock"));
    return;
  }
  if(counters[1].clicked()){
    if(rockTotal == 0) return;
    rockTotal--;
    for(int i = element.size() - 1; i > 0; i--){
      if(element.get(i).name == "rock"){
        element.remove(i);
        return;
      }
    }
  }
  if(counters[2].clicked()){
    paperTotal++;
    element.add(new Element(randomizeValue("x"), randomizeValue("y"), randomizeValue("vel"), randomizeValue("vel"), "paper"));
    return;
  }
  if(counters[3].clicked()){
    if(paperTotal == 0) return;
    paperTotal--;
    for(int i = element.size() - 1; i > 0; i--){
      if(element.get(i).name == "paper"){
        element.remove(i);
        return;
      }
    }
  }
  if(counters[4].clicked()){
    scissorsTotal++;
    element.add(new Element(randomizeValue("x"), randomizeValue("y"), randomizeValue("vel"), randomizeValue("vel"), "scissors"));
    return;
  }
  if(counters[5].clicked()){
    if(scissorsTotal == 0) return;
    scissorsTotal--;
    for(int i = element.size() - 1; i > 0; i--){
      if(element.get(i).name == "scissors"){
        element.remove(i);
        return;
      }
    }
  }
}

void runRockPaperScissors(boolean gameEnded){
  if(!gameEnded){
      for(int i = 0; i < element.size(); i++){
        element.get(i).bounce();
        element.get(i).move(); 
      }
  } 
  else if(gameEnded && element.size() >=3){
    if (paperTotal <=0 && scissorsTotal <= 0){
      displayEndGameText("Rock");  
    } 
    else if (rockTotal <=0 && scissorsTotal <= 0){
      displayEndGameText("Paper");  
    } 
    else if (paperTotal <=0 && rockTotal <= 0){
      displayEndGameText("Scissors");  
    }
    reset.clr = color(185, 135, 34); 
    reset.label = "Start";
  }
  
  for(int i = 0; i < element.size(); i++){
    element.get(i).display();
  }
}

void runCollisions(){
  if(gameOver) return;
  Element element1;
  Element element2;
  for(int x = 0; x < element.size(); x++){
    for(int y = 0; y < element.size(); y++){
      if(x == y){
        continue; 
      }
      if(collided(element.get(x).x, element.get(x).y, element.get(y).x, element.get(y).y)){
        element1 = element.get(x);
        element2 = element.get(y);
        if(element1.name == element2.name){
          continue; 
        }
        if(element1.name == "rock" && element2.name == "paper"){
          element.get(x).name = "paper";
          element.get(x).img = null;
          paperTotal++;
          rockTotal--;
          continue;
        }
        if(element1.name == "paper" && element2.name == "rock"){
          element.get(y).name = "paper";
          element.get(y).img = null;
          paperTotal++;
          rockTotal--;
          continue;
        }
        if(element1.name == "rock" && element2.name == "scissors"){
          element.get(y).name = "rock";
          element.get(y).img = null;
          rockTotal++;
          scissorsTotal--;
          continue;
        }
        if(element1.name == "scissors" && element2.name == "rock"){
          element.get(x).name = "rock";
          element.get(x).img = null;
          rockTotal++;
          scissorsTotal--;
          continue;
        }
        if(element1.name == "scissors" && element2.name == "paper"){
          element.get(y).name = "scissors";
          element.get(y).img = null;
          scissorsTotal++;
          paperTotal--;
          continue;
        }
        if(element1.name == "paper" && element2.name == "scissors"){
          element.get(x).name = "scissors";
          element.get(x).img = null;
          scissorsTotal++;
          paperTotal--;
          continue;
        }
      }
    }
  }
  gameOver = checkGameOver();
}

void drawTop(){
  fill(148);
  strokeWeight(0);
  rect(width/2, 0, 100, 75);
  rect(width/2, 100, 100, 75);
  rect(width/2, 200, 100, 75);
  image(rockImg, width/2, 0, 100, 75);
  image(paperImg, width/2, 100, 100, 75);
  image(scissorsImg, width/2, 200, 100, 75);
  strokeWeight(1);
    
  for(int i = 0; i < counters.length; i++){
       counters[i].display();
  }
  
  fill(0);
  rect(0, 287.5, width, 12.5);
  textSize(50);
  if(rockTotal <= 0){
    fill(255, 0, 0);
  } else {
    fill(0); 
  }
  text("Rock Total:" + rockTotal, 15, 50);
  if(paperTotal <= 0){
    fill(255, 0, 0);
  } else {
    fill(0); 
  }
  text("Paper Total:" + paperTotal, 15, 150);
  if(scissorsTotal <= 0){
    fill(255, 0, 0);
  } else {
    fill(0); 
  }
  text("Scissors Total:" + scissorsTotal, 15, 250);
}

void displayEndGameText(String winner){
  if (winner.equals("Rock")){
    fill(31, 149, 193);
    textSize(100);
    textAlign(CENTER);
    text("Rock Wins!", width/2, 425);
    textAlign(LEFT);
    fill(51, 242, 107);
    textSize(50);
  } else if (winner.equals("Paper")){
    fill(31, 149, 193);
    textSize(100);
    textAlign(CENTER);
    text("Paper Wins!", width/2, 425);
    textAlign(LEFT);
    fill(51, 242, 107);
    textSize(50);
  } else if (winner.equals("Scissors")){
    fill(31, 149, 193);
    textSize(100);
    textAlign(CENTER);
    text("Scissors Wins!", width/2, 425);
    textAlign(LEFT);
    fill(51, 242, 107);
    textSize(50);
  }
}

boolean checkGameOver(){
  if (paperTotal <=0 && scissorsTotal <= 0){
      return true;  
    } 
    else if (rockTotal <=0 && scissorsTotal <= 0){
      return true;
    } 
    else if (paperTotal <=0 && rockTotal <= 0){
      return true;  
    } 
    return false;
}

boolean collided(int x1, int y1, int x2, int y2){
  if(dist(x1, y1, x2, y2) <= 100){
    return true;
  } else {
    return false;
  }
}

Integer randomizeValue(String type){
  switch (type){
    case "x":
      return(int(random(150, width - 100)));
    case "y":
      return(int(random(350, height - 100)));
    case "vel":
      int val = int(random(0, 2));
      if (val == 0){
        return(3);
      } else {
        return(-3); 
      }      
  }
  
  return -1;
}
