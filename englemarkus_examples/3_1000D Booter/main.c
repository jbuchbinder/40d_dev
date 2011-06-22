#define LED_RED     0xC02200E0
#define LED_BLUE    0xC02200E8

extern void SleepTask(long msec);
extern int CreateTask (const char *name, int prio, int stack_size /*?*/, void *entry, long parm /*?*/);

void MyTask2() {
  while (1) {
    SleepTask(500);
    *((volatile long*)LED_BLUE) = 0x46;
    SleepTask(500);
    *((volatile long*)LED_BLUE) = 0x44;
  }
}

void CreateMyTask() {
  CreateTask("MyTask2", 0x1A, 0x2000, MyTask2, 0);
}

