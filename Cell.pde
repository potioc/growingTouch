public class Cell extends PVector{

  public float size;

  public int state;// 0  joueur 1 et 1 joueur 2 et -1 pour rien
  public int distance; // si la cell est en état 1 ou 2, la distance correspond à la distance entre la cell et le touch le plus proche

  public int lastState;
  public int lastDistance;
  
  Cell(float x, float y, float size) {
    this.x = x;
    this.y = y;
    this.size = size;
    
    state = -1;
    distance = 1000;
    lastState = state;
    lastDistance = distance;
  }

  void setState(int s) {
    state = s;
  }
  
  void setPrevious()
  {
    lastState = state;
    lastDistance = distance;
  }

  void display(PGraphics g) {
        g.fill(getColor());
        //g.stroke(0);
        noStroke();
        g.rect(x, y, size, size);
  }
  
  int getColor()
  {
    if ( state == 0 )
      return #FFCA08;
    if ( state == 1 )
      return #5C86FB;
    if ( state == 2 )
      return #FF0000;
    if ( state == 3 )
      return #5CFB5E;
    if ( state == -1 )
      return #FFFFFF;
    return #FFCA08;
  }
}
