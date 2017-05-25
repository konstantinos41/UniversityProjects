package node79127922;


import game.Board;
import game.GomokuUtilities;

import java.util.ArrayList;


public class Node
{
	private static final int[] FiveInARowPlayer1 = {1,1,1,1,1};
	private static final int[] FiveInARowPlayer2 = {2,2,2,2,2};
	private static final int[] FourInARowStraightPlayer1 = {0,1,1,1,1,0};
	private static final int[] FourInARowStraightPlayer2 = {0,2,2,2,2,0};
	private static final int[] FourInARowSimpleCase1Player1 = {0,1,1,1,1};
	private static final int[] FourInARowSimpleCase2Player1 = {1,1,1,1,0};
	private static final int[] FourInARowSimpleCase1Player2 = {0,2,2,2,2};
	private static final int[] FourInARowSimpleCase2Player2 = {2,2,2,2,0};
	private static final int[] ThreeInARowStraightCase1Player1 = {0,1,1,1,0,0};
	private static final int[] ThreeInARowStraightCase2Player1 = {0,0,1,1,1,0};
	private static final int[] ThreeInARowStraightCase1Player2 = {0,2,2,2,0,0};
	private static final int[] ThreeInARowStraightCase2Player2 = {0,0,2,2,2,0};
	private static final int[] ThreeInARowPlayer1 = {1,1,1};
	private static final int[] ThreeInARowPlayer2 = {2,2,2};
	private static final int[] TwoInARowStraightPlayer1 = {1,1};
	private static final int[] TwoInARowStraightPlayer2 = {2,2};
	
	private int myPlayer;
	private Node parent;
	private ArrayList<Node> children;
	private int nodeDepth;
	private int[] nodeMove;
	private int[][] nodeBoard;
	private double nodeEvaluation = 0;
	private int fourInARowMeFlag;
	private int fourInARowOpponentFlag;
	private double fourAndThreeMeFlag;
	private double fourAndThreeOpponentFlag;
	
	public int[][] getNodeBoard() 
	{
		return nodeBoard;
	};
	
	public void addChild(Node child)
	{
		children.add(child);
	}
	
	public ArrayList<Node> getChildren()
	{
		return children;
	}
	
	public int[] getNodeMove()
	{
		return nodeMove;
	}
	
	public double getNodeEvaluation()
	{
		return nodeEvaluation;
	}
	
	public void setNodeEvaluation()
	{
		nodeEvaluation = evaluateNodeBoard();
	}
	
	public void addToNodeEvaluation(double m)
	{
		nodeEvaluation = 0;
		nodeEvaluation += m;		
	}
	
	
	// This constructor is called only for the root node
	public Node(int[][] nodeBoard_, int id)
	{
		nodeBoard = nodeBoard_;
		children = new ArrayList<Node>();
		myPlayer = id;
	}
	
	// Constructor for every other node
	public Node(Node parent_, int nodeDepth_, int[] nodeMove_, int[][] nodeBoard_, int id)
	{
		parent = parent_;
		nodeDepth = nodeDepth_;
		nodeMove = nodeMove_;
		nodeBoard = nodeBoard_;
		children = new ArrayList<Node>();
		myPlayer = id;
	}
	
