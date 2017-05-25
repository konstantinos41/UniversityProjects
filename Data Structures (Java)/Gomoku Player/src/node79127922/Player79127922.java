package node79127922;

import game.AbstractPlayer;
import game.Board;
import game.GomokuUtilities;

public class Player79127922 implements AbstractPlayer
{

  int score;
  int id;
  String name;
  
  int flag = 0;
  
  int simpleBoard[][] = new int[GomokuUtilities.NUMBER_OF_COLUMNS][GomokuUtilities.NUMBER_OF_ROWS];
    

  public Player79127922 (Integer pid)
  {
    id = pid;
    score = 0;
  }

  public String getName ()
  {
    return "Rocket Team";
  }

  public int getId ()
  {
    return id;
  }

  public void setScore (int score)
  {
    this.score = score;
  }

  public int getScore ()
  {
    return score;
  }

  public void setId (int id)
  {
    this.id = id;
  }

  public void setName (String name)
  {
    this.name = name;
  }
  
  private void copyBoard(Board board)
  {
    for (int i = 0; i < GomokuUtilities.NUMBER_OF_COLUMNS; i++) 
  	{
  		for (int j = 0; j < GomokuUtilities.NUMBER_OF_ROWS; j++)
  		{
  			simpleBoard[i][j] = board.getTile(i,j).getColor();  				
  		}	
  	}
  }

  public int[] getNextMove (Board board)
  {
	  if (flag < 2)
	  {
		  int[] xy = new int[2];
		  if (board.getTile(8,8).getColor() == 0)
		  {
			  xy[0] = 8;
			  xy[1] = 8;
		  }
		  
		  else
		  {
			  xy[0] = 7;
			  xy[1] = 7;
		  }
		  flag++;
		  
		  return xy;
	  }
	  
  	copyBoard(board); 	  
		    	
	Node root = new Node(simpleBoard, id);
  	
  	createMySubTree(root, 1);
  	
	return chooseMove(root);
    
  }
  
  private void createMySubTree(Node parent, int depth)
  {
	  for(int i=0; i < GomokuUtilities.NUMBER_OF_COLUMNS; i++)
	  {
		  for(int j=0; j < GomokuUtilities.NUMBER_OF_ROWS; j++)
		  {
			  if(simpleBoard[i][j] == 0)
			  {	    			 
				  simpleBoard[i][j] = id;
				  
				  int[] xy = {i,j};
				  
				  Node childNode = new Node(parent, depth, xy, simpleBoard, id);
				  
				  parent.addChild(childNode);
				  
				  createOpponentSubTree(childNode, depth+1);
				  
				  simpleBoard[i][j] = 0;
			  }
		  }
	  }
  }
  
  
  private void createOpponentSubTree(Node parent, int depth)
  {	  
	  for(int i=0; i < GomokuUtilities.NUMBER_OF_COLUMNS; i++)
	     {
	    	 for(int j=0; j < GomokuUtilities.NUMBER_OF_ROWS; j++)
	    	 {
	    		 if(simpleBoard[i][j] == 0)
	    		 {	    			 
	    			 simpleBoard[i][j] = (id%2 + 1);
	    			 
	    			 int[] xy = {i, j};
	    			 
	    			 Node childNode = new Node(parent, depth, xy, simpleBoard, id);
	    			 
	    			 childNode.setNodeEvaluation();
	    			 
	    			 parent.addChild(childNode);
	    			 
	    			 simpleBoard[i][j] = 0;

	    		 }
	    	 }
	     }
  }
  
  private int[] chooseMove (Node root)
  {
	  int index = 0;
	  
	  for(int i = 0; i < root.getChildren().size(); i++)
	  {
		  double min = Double.POSITIVE_INFINITY;
		  for(int j = 0; j < root.getChildren().get(i).getChildren().size(); j++)
		  {
			  if (min >= root.getChildren().get(i).getChildren().get(j).getNodeEvaluation())
			  {
				  min = root.getChildren().get(i).getChildren().get(j).getNodeEvaluation();
			  }
			  
		  }
		  root.getChildren().get(i).addToNodeEvaluation(min);
	  }
	  
	  double max = Double.NEGATIVE_INFINITY;
	  for (int i = 0; i < root.getChildren().size(); i++)
	  {
		  if (max <= root.getChildren().get(i).getNodeEvaluation())
		  {
			  max = root.getChildren().get(i).getNodeEvaluation();
			  index = i;
		  }
	  }
	 
	  
	  return root.getChildren().get(index).getNodeMove();
  }
 
}
