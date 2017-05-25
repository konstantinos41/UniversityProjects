package userApplication2;

/* 
 * userApplication
 * Konstantinos Mavrodis
 * mavrkons@auth.gr
 * 7922
 */

import java.net.*;
import java.io.*;

import javax.sound.sampled.*;


public class userApplication {

	private static String clientListeningPort = "48013";
	private static String serverListeningPort = "38013";
	private static String echoRequestCode = "E5924";
	private static String imageRequestCode = "M7632CAM=FIX";
	private static String soundRequestCode = "V0530F999";
	
	
	public static void main(String[] args) throws IOException, LineUnavailableException
	{
		
			userApplication app = new userApplication();
			
			System.out.println("User Apllication started.");
			
			boolean f = new File("files").mkdir();
			
			echo();
			
		    image();
			
			sound();
			
	}

	
	
	private static void echo() throws IOException
	{
		
		long timeStart = 0;
		long timeNow = 0;
		long timeSend = 0;
		long timeReceive = 0;
		
		int n = 0;
		int i = 0;
		
		String message = null;
		String echoRequestCodeT = null;
		
		
		PrintWriter responseTime=new PrintWriter("files/System_Response_Time.txt");
		PrintWriter packets=new PrintWriter("files/Packets_Received.txt");
		
		

		DatagramSocket s = new DatagramSocket();	
		
		String packetInfo = echoRequestCode;
		
		byte[] txbuffer = packetInfo.getBytes();
		int serverPort = Integer.parseInt(serverListeningPort);
		byte[] hostIP = { (byte)155,(byte)207,18,(byte)208 };
		InetAddress hostAddress = InetAddress.getByAddress(hostIP);		
		DatagramPacket p = new DatagramPacket(txbuffer,txbuffer.length, hostAddress,serverPort);
		

		DatagramSocket r = new DatagramSocket(Integer.parseInt(clientListeningPort));
		r.setSoTimeout(3000);
		
		byte[] rxbuffer = new byte[54];  
		DatagramPacket q = new DatagramPacket(rxbuffer,rxbuffer.length);
		
		
		
		timeStart = System.currentTimeMillis();
		timeNow = timeStart;
		
		if( echoRequestCode.length() == 5)
		
		{
			while( timeNow - timeStart <= 4*60000)
			
			{   
			
				timeSend = System.currentTimeMillis();
			
				s.send(p);
				n++;
		
				try 
				{
					r.receive(q);
					timeReceive = System.currentTimeMillis();
					message = new String(rxbuffer,0,q.getLength());
				} 
				
				catch (Exception x) 
				{
					System.out.println(x);
				}
			
				packets.println(message);
				responseTime.println(String.valueOf(timeReceive-timeSend));
			
				timeNow = System.currentTimeMillis();
		
			}
			
		}
		
		else 
		
		{
			
			for( i=0 ; i<100 ; i++){
				
				if( i<10 )	
					echoRequestCodeT = echoRequestCode + "0" + String.valueOf(i);
				else
					echoRequestCodeT = echoRequestCode + String.valueOf(i);
				

				packetInfo = echoRequestCodeT;
				txbuffer = packetInfo.getBytes();
				p.setData(txbuffer);
				p.setLength(txbuffer.length);
				

				s.send(p);
				n++;
				
				try 
				{
					r.receive(q);
					message = new String(rxbuffer,0,q.getLength());
				} catch (Exception x) {
					System.out.println(x);
				}
				
				packets.println(message);
				
			}
			
		}
		
		System.out.println("Number of packets: " + n);
		
		s.close();
		r.close();
		packets.close();
		responseTime.close();
		
	}
	
	
	
