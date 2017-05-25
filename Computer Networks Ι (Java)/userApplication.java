// Author: Konstantinos Mavrodis
// AEM: 7922
// e-mail: mavrkons@auth.gr

package userApplication;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import ithakimodem.*;

public class mainClass 
{
	
	private static Modem modem;
	private static int speed = 80000;
	private static int timeout = 2000;
	
	private static String echoRequestCode = "E6690\r";
	
	private static String imageRequestCodeErrorFree = "M8692\r";
	private static String imageRequestCodeWithErrors = "G3523\r";
	
	private static String GPSrequestCode = "P2416";
	private static String R = "R=1050050\r";
	
	private static String ACKresultCode = "Q2539\r";
	private static String NACKresultCode = "R0664\r";
	
	
	
	public static void main(String[] args) throws IOException 
	{
		System.out.println("User Apllication started.");
		
		initializeModem();
		
		echoPacket();
				
		receiveClearImage();
		
		receiveGPS();
		
		receiveProblematicImage();
		
		receiveARQ();		
	}
	
	private static void initializeModem()
	{
		modem = new Modem();
		modem.setSpeed(speed);
		modem.setTimeout(timeout);		
		modem.write("ATD2310ITHAKI\r".getBytes());
		
		int incomingByte;
		while(true)
		{
			try 
			{
				incomingByte = modem.read();
				
				if (incomingByte != -1)
					System.out.print((char)incomingByte);
				else
					break;
				
			} 
			catch (Exception x) 
			{
				System.out.println(x.toString());
				break;
			}
		}
		
		boolean f = new File("files").mkdir();
	}
	
	private static void echoPacket() throws FileNotFoundException
	{
		PrintWriter writeToFile = new PrintWriter("files/responsesLogFile.txt");
		
		DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		Calendar cal = Calendar.getInstance();
		writeToFile.println("Date and Time: " + dateFormat.format(cal.getTime()));

		long startTime = System.currentTimeMillis();
		long currentTime = System.currentTimeMillis();
		long endTime = startTime + 4*60*1000;
		
		
		System.out.println("Receiving echo packets STARTED.");
				
		String incomingString="";
		
		int packetNumber = 0;
		
		while (endTime - currentTime >= 0)
		{
			long sentTime = 0;
			long responseTime = 0;
			incomingString = "";
			sentTime = System.currentTimeMillis();
			
			packetNumber++;
			
			modem.write(echoRequestCode.getBytes());
			
			int incomingByte;
			while (true) 
			{
				 try 
				 {
					 incomingByte = modem.read();
				 }
				 catch (Exception x) 
				 {
					 System.out.println(x.toString());
					 break;
				 }

				 incomingString += (char)incomingByte;
				 
				 
				 if (!incomingString.startsWith("P"))
				 {
					 System.out.println("The echo Request code didn't work. Try another one.");
					 writeToFile.close();
					 System.exit(0);
				 }

				 if (incomingString.endsWith("PSTOP"))
				 {
					 responseTime = System.currentTimeMillis() - sentTime;
					 //String[] parts = incomingString.split("\\s+");
					 writeToFile.println ("Packet Number: " + packetNumber + " | Response time: " + responseTime);
					 incomingString = "";						 
					 break;
				 }
				 
			}
			currentTime = System.currentTimeMillis();
		}
		System.out.println( "Receiving echo packets FINISHED." );
		writeToFile.close();
	}
	
	private static void receiveClearImage() throws IOException
	{
		
		modem.write(imageRequestCodeErrorFree.getBytes());
		
		FileOutputStream writeToImage = new FileOutputStream ("files/clearImage.jpg");
		
		int inputByte;
		while(true) 
		{
			try 
			{
				inputByte = modem.read();				
			} 
			catch (Exception x) 
			{
				System.out.println(x);
				break;
			}
			
			if (inputByte != -1)
			{
				writeToImage.write((byte) inputByte);
				writeToImage.flush();
			}
			else
				break;
			
		}
		System.out.println("Clear Image finished.");

		writeToImage.close();
	}
	