	private double evaluateNodeBoard()
	  {
		double score = 0;
		
		fourInARowMeFlag = 0;
		fourInARowOpponentFlag = 0;
		fourAndThreeMeFlag = 0;
		fourAndThreeOpponentFlag = 0;
		
		int[] anArray = new int[15];
		
	  	for (int i = 0; i < GomokuUtilities.NUMBER_OF_COLUMNS; i++)
	  	{
	  		for (int j = 0; j < GomokuUtilities.NUMBER_OF_COLUMNS; j++)
	  	  	{
	  			anArray[j] = nodeBoard[i][j];
	  	  	}
	  		score += evaluateArray(anArray);
	  		
	  		for (int z = 0; z < GomokuUtilities.NUMBER_OF_COLUMNS; z++)
	  		{
	  			anArray[z] = 4;
	  		}
	  	}
	  	
	  	
	  	for (int j = 0; j < GomokuUtilities.NUMBER_OF_COLUMNS; j++)
	  	{
	  		for (int i = 0; i < GomokuUtilities.NUMBER_OF_COLUMNS; i++)
	  	  	{
	  			anArray[i] = nodeBoard[i][j];
	  	  	}
	  		score += evaluateArray(anArray);
	  		
	  		for (int z = 0; z < GomokuUtilities.NUMBER_OF_COLUMNS; z++)
	  			anArray[z] = 4;
	  	}
	  	
	  	
	  	for (int k = 0; k < GomokuUtilities.NUMBER_OF_COLUMNS; k++)
	  	{
	  	  	int j = 0;
	  	  	int x = 0;
	  	  	for (int i = k; i > 0; i--)
	  	  	{
	  	  		anArray[x] = nodeBoard[i][j];
	  	  		x++;
	  	  		j++;
	  	  	}
	  	  	score += evaluateArray(anArray);
	  	  	
	  	  	for (int z = 0; z < GomokuUtilities.NUMBER_OF_COLUMNS; z++)
	  			anArray[z] = 4;
	  	}
	  	
	  	for (int k = 1; k < GomokuUtilities.NUMBER_OF_COLUMNS; k++)
	  	{
	  		int x = 0;
	  	  	int i = GomokuUtilities.NUMBER_OF_COLUMNS - 1;
	  	  	for (int j = k; j < GomokuUtilities.NUMBER_OF_COLUMNS; j++)
	  	  	{
	  	  		anArray[x] = nodeBoard[i][j];
	  	  		x++;
	  	  		i--;
	  	  	}
	  	  	score += evaluateArray(anArray);
	  	  	for (int z = 0; z < GomokuUtilities.NUMBER_OF_COLUMNS; z++)
	  			anArray[z] = 4;
	  	}
	  	
	  	
	  	for (int k = GomokuUtilities.NUMBER_OF_COLUMNS -1; k >= 0; k--)
	  	{
	  		int x = 0;
	  		int j = 0;
	  	  	for (int i = k; i < GomokuUtilities.NUMBER_OF_COLUMNS; i++)
	  	  	{
	  	  		anArray[x] = nodeBoard[i][j];
	  	  		x++;
	  	  		j++;
	  	  	}
	  	  	score += evaluateArray(anArray);
	  	  	for (int z = 0; z < GomokuUtilities.NUMBER_OF_COLUMNS; z++)
	  			anArray[z] = 4;
	  	 }
	  	
	  	for (int k = 1; k < GomokuUtilities.NUMBER_OF_COLUMNS; k++)
	  	{
	  		int x = 0;
	  		int i = 0;
	  		for (int j = k; j < GomokuUtilities.NUMBER_OF_COLUMNS; j++)
	  		{
	  			anArray[x] = nodeBoard[i][j];
	  			x++;
	  			i++;
	  		}
	  		score += evaluateArray(anArray);
	  		for (int z = 0; z < GomokuUtilities.NUMBER_OF_COLUMNS; z++)
	  			anArray[z] = 4;
	  	}
	  	
	  	if (fourInARowMeFlag > 1)
	  		score += fourInARowMeFlag *2000;
	  	
	  	if (fourInARowOpponentFlag > 1)
	  		score += -fourInARowOpponentFlag*900;
	  	
	  	if (fourAndThreeMeFlag >1 && fourAndThreeMeFlag%1 != 0)
	  		score += 1800;
	  	

	  	if (fourAndThreeOpponentFlag >= 1 && fourAndThreeOpponentFlag%1 != 0)
	  		score += -1400;
	  	
	  	
	  	return score;
	  }
	  
