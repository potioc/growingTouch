import fr.inria.papart.multitouch.*;

public class MyApp  extends PaperTouchScreen {
    
    Grid g;
  
    void setup() {
	setDrawingSize(400, 360);
	loadMarkerBoard(sketchPath + "/data/A3-small1.cfg", 297, 210);
        g = new Grid(400, 360);
        frameRate(10);
    }
    
    void update()
    {
      g.generate(touchList);
    }
    
    void draw() {
	setLocation(100, 100,0 );
	beginDraw2D();
	
	background(255);
	
	
	
	for(Touch touch : touchList){
	    fill(touch.id, 100, 100);
            println(touch.id);
	    ellipse(touch.position.x, touch.position.y, 5, 5);
	}
        
        update();
        displayGrid();
	
	endDraw();
        
    }
    
    void displayGrid()
    {
      for ( int i = 0; i < g.columns;i++) {
        for ( int j = 0; j < g.rows;j++) {
          Cell c = g.board[i][j];
          if (c.state == 0) fill(255,0,0);
          else if (c.state == 1) fill(0,0,255);
          else if (c.state == -1) fill(255);
          stroke(0);
          rect(c.x, c.y, c.w, c.w);
        }
      }
    }
}

