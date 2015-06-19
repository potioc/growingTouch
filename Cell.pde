public class Cell {

  public float x, y;
  public float w;

  public int state;// 0  joueur 1 et 1 joueur 2 et -1 pour rien
  public int distance; // si la cell est en état 1 ou 2, la distance correspond à la distance entre la cell et le touch le plus proche

  public int oldState;
  public int oldDistance;
  
  Cell(float x_, float y_, float w_) {
    x = x_;
    y = y_;
    w = w_;
    
    state = -1;
    distance = 1000;
    oldState = state;
    oldDistance = distance;
  }

  void newState(int s) {
    state = s;
  }
  
  void setPrevious()
  {
    oldState = state;
    oldDistance = distance;
  }

  /*void display() {
    if (previous == 0 && state == 1) fill(0,0,255);
    else if (state == 1) fill(0);
    else if (previous == 1 && state == 0) fill(255,0,0);
    else fill(255); 
    stroke(0);
    rect(x, y, w, w);
  }*/
}
