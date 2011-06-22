extern void SleepTask(long msec);
extern int CreateTask (const char *name, int prio, int stack_size /*?*/, void *entry, long parm /*?*/);

extern int FIO_CreateFile( const char *name );
extern int FIO_WriteFile(int f, void *buf, long size);
extern int FIO_CloseFile( int f );
extern void dumpf(void);
extern void EnableBootDisk(void);
extern void DisableBootDisk(void);

typedef void (*Funktion)();