	  private double evaluateArray(int[] anArray)
	  {
		  double score = 0;
		  
		  if (myPlayer == 1)
		  {
			  if (checkForPattern(anArray, FiveInARowPlayer1))
				  return 10000;
			  
			  if (checkForPattern(anArray, FiveInARowPlayer2))
				  return -4400;
			  
			  if (checkForPattern(anArray, FourInARowStraightPlayer1))
				  return 2000;				  
			  
			  if (checkForPattern(anArray, FourInARowStraightPlayer2))
				  return -1500;
			  
			  if (checkForPattern(anArray, FourInARowSimpleCase1Player1) ||    /// Na to proseksw
					  checkForPattern(anArray, FourInARowSimpleCase2Player1))
			  {
				  fourInARowMeFlag++;
				  fourAndThreeMeFlag++;
			  }
			  
			  if (checkForPattern(anArray, FourInARowSimpleCase1Player2) || 
					  checkForPattern(anArray, FourInARowSimpleCase2Player2))
			  {
				  fourInARowOpponentFlag++;
				  fourAndThreeOpponentFlag++;
			  }
			  
			  if (checkForPattern(anArray, ThreeInARowStraightCase1Player1) || 
					  checkForPattern(anArray, ThreeInARowStraightCase2Player1))
			  {
				  score += 100;
				  fourAndThreeMeFlag += 0.1;
			  }
			  
			  if (checkForPattern(anArray, ThreeInARowStraightCase1Player2) || 
					  checkForPattern(anArray, ThreeInARowStraightCase2Player2))
			  {
				  score += -80;
				  fourAndThreeOpponentFlag += 0.1;
			  }
			  
			  if(checkForPattern(anArray, ThreeInARowPlayer1))
				  score += 30;
			  
//			  if(checkForPattern(anArray, ThreeInARowPlayer2))
//				  score += -15;
			  
			  if (checkForPattern(anArray, TwoInARowStraightPlayer1))
				  score += 7;
			  
			  if (checkForPattern(anArray, TwoInARowStraightPlayer1))
				  score += -3;
			  
		  }
		  
		  if (myPlayer == 2)
		  {
			  if (checkForPattern(anArray, FiveInARowPlayer2))
				  return 10000;
			  
			  if (checkForPattern(anArray, FiveInARowPlayer1))
				  return -4400;
			  
			  if (checkForPattern(anArray, FourInARowStraightPlayer2))
				  return 2000;				  
			  
			  if (checkForPattern(anArray, FourInARowStraightPlayer1))
				  return -1500;
			  
			  if (checkForPattern(anArray, FourInARowSimpleCase1Player2) ||    /// Na to proseksw
					  checkForPattern(anArray, FourInARowSimpleCase2Player2))
			  {
				  fourInARowMeFlag++;
				  fourAndThreeMeFlag++;
			  }
			  
			  if (checkForPattern(anArray, FourInARowSimpleCase1Player1) || 
					  checkForPattern(anArray, FourInARowSimpleCase2Player1))
			  {
				  fourInARowOpponentFlag++;
				  fourAndThreeOpponentFlag++;
				  
			  }
			  
			  if (checkForPattern(anArray, ThreeInARowStraightCase1Player2) || 
					  checkForPattern(anArray, ThreeInARowStraightCase2Player2))
			  {
				  score += 100;
				  fourAndThreeMeFlag += 0.1;
			  }
			  
			  if (checkForPattern(anArray, ThreeInARowStraightCase1Player1) || 
					  checkForPattern(anArray, ThreeInARowStraightCase2Player1))
			  {
				  score += -80;
				  fourAndThreeOpponentFlag += 0.1;
			  }
				  
			  if(checkForPattern(anArray, ThreeInARowPlayer2))
				  score += 30;
			  
//			  if(checkForPattern(anArray, ThreeInARowPlayer1))
//				  score += -15;
			  
			  if (checkForPattern(anArray, TwoInARowStraightPlayer2))
				  score += 7;
			  
			  if (checkForPattern(anArray, TwoInARowStraightPlayer2))
				  score += -3;
		  }
		  
		  return score;
	  }
	    
	  private boolean checkForPattern(int anArray[], int[] aPattern)
	  {	  
		  for (int i = 0; i < anArray.length; i++)
		  {
			  if (anArray[i] == 4)
				  return false;
			  
	          int j = 0;
			  int counter = 0;
	          
	          while(j < aPattern.length && (i+j) < anArray.length && anArray[i+j] == aPattern[j])
	          {
	        	  counter++;
	        	  j++;
	          }
	          if(counter == aPattern.length)
	        	  return true;
	      }
		  
	      return false;		  
	  }

}