class Grid {

  public int cellSize = 8;
  public int columns, rows;

  // Game of life board
  public Cell[][] board;

  Grid( int w, int h ) {
    // Initialize rows, columns and set-up arrays
    columns = w/cellSize;
    rows = h/cellSize;
    board = new Cell[columns][rows];
    initCells();
  }

  void initCells() {
    for (int i = 0; i < columns; i++) {
      for (int j = 0; j < rows; j++) {
        board[i][j] = new Cell(i*cellSize, j*cellSize, cellSize);
      }
    }
  }
  
  public PVector pixelToCell(int w, int h)
  {
    // PVector.x columns & PVector.y rows
    PVector result = new PVector();
    result.x = w/cellSize;
    result.y = h/cellSize;
    return result;
  }

  void boardSavePreviousStates()
  {
    for (int x = 0; x < columns; x++) {
      for (int y = 0; y < rows; y++) {
        board[x][y].setPrevious();
      }
    }
  }

  boolean isInTheGrid(PVector touchInput)
  {
    return touchInput.x > -1 && touchInput.x < columns && touchInput.y > -1 && touchInput.y < rows;
  }
  

  void placeEveryTowersOnTheGrid()
  {
    for( int i = 0; i < playerList.size(); i++ )
    {
      ArrayList<Tower> towers = playerList.get(i).towers;
      for ( int j = 0; j < towers.size(); j++ )
      {
        PVector touchInput = pixelToCell((int)towers.get(j).pos.x, (int)towers.get(j).pos.y);
        if ( isInTheGrid(touchInput) )
        {  
          Cell tmp = board[(int)touchInput.x][(int)touchInput.y];
          tmp.lastState = playerList.get(i).id;
          tmp.lastDistance = 0;
        }
      }
    }
  }
  
  boolean compareNeighbor(int min, Cell[][] board, int x, int y)
  {
    return min > board[x][y].lastDistance;
  }
  
  void computeNextStates()
  {
    int min = 999;
    int stateMin = -1;
    // Loop through every spot in our 2D array and check spots neighbors
    for (int x = 0; x < columns; x++) {
      for (int y = 0; y < rows; y++) {
        // regarde à gauche
        if ( x > 0 )
        {
          if ( compareNeighbor(min, board, x-1, y) )
          {
            min = board[x-1][y].lastDistance;
            stateMin = board[x-1][y].lastState;
          }
          
          if ( y < rows - 1 )
          {
            if ( compareNeighbor(min, board, x-1, y+1) )
            {
              min = board[x-1][y+1].lastDistance;
              stateMin = board[x-1][y+1].lastState;
            }
          }
          
          if ( y > 0 )
          {
            if ( compareNeighbor(min, board, x-1, y-1) )
            {
              min = board[x-1][y-1].lastDistance;
              stateMin = board[x-1][y-1].lastState;
            }
          }
        }
        // regarde à droite
        if ( x < columns - 1 )
        {
          if ( min > board[x+1][y].lastDistance )
          {
            min = board[x+1][y].lastDistance;
            stateMin = board[x+1][y].lastState;
          }
          if ( y < rows - 1 )
          {
            if ( compareNeighbor(min, board, x+1, y+1) )
            {
              min = board[x+1][y+1].lastDistance;
              stateMin = board[x+1][y+1].lastState;
            }
          }
          
          if ( y > 0 )
          {
            if ( compareNeighbor(min, board, x+1, y-1) )
            {
              min = board[x+1][y-1].lastDistance;
              stateMin = board[x+1][y-1].lastState;
            }
          }
        }
        // regarde en haut
        if ( y > 0 )
        {
          if ( min > board[x][y-1].lastDistance )
          {
            min = board[x][y-1].lastDistance;
            stateMin = board[x][y-1].lastState;
          }
        }
        // regarde en bas
        if ( y < rows - 1 )
        {
          if ( min > board[x][y+1].lastDistance )
          {
            min = board[x][y+1].lastDistance;
            stateMin = board[x][y+1].lastState;
          }
        }
        
        // set les nouvelles valeurs
        board[x][y].distance = min + 1;
        board[x][y].setState(stateMin);
        
        // remet les variables à zéro
        min = 999;
        stateMin = -1;
      }
    }
  }
  
  // The process of creating the new generation
  void update(ArrayList<Player> playerList) 
  { 
    boardSavePreviousStates();
    placeEveryTowersOnTheGrid();
    computeNextStates();
  }
  

  // This is the easy part, just draw the cells, fill 255 for '1', fill 0 for '0'
  void display(PGraphics g) {
    for ( int i = 0; i < columns;i++) {
      for ( int j = 0; j < rows;j++) {
        board[i][j].display(g);
      }
    }
  }
}

