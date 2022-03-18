class Button {
  float x, y, sizex, sizey;
  String label;
  color clr;
  boolean image;
  PImage img;

  Button(String label, float x, float y, int sizex, int sizey, color clr, boolean image) {
    this.label = label;
    this.x = x;
    this.y = y;
    this.sizex = sizex;
    this.sizey = sizey;
    this.clr = clr;
    this.image = image;
  }

  void display() {
    if(image){
      if(img == null){
        img = loadImage("images/" + label); 
      }
      strokeWeight(3);
      fill(clr);
      rect(x, y, sizex, sizey);
      fill(0);
      image(img, x, y, sizex, sizey);
    } else {
      strokeWeight(5);
      fill(clr);
      rect(x, y, sizex, sizey);
      fill(0);
      textAlign(CENTER, CENTER);
      textSize(50);
      text(label, x + 0.5 * sizex, y + 0.5 * sizey);
    }
    strokeWeight(1);
    textAlign(LEFT);
  }

  boolean clicked() {
    if (mouseX > x && mouseX < x+sizex && mouseY > y && mouseY < y+sizey) return true;
      return false;
    }
}
