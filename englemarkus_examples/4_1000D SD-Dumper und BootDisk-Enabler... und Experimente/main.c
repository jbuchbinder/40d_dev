#define LED_RED     0xC02200E0
#define LED_BLUE    0xC02200E8

extern void SleepTask(long msec);
extern int CreateTask (const char *name, int prio, int stack_size /*?*/, void *entry, long parm /*?*/);

extern int FIO_CreateFile( const char *name );
extern int FIO_WriteFile(int f, void *buf, long size);
extern int FIO_CloseFile( int f );

typedef void (*Funktion)();

void MyTask2() {
  /*while (1) {
    SleepTask(500);
    *((volatile long*)LED_BLUE) = 0x46;
    SleepTask(500);
    *((volatile long*)LED_BLUE) = 0x44;
  }*/
  
/*  SleepTask(15000);
  dumpf();
 */ SleepTask(5000);
  
  int handle = FIO_CreateFile("B:/dump1.bin");
  
  FIO_WriteFile(handle, (void*)0xFFFF0000, 4);
  FIO_WriteFile(handle, (void*)4, 0x1900-4);
  FIO_WriteFile(handle, (void*)0x1900, 32*1024*1024-0x1900);

  FIO_CloseFile(handle);  
  
  
  *((volatile long*)LED_BLUE) = 0x46;
  
// EnableBootDisk()  
  /*Funktion f = 0xFFD21248;
  f();
  *((volatile long*)LED_BLUE) = 0x46;
 Das oben führt EnableBootDisk() aus.
   Wenn man eine normale SD-Karte reinsteckt, läuft alles ganz normal.
   Wenn man eine SD-Karte reinsteckt mit EOS_DEVELOP (?) und BOOTDISK, dann
   muss auf der Karte eine gültige FIR-Datei mit dem Namen "AUTOEXEC.BIN" sein,
   sonst ist die Kamera tot. Scheinbar wird die aber schon ausgeführt, sobald
   man den Deckel zumacht? Und wenn man sie rausnimmt, hängt sich die Kamera
   auf, auch wenn sie auf OFF war?
   Er führt die AUTOEXEC.BIN auch aus, wenn man die Karte nicht schreibgeschützt
   hatte?!
  */
  
  /*
  NEU:
  Nach dem Ausführen der Funktion muss man scheinbar einmal den Akku rausnehmen,
  damit das richtig funktioniert...
  Wenn man eine nicht bootfähige SD-Karte reinsteckt, passiert gar nix...
  Steckt man eine bootfähige mit einer ungültigen AUTOEXEC.BIN rein, beginnt
  sofort die blaue LED zu leuchten.
  Steckt man eine bootfähige mit einer FIR-Datei rein, die AUTOEXEC.BIN heißt,
  blitzt die blaue LED kurz, danach kann man mit der Kamera normal arbeiten...
  bei jedem Einschalten wir die AUTOEXEC.BIN geladen...
  Wenn man einfach einen SD-ROM-Dump draufkopiert und umbenennt, geht gar nix...
  
  */

// DisableBootDisk()
/*  Funktion f = 0xFFD21260;
  f();
  *((volatile long*)LED_BLUE) = 0x46;*/
/* Damit kann man den Standard wiederherstellen, danach treten die obigen
   Probleme nicht mehr auf... */
  
}

void CreateMyTask() {
  CreateTask("MyTask2", 0x1A, 0x2000, MyTask2, 0);
}

