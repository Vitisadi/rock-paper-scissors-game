class Element{
 int x, y;
 int vx, vy;
 int padding = 75;
 PImage img;
 String name = "paper";
 
 
 Element(int x, int y, int vx, int vy, String name){
   this.x = x;
   this.y = y;
   this.vx = vx;
   this.vy = vy;
   this.name = name;
 }
 
 void bounce(){
   if(x <= 0 || x >= width - padding){
     x += -vx * 5;
     vx = -vx; //<>//
   }
   if(y <= 300 || y >= height - padding){
     y += -vy * 5;
     vy = -vy;
   }
 }
 
 void move(){
   x += vx;
   y += vy;
 }
 
 void display(){
    if(img == null){
      img = loadImage("images/" + name + ".png"); 
    }
    image(img, x, y, 75, 75);
  }
}
