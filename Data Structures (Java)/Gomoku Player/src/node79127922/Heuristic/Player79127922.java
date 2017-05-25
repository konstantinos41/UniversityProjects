package node79127922;

import java.util.ArrayList;

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
  
  public int[] getNextMove (Board board)
  {
     ArrayList<int[]> ratingsList = new ArrayList<int[]>();
     // Parse through the board to fill the ArrayList
     for(int i=0; i < GomokuUtilities.NUMBER_OF_COLUMNS; i++)
     {
    	 for(int j=0; j < GomokuUtilities.NUMBER_OF_ROWS; j++)
    	 {
    		 if(board.getTile(i, j).getColor() == 0)
    		 {
    			 int[] array = new int[3];
    			 array[0] = i;
    			 array[1] = j;
    			 array[2] = evaluate(i, j, board);
    			 ratingsList.add(array);
    		 }
    	 }
     }
     
     // Find the best possible move using their ratings
     int max = 0;
     int[] move = new int[2];
     for(int i=0; i< ratingsList.size(); i++)
     {
    	 if(max <= ratingsList.get(i)[2])
    	 {
    		 max = ratingsList.get(i)[2];
    		 move[0] = ratingsList.get(i)[0];
    		 move[1] = ratingsList.get(i)[1];
    	 }	
     }
     System.out.println(max);
     return move;  
  }
  
  /**
   * @details evaluates the rating of a given spot with the use of the following functions: createsNple,
   * colorPercentage, centrality.
   * @param x [int] x coordiante of the given spot
   * @param y [int] y coordinate of the given spot
   * @param board [Board] holds the current state of the board
   * @return successRate [int] integer from 0 to 100, the higher it is the more advantageous the move
   */
  int evaluate (int x, int y, Board board){
  	  int successRate = 0;
  	  
  	  // If making a move to this specific spot will let us win the game return 100 which is the best
  	  // possible score
  	  if (createsNple(x, y, board, this.id, 5, false) != 0)
  		  return 100;
  	  
  	  // If making a move to this specific spot will let the opponents win the game return 99 which is the
  	  // second best possible score
  	  if (createsNple(x, y, board, (this.id%2 + 1), 5, false) != 0)
  		  return 99;  	  
  	  
  	  if (createsNple(x, y, board, this.id, 4, true) != 0)
  	  	return 98;

  	  if (createsNple(x, y, board, (this.id%2 + 1), 4, true) != 0)
  	  	return 97;
  	  
  	  if (createsNple(x, y, board, this.id, 4, false) > 1)
  		  return 98;
  	  
  	  if (createsNple(x, y, board, (this.id%2 + 1), 4, false) > 1)
		  return 97;
  	  
  	  
  	  successRate += 20 * createsNple(x, y, board, this.id, 3, true);

  	  successRate += 18 * createsNple(x, y, board, (this.id%2 + 1), 3, true);

	  	  
  	  
  	  // Add to the successRate if near the current spot there are taken positions
  	  // successRate += (GomokuUtilities.colorPercentage(board, x, y, 3, 1)*1000)%4;
  	  // successRate += (GomokuUtilities.colorPercentage(board, x, y, 3, 2)*1000)%3;
	  
  	  // Add to the successRate if it is in the center of the board
  	  successRate += centrality(x, y) ;
  	  
  	  return successRate;
  }
  
  
  
  	/**
  	 * @brief calculates if an N in a row is possible for any given player, after making a
  	 * move to a specific postion
  	 * @param x [int] x coordinate of the given spot
  	 * @param y [int] y coordinate of the given spot
  	 * @param board [Board] holds the current state of the board
  	 * @param player [int] 1 if player 1 will make the move, 2 if it is player 2
  	 * @param N [int] holds the number of the spots taken by a player that the function will
  	 * look for, including the spot that will be played.
  	 * @return [boolean] true if a N in a row possible after filling the given position
  	 */
	public int createsNple(int x, int y, Board board, int player, int N, boolean straight) {
		
		int numberOfNples = 0;
		int counter = 0;
		int i , j;

		/////// Vertical ////////
		// Vertical Down //
		j = y + 1;
		while (isOnBoard(x, j))
		{
			if (board.getTile(x,j).getColor() == player)
				counter ++;
			
			else if (straight ==  true && board.getTile(x,j).getColor() == 0)
			{
				counter++;
				if (N == 3 && isOnBoard(x, j+1) && board.getTile(x, j+1).getColor() == 0)
					counter++;				
				break;
			}
			else
				break;
			
			j++;
		}		
		
		
		// Vertical Up //
		j = y - 1;
		while (isOnBoard(x, j))
		{
			if (board.getTile(x,j).getColor() == player)
				counter++;
			else if (straight == true && board.getTile(x,j).getColor() == 0) 
			{
				counter++;
				if (N == 3 && isOnBoard(x, j-1) && board.getTile(x, j-1).getColor() == 0)
					counter++;				
				break;
			}
			else
				break;
			
			j--;
		}
		
		
		if(straight == false && counter >= (N-1))
			numberOfNples++;

		if(N!=3 && straight == true && counter >= (N+1))
			numberOfNples++;
		
		if(N==3 && straight == true && counter >= (N+2))
			numberOfNples++;
		
		
		
		/////// Horizontal ///////
		// Horizontal left //
		counter = 0;
		i = x - 1;
		while (isOnBoard(i, y))
		{
			if (board.getTile(i,y).getColor() == player)
				counter++;
			else if (straight == true && board.getTile(i,y).getColor() == 0)
			{
				counter++;
				if (N == 3 && isOnBoard(i-1, y) && board.getTile(i-1, y).getColor() == 0)
					counter++;
				break;
			}
			else
				break;
			
			i--;
		}
		
		// Horizontal Right //
		i = x + 1;
		while (isOnBoard(i, y))
		{
			if (board.getTile(i,y).getColor() == player)
				counter++;
			else if (straight == true && board.getTile(i,y).getColor() == 0)
			{
				counter++;
				if (N == 3 && isOnBoard(i+1, y) && board.getTile(i+1, y).getColor() == 0)
					counter++;
				break;
			}
			else
				break;
			
			i++;
		}
		
		if(straight == false && counter >= (N-1))
			numberOfNples++;

		if(N!=3 && straight == true && counter >= (N+1))
			numberOfNples++;
		
		if(N==3 && straight == true && counter >= (N+2))
			numberOfNples++;
		
		
		/////// Diagonal ///////
		// Diagonal left up to right down //
		counter = 0;
		i = x - 1;
		j = y - 1;
		while (isOnBoard(i, j))
		{
			if (board.getTile(i,j).getColor() == player)
				counter++;
			else if (straight == true && board.getTile(i,j).getColor() == 0)
			{
				counter++;
				if (N == 3 && isOnBoard(i-1, j-1) && board.getTile(i-1, j-1).getColor() == 0)
					counter++;
				break;
			}
			else 
				break;
		
			i--;
			j--;

		}
		
		
		i = x + 1;
		j = y + 1;
		while (isOnBoard(i, j))
		{
			if (board.getTile(i,j).getColor() == player)
				counter++;
			else if (straight == true && board.getTile(i,j).getColor() == 0)
			{
				counter++;
				if (N == 3 && isOnBoard(i+1, j+1) && board.getTile(i+1, j+1).getColor() == 0)
					counter++;
				break;
			}
			else 
				break;

			i++;
			j++;
		}
				
		if(straight == false && counter >= (N-1))
			numberOfNples++;

		if(N!=3 && straight == true && counter >= (N+1))
			numberOfNples++;
		
		if(N==3 && straight == true && counter >= (N+2))
			numberOfNples++;
		
		
		
		// Diagonal Right Up to Left down //
		counter = 0;
		i = x - 1;
		j = y + 1;
		while(isOnBoard(i, j))
		{
			if (board.getTile(i,j).getColor() == player)
				counter++;
			else if (straight == true && board.getTile(i,j).getColor() == 0)
			{
				counter++;
				if (N == 3 && isOnBoard(i-1, j+1) && board.getTile(i-1, j+1).getColor() == 0)
					counter++;
				break;
			}
			else 
				break;
			
			i--;
			j++;
		}
		
		i = x + 1;
		j = y - 1;
		while (isOnBoard(i, j))
		{
			if(board.getTile(i,j).getColor() == player)
				counter++;
			else if(straight == true && board.getTile(i,j).getColor() == 0)
			{
				counter++;
				if (N == 3 && isOnBoard(i+1, j-1) && board.getTile(i+1, j-1).getColor() == 0)
					counter++;
				break;
			}
			else 
				break;
			
			i++;
			j--;
		}
		
		if(straight == false && counter >= (N-1))
			numberOfNples++;

		if(N!=3 && straight == true && counter >= (N+1))
			numberOfNples++;
		
		if(N==3 && straight == true && counter >= (N+2))
			numberOfNples++;
		
		
		return numberOfNples;
		
	}
	
	/**
	 * @details calculates a number, the bigger it is the shortest the spot's distance of
	 * the center of the board
	 * @param x [int] x coordinate
	 * @param y [int] y coordinate
	 * @return [double] from 0 to 1
	 */
	public int centrality(int x, int y)
	{
		if(x > 4 && x < 10 && y > 4 && y < 10)
			return 1;
		else
			return 0;
	}
	
	
	public boolean isOnBoard(int x, int y)
	{
		if(x >= 0 && y >=0 && x < GomokuUtilities.NUMBER_OF_COLUMNS && y < GomokuUtilities.NUMBER_OF_ROWS)
			return true;
		else
			return false;
	}

}