	private static void receiveGPS() throws IOException
	{
		FileOutputStream gps = new FileOutputStream("files/GPS.jpg");

		int incomingByte;		
		int numberOfDots = 6;
		int seconds = 4;
		String incomingData = "";
		String[] longitudeArray = new String[numberOfDots];
		String[] latitudeArray = new String[numberOfDots];
		
		modem.write((GPSrequestCode + R).getBytes());
		
		while(true)
		{
			try 
			{
				incomingByte = modem.read();				
			} 
			catch (Exception x) 
			{
				System.out.println(x);
				break;
			}
			
			if (incomingByte != -1)
				incomingData += (char) incomingByte;
			else
				break;
		}
		
		String[] commas = incomingData.split(",");
		
		int nSeconds = 14 * seconds;
		int ii = 0;
		for (int i=2; i < commas.length; i+=nSeconds) 
		{
			if (ii != numberOfDots)
			{
				latitudeArray[ii] = commas[i];
				longitudeArray[ii] = commas[i+2];
				ii++;
			}
			else				
				break;
		}
		
		int lon;
		int lat;
		String code = GPSrequestCode;
		for (int i=0; i < numberOfDots; i++) 
		{
			code += "T=";
			code += longitudeArray[i].substring(1,3) + longitudeArray[i].substring(3,5);
			lon = (int) (0.006 * Integer.parseInt(longitudeArray[i].substring(6,10)));
			
			code += lon + "" + latitudeArray[i].substring(0,2) + latitudeArray[i].substring(2,4);
			lat = (int) (Integer.parseInt(latitudeArray[i].substring(5,9)) * 0.006);
			code += lat + "";
		}
		
		code += "\r";		
		modem.write(code.getBytes());
		
		while(true)
		{
			try 
			{
				incomingByte = modem.read();				
			} 
			catch (Exception x) 
			{
				System.out.println(x);
				break;
			}
			
			if (incomingByte != -1)
			{
				gps.write((byte) incomingByte);
				gps.flush();
			}
			else
				break;
		}
		System.out.println("GPS image finished.");
		gps.close();
	}

	private static void receiveProblematicImage() throws IOException
	{
		
		modem.write(imageRequestCodeWithErrors.getBytes());
		
		FileOutputStream writeToImage = new FileOutputStream ("files/problematicImage.jpg");
		
		int inputByte;
		while(true) 
		{
			try 
			{
				inputByte = modem.read();
			} 
			catch (Exception x) 
			{
				System.out.println(x);
				break;
			}
			
			if (inputByte != -1)
			{
				writeToImage.write((byte) inputByte);
				writeToImage.flush();
			}
			else
				break;
			
		}
		System.out.println("Problematic Image finished.");
		writeToImage.close();
	}

	private static void receiveARQ() throws FileNotFoundException
	{
		long endTime = System.currentTimeMillis() + 4*60*1000;
		
		PrintWriter writeToFile1 = new PrintWriter("files/ARQerrorTime.txt");
		PrintWriter writeToFile2 = new PrintWriter ("files/ARQnumberOfErrors.txt");
		
		int k;
		int numberOfErrors = 0;
		

		String data = "";
		String[] splittedData;
		
		boolean flag;
		flag = true;
		long timeToSend = 0;
		while (endTime - System.currentTimeMillis() >= 0) 
		{
			if (flag) 
			{
				modem.write(ACKresultCode.getBytes());
				timeToSend = System.currentTimeMillis();
			}
			else 
			{
				modem.write(NACKresultCode.getBytes());
				numberOfErrors++;
			}
			
			while(true)
			{
				try 
				{
					k = modem.read();
				} 
				catch (Exception x) 
				{
					System.out.println(x);
					break;
				}
				
				data += (char) k;
				
				if (data.endsWith("PSTOP")) 
				{
					splittedData = data.split("\\s+");					
					int XOR;
					int fcs = Integer.parseInt(splittedData[5]);
					
					
					XOR = splittedData[4].charAt(1)^splittedData[4].charAt(2);
					
					for (int i=3; i < 17; i++) 
						XOR = XOR^splittedData[4].charAt(i);
					
					if (XOR == fcs)
						flag = true;
					else
						flag = false;
					
					if (flag) 
					{
						writeToFile1.println(System.currentTimeMillis() - timeToSend);
						writeToFile2.println(numberOfErrors);
						
						numberOfErrors = 0;
					}
					data = "";
					break;
				}
			}
		}		
		writeToFile1.close();
		writeToFile2.close();
	}
	


}
