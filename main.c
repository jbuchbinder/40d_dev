#include "main.h"

#define LEDRED (*((int*)0xC02200A0))
#define LEDBLUE (*((int*)0xC02200E8))
#define LEDON   0x46
#define LEDOFF  0x44

#define isolc (*((int*)0x00003F98))

#define MY_MESS1 0x01

void* hMyTaskMessQue;
void* hMainMessQueue; // = (int*) (0x00036C00);

void MyGlobalStdSet ()
{ int f1 = -1;
  while (f1==-1)  { f1=FIO_CreateFile("B:/STDOUT.TXT");  if (f1==-1) SleepTask(100); }
  ioGlobalStdSet(1,f1);    //ioGlobalStdSet(2,f1);
}



void dumpmemo()
{
  FIO_RemoveFile("B:/RAMDUMP.BIN");
  int f = FIO_CreateFile("B:/RAMDUMP.BIN");

  if (f!=-1) { 
	  FIO_WriteFile(f, (void*)0xFFFF0000, 4);
      FIO_WriteFile(f, (void*)4, 0x1900-4);
      FIO_WriteFile(f, (void*)0x1900, 32*1024*1024-0x1900);

    FIO_CloseFile(f);
	}

	f = FIO_OpenFile("B:/ROMDUMP.BIN", 0, 0644);
	FIO_CloseFile(f);

  if (f==-1) { 
	LEDBLUE=LEDON;
	f = FIO_CreateFile("B:/ROMDUMP.BIN");		
    FIO_WriteFile(f, (void*)0xFF800000, 8*1024*1024);
    FIO_CloseFile(f);
	}
}


void MyTask ()
{
// int* isoolc=(int*)(0x3F68);
// int pMessage[32];
// int i = 0;
 //int* pMessage; //= (int*)malloc(32);
 //int rr, d;
//int a= 0x01;

 
  SleepTask(2500);
//hMainMessQueue = *((int *) 0x00036C00);

  // LEDBLUE=LEDON;
 //isolc = 0x33;
 //SleepTask(10000);
//MyGlobalStdSet();
//dumpf();

 //  pMessage[0]= 0x00036C00;  pMessage[1] = 0xF8000000;
 //pMessage[2]= 0x55555555;  pMessage[3] = 0x800000;
 
// while (i < 16) {
 //pMessage[0] = &pMessage[1] ; 
 
 // pMessage[2] = i*8;
 //pMessage[1] = i;
 //rr = ReceiveMessageQueue(hMainMessQueue,&pMessage,0);
 //rr = TryPostMessageQueue(hMainMessQueue,pMessage[0],0);
//	//	TryReceiveMessageQueue(hMyTaskMessQue,&pMessage,0);
	//	TryReceiveMessageQueue(hMyTaskMessQue,&pMessage,0);		
	//SleepTask(100);
/*	switch (pMessage[0]) {
						case MY_MESS1: 
  
						LEDBLUE=LEDON;
						SleepTask(700);
						LEDBLUE=LEDOFF;
						break;
      //dumpf();
						}
						//SleepTask(1000);
			*/
			//debug_print("\n%02d rr=%08x pm = %08x,%08x \n", i, rr, pMessage[0], pMessage[1]);
			//SleepTask(500);
			//i++;
			//free(pMessage);
		//	}
			
while (1){
LEDBLUE=LEDON;
SleepTask(100);
LEDBLUE=LEDOFF;
SleepTask(100);
//SleepTask(5000);
*((int *)0x000175A0) = (int) 0x33;
*((int *)0x000175A0) = (int) 0x33;

*((int *)0x00003F98) = (int) 0x33;
*((int *)0x00527888) = (int) 0x33;
*((int *)0x005E45DC) = (int) 0x33;


}

}

void MyTask2 ()
{
MyGlobalStdSet();
SleepTask(5000);
/*
*((int *)0x00003F98) = (int) 0x33;
*((int *)0x00527888) = (int) 0x33;
*((int *)0x005E45DC) = (int) 0x33;
*/
printf_log (0,5,"\nMMMMM %02d %02d %03d\n", 1, 2 , 3); 


SleepTask(15000);
dumpf();
SleepTask(2000);
//dumpmemo();
LEDBLUE=LEDON;

}

void CreateMyTask()
{
//  hMyTaskMessQue=(void*)CreateMessageQueue("MyTaskMessQue",0x40);
//  CreateTask("MyTask", 0x19, 0x2000, MyTask, 0);
  CreateTask("MyTask2", 0x1A, 0x2000, MyTask2, 0);	
}


