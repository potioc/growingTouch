import fr.inria.papart.multitouch.*;

public class MyApp  extends PaperTouchScreen {
    
    Grid grid;
  
    void setup() {
	setDrawingSize(400, 360);
	loadMarkerBoard(sketchPath + "/data/A3-small1.cfg", 297, 210);

        Player p1 = new Player();
        Player p2 = new Player();
        Player p3 = new Player();
        Player p4 = new Player();
        currentPlayer = p1;

        grid = new Grid(400, 360);
        frameRate(20);
    }
    
    void update()
    {
      grid.update(playerList);
    }
    
    int NEW_TOUCH = -1;
    
    void checkTouch()
    {
      TouchList touch2D = touchList.get2DTouchs();
      for (Touch t : touch2D) {
    
        // draw the touch. 
        PVector p = t.position;
    
        // draw the elements of the Touch
    
        TouchPoint tp = t.touchPoint;
        if(tp == null){
          println("TouchPoint null, this method only works with KinectTouchInput.");
          continue;
        }
    
        if(tp.attachedValue == NEW_TOUCH){
          fill(200);
          ellipse(p.x, p.y, 10, 10);
    
          if(tp.getAge(millis()) > 1000){
            if(currentPlayer.tryAddToken(p)){
              tp.attachedValue = currentPlayer.id;
            }
          }
        }
      }
    }
    
    void draw() {
	setLocation(100, 100,0 );
	beginDraw2D();
	
	background(255);
	
	
	
	for(Touch touch : touchList){
	    fill(touch.id, 100, 100);
            //println(touch.id);
	    ellipse(touch.position.x, touch.position.y, 5, 5);
	}
        
        grid.update(playerList);
        grid.display(getGraphics());
        
        checkTouch();
	
	endDraw();
        
    }
}

