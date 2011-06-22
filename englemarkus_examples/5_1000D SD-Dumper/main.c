#define LED_RED     0xC02200E0
#define LED_BLUE    0xC02200E8

extern void SleepTask(long msec);
extern int CreateTask (const char *name, int prio, int stack_size /*?*/, void *entry, long parm /*?*/);

extern int FIO_CreateFile( const char *name );
extern int FIO_WriteFile(int f, void *buf, long size);
extern int FIO_CloseFile( int f );

extern void eventproc_RiseEvent(char* name);

typedef void (*Funktion)();


void MyGlobalStdSet ()
{ int f1 = -1;
  while (f1==-1)  { f1=FIO_CreateFile("B:/STDOUT.TXT");  if (f1==-1) SleepTask(100); }
  ioGlobalStdSet(1,f1);
}

typedef void (*Funktion2)(int p1);

void MyTask2() {
//  SleepTask(15000);
//  dumpf();
  SleepTask(7000);
  
//  Funktion2 f = 0xFF8956C4;
//  f(0xD);

  int* adr = 0x4020;
  (*adr) = 0x5;

  Funktion2 f = 0xFF8956C4;
  f(0x5);

// Der erste Eintrag ist 3!!!
// Der zweite ist 4, der dritte 5...

// Die 450D hat tatsächlich 4 Einträge, von 0xA bis 0xD, wobei diese eine andere
// "Nummerierung" haben: 3, 4, 1, 5
// Spot Metering ist dabei allerdings der dritte Eintrag, also der mit der "1"!

// Fast derselbe Code wie beim Setzen taucht auch in "MoveItemFocus Event" auf...
// Spot metering zu aktivieren wird kompliziert, weil ja die Adressen hard-
// coded sind, und man in den Flash nicht einfach den zusätzlichen Datenblock
// schreiben kann...







  
//  Funktion f = 0xFF86CFC0; //0xFF93F8D4; öffnet LCD-Helligkeit... Fehlerhafte Anzeige beim Rausgehen... 
//  f();
  
/*  MyGlobalStdSet();
  
  printf("\n\nJetzt kommt memShow_FFD18C04:\n\n");
  
  Funktion f;
  
  f = 0xFFD18C04;
  f();
  
  printf("\n\nJetzt kommt i_FFD1AC84:\n\n");
  
  f = 0xFFD1AC84;
  f();
  
  printf("\n\nJetzt kommt taskShow_FFD18BBC:\n\n");
  
  f = 0xFFD18BBC;
  f();
  
  printf("\n\n Fertig!\n\n");
  */
  
/*  int handle = FIO_CreateFile("B:/ROMDUMP.BIN");
  
  FIO_WriteFile(handle, (void*)0xFF800000, 8*1024*1024);
  FIO_CloseFile(handle);  
  
  handle = FIO_CreateFile("B:/RAMDUMP.BIN");

  FIO_WriteFile(handle, (void*)0xFFFF0000, 4);
  FIO_WriteFile(handle, (void*)4, 0x1900-4);
  FIO_WriteFile(handle, (void*)0x1900, 32*1024*1024-0x1900);

  FIO_CloseFile(handle);
  */
//  Funktion f = 0xFF812C5C;
//  f();
    
  *((volatile long*)LED_BLUE) = 0x46;
  
  //dumpf();
}

void CreateMyTask() {
  CreateTask("MyTask2", 0x1A, 0x2000, MyTask2, 0);
}

