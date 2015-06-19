class Grid {

  public int w = 8;
  public int columns, rows;

  // Game of life board
  public Cell[][] board;

  Grid( int _w, int _h ) {
    // Initialize rows, columns and set-up arrays
    columns = _w/w;
    rows = _h/w;
    board = new Cell[columns][rows];
    init();
  }

  void init() {
    for (int i = 0; i < columns; i++) {
      for (int j = 0; j < rows; j++) {
        board[i][j] = new Cell(i*w, j*w, w);
      }
    }
  }
  
  public PVector pixelToCell(int w, int h)
  {
    // PVector.x columns & PVector.y rows
    PVector result = new PVector();
    result.x = w/8;
    result.y = h/8;
    return result;
  }

  // The process of creating the new generation
  void generate(TouchList tList) 
  {
    for (int x = 0; x < columns; x++) {
      for (int y = 0; y < rows; y++) {
        board[x][y].setPrevious();
      }
    }
    
    
    // on regarde s'il y a eu une nouvelle input, si oui on place    
    for (Touch t : tList)
    {
      PVector touchInput = pixelToCell((int)t.position.x, (int)t.position.y);
      if ( touchInput.x > -1 && touchInput.x < columns && touchInput.y > -1 && touchInput.y < rows )
      {  
        Cell tmp = board[(int)touchInput.x][(int)touchInput.y];
        tmp.oldState = t.id%2;
        tmp.oldDistance = 0;
      }
    }

    int min = 999;
    int stateMin = -1;
    // Loop through every spot in our 2D array and check spots neighbors
    for (int x = 0; x < columns; x++) {
      for (int y = 0; y < rows; y++) {
        // regarde à gauche
        if ( x > 0 )
        {
          if ( min > board[x-1][y].oldDistance )
          {
            min = board[x-1][y].oldDistance;
            stateMin = board[x-1][y].oldState;
          }
        }
        // regarde à droite
        if ( x < columns - 1 )
        {
          if ( min > board[x+1][y].oldDistance )
          {
            min = board[x+1][y].oldDistance;
            stateMin = board[x+1][y].oldState;
          }
        }
        // regarde en haut
        if ( y > 0 )
        {
          if ( min > board[x][y-1].oldDistance )
          {
            min = board[x][y-1].oldDistance;
            stateMin = board[x][y-1].oldState;
          }
        }
        // regarde en bas
        if ( y < rows - 1 )
        {
          if ( min > board[x][y+1].oldDistance )
          {
            min = board[x][y+1].oldDistance;
            stateMin = board[x][y+1].oldState;
          }
        }
        
        // set les nouvelles valeurs
        board[x][y].distance = min + 1;
        board[x][y].state = stateMin;
        
        // remet les variables à zéro
        min = 999;
        stateMin = -1;
      }
    }
  }

  // This is the easy part, just draw the cells, fill 255 for '1', fill 0 for '0'
  /*void display() {
    for ( int i = 0; i < columns;i++) {
      for ( int j = 0; j < rows;j++) {
        board[i][j].display();
      }
    }
  }*/
}