	private static void image() throws IOException{
		
		FileOutputStream image=new FileOutputStream("files/image.jpeg");
		
		DatagramSocket s = new DatagramSocket();
		
		String packetInfo = imageRequestCode;
		
		byte[] txbuffer = packetInfo.getBytes();
		int serverPort = Integer.parseInt(serverListeningPort);
		byte[] hostIP = { (byte)155,(byte)207,18,(byte)208 };
		InetAddress hostAddress = InetAddress.getByAddress(hostIP);		
		DatagramPacket p = new DatagramPacket(txbuffer,txbuffer.length, hostAddress,serverPort);
		

		DatagramSocket r = new DatagramSocket(Integer.parseInt(clientListeningPort));
		r.setSoTimeout(1000);

		byte[] rxbuffer = new byte[128];
		DatagramPacket q = new DatagramPacket(rxbuffer,rxbuffer.length);
		
		s.send(p);

		for (;;) {
			try
			{
				r.receive(q);
				image.write(rxbuffer);
				System.out.println(rxbuffer[1]);
			} 
			catch (Exception x) 
			{
				System.out.println(x);
				break;
			}
		}
		
		s.close();
		r.close();
		image.close();
	}
	
	
	
	
	private static void sound() throws IOException, LineUnavailableException{
		
		
		int pcmType = 1; 
		
		int numberOfSoundPackets = 999;
		int bytesPerPacket = 128;      
		int i = 0;
		byte[] audioDPCM = new byte[bytesPerPacket*numberOfSoundPackets];   
		int[] audioClipDiff = new int[128*numberOfSoundPackets*2];          
		int[] audioClip = new int[128*numberOfSoundPackets*2];            
		
		
		
		PrintWriter signalSamples = new PrintWriter("files/signal_samples.txt");
		PrintWriter signalSampleDiffs = new PrintWriter("files/signal_sample_diffs.txt");
		
		
		
		
	
		DatagramSocket s = new DatagramSocket();
		
		String packetInfo = soundRequestCode;  
		
		byte[] tbuffer = packetInfo.getBytes();
		int serverPort = Integer.parseInt(serverListeningPort);
		
		byte[] hostIPAdrress = { (byte)155,(byte)207,18,(byte)208 };
		
		InetAddress hostAddress = InetAddress.getByAddress(hostIPAdrress);		
		
		DatagramPacket p = new DatagramPacket(tbuffer, tbuffer.length, hostAddress,serverPort);
		
		DatagramSocket r = new DatagramSocket(Integer.parseInt(clientListeningPort));
		r.setSoTimeout(1000);
		
		byte[] rxbuffer = new byte[bytesPerPacket];
		DatagramPacket q = new DatagramPacket(rxbuffer,rxbuffer.length);
		
		
		s.send(p);
		
		for (;;) 
		{
			try 
			{
				r.receive(q);
				for( int j=0;j<bytesPerPacket;j++)
				{
					audioDPCM[i*bytesPerPacket+j] = rxbuffer[j];
				}
				i++;
				System.out.println(rxbuffer[0]);
			} 
			catch (Exception x) 
			{
				System.out.println(x);
				break;
			}
		}
		
		System.out.println("Packets received = " + i);
		
		
		
		if( pcmType == 1 ){
			
		
			AudioFormat linearPCM = new AudioFormat(8000,8,1,true,false);
			SourceDataLine lineOut = AudioSystem.getSourceDataLine(linearPCM);
			lineOut.open(linearPCM,bytesPerPacket*numberOfSoundPackets*2); 
			

			int temp = 0;
			for(i=0;i<bytesPerPacket*999;i++)
			{
				temp = (int)(audioDPCM[i]);
				audioClipDiff[2*i+1] = ( ( temp & 15 ) - 8);
				audioClipDiff[2*i] = ( ( ( temp >> 4 ) & 15 )- 8);
			}
			
			
			byte[] audioBufferOut = new byte[128*2*numberOfSoundPackets];
			
			for( i=1;i<256*999;i++)
				audioClip[i] = audioClipDiff[i];
			
			audioBufferOut[0] = (byte)(2*audioClip[0]);
			for( i=1;i<256*999;i++)
			{
				audioClip[i] =  2*audioClip[i] + audioBufferOut[i-1];
				audioBufferOut[i] = (byte)audioClip[i];	
			}
			
			for( i=0;i<256*999;i++)
			{
				signalSamples.println(audioBufferOut[i]);
				signalSampleDiffs.println(audioClipDiff[i]);
			}
			

			
			lineOut.start();
			lineOut.write(audioBufferOut,0,audioBufferOut.length);
			
			
			lineOut.stop();
			lineOut.close();
			s.close();
			r.close();
			
		}	
		
		
		if( pcmType == 2 ){
			
			PrintWriter means = new PrintWriter("files/means.txt");
			PrintWriter steps = new PrintWriter("files/steps.txt");
			
			int lsb = 0;
			int msb = 0;
			int[] mean = new int[numberOfSoundPackets];
			int[] step = new int[numberOfSoundPackets];
			
			AudioFormat linearPCM = new AudioFormat(8000,16,1,true,false);
			SourceDataLine lineOut = AudioSystem.getSourceDataLine(linearPCM);
			lineOut.open(linearPCM,bytesPerPacket*numberOfSoundPackets*2);     
			

			for ( i=0;i<numberOfSoundPackets;i++)
			{   
				lsb = (int)audioDPCM[132*i];
				msb = (int)audioDPCM[132*i+1];
				mean[i] = ( 256 * ( msb )) + (lsb & 0x00FF);
				
				lsb = (int)audioDPCM[132*i+2];
				msb = (int)audioDPCM[132*i+3];
				step[i] = ( 256 * ( msb & 0x00FF ) ) + (lsb & 0x00FF);

				
				System.out.println(mean[i]);
			}
			
			int temp = 0;
			int k = 0; 
			int j = 0;
			for(i=0;i<999;i++)
			{
				for( j=4; j<bytesPerPacket;j++)
				{  
				    temp = (int)(audioDPCM[i*132+j]);
					audioClipDiff[2*k+1] = ( ( temp & 15 ) - 8) * step[i];
					audioClipDiff[2*k] = ( ( ( temp >> 4 ) & 15 ) - 8) * step[i];
					k++;
				}	
			}

			
		    byte[] audioBufferOut = new byte[128*2*numberOfSoundPackets*2]; 
			
			for( i=1;i<256*999;i++)
				audioClip[i] = audioClipDiff[i];
			
			for(i=0;i<999;i++)
			{
				for( j=0; j<256;j++)
				{
					if( i==0 && j==0 ) continue;
					audioClip[i*256+j] =  audioClip[i*256+j] + audioClip[i*256+j-1];	
				}
			}
			
			for( i=0;i<999*256;i++)
			{
				audioBufferOut[2*i] = (byte)(audioClip[i] & 0xFF);
				audioBufferOut[2*i+1] = (byte)((audioClip[i] >> 8) & 0xFF);
			}
			

			for( i=0;i<256*999;i++)
			{
				signalSamples.println(audioBufferOut[i]);
				signalSampleDiffs.println(audioClipDiff[i]);
			}
			
			for( i=0;i<999;i++ )
			{
				means.println(mean[i]);
				steps.println(step[i]);
			}
						
			
			lineOut.start();
			lineOut.write(audioBufferOut,0,audioBufferOut.length);
			
			
			lineOut.stop();
			lineOut.close();
			s.close();
			r.close();
			means.close();
			steps.close();
			
		}
		
		signalSamples.close();
		signalSampleDiffs.close();
			
	}
	

	
}

