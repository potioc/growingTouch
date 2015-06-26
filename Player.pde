static int NB_PLAYERS = 0;
static int MAX_PLAYERS = 2;
static Player currentPlayer;
static ArrayList<Player> playerList = new ArrayList<Player>();
//static ArrayList<PVector> allTokens = new ArrayList<PVector>();

void nextPlayer()
{
  
  println("Next player");
  
  if ( currentPlayer.id == NB_PLAYERS - 1 )
  {
    currentPlayer = playerList.get(0);
  } 
  else 
  {
    currentPlayer = playerList.get(currentPlayer.id + 1);
  }
  
  println("Current player " + currentPlayer.id);
}

public class Player
{
  ArrayList<Tower> towers = new ArrayList<Tower>();
  int id;
  
  public Player()
  {
    createID();
    playerList.add(this);
  }
  
  private void createID()
  {
    this.id = NB_PLAYERS++;
  }
  
  public boolean tryAddToken(PVector pos)
  {
    println("Adding a tower");

    Tower tower = new Tower(pos.get());
    //allTokens.add(tokenPos);
    towers.add(tower);
    return true;
  }
}
