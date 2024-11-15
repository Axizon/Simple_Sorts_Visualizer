class Block {

  int cx, cy;
  int sideLength;
  color inside;

  Block(int x, int y, int sl) {
    sideLength = sl;
    inside = color(255);
    cx = x;
    cy = y;
  }//default constructor

  void move(int x, int y) {
    cx = x;
    cy = y;
  }//move

  void display() {
    fill(inside);
    square(cx, cy, sideLength);

    fill(0);
    if (sideLength >= 100) {
      textSize(75);
    }
    else {
      textSize(sideLength);
    }
    textAlign(LEFT, TOP);
    text(sideLength, cx, cy);
  }//display


}//Ball
