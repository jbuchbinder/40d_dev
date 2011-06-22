///////////////////////////////////////////////////////////////////////////////////////
//	stubs for 1000d based off of 450d project from engelmarkus - thank you for your help!
//	initial testings for Canon Rebel XS / 1000d.
//
//	by: Coutts
///////////////////////////////////////////////////////////////////////////////////////

    .text
    .org 0


#define DEF(n,a) \
    .globl n; n = a

#define NSTUB(name, addr)\
    .globl name ;\
    .weak name ;\
    name: ;\
	ldr  pc, = addr

#define NHSTUB(name, addr)\
    .globl name ;\
    name: ;\
	ldr  pc, = addr

#define STUB(addr)\
    .globl sub_ ## addr ;\
    sub_ ## addr: ;\
	ldr  pc, =0x ## addr

//my_romStart_FF8100DC
DEF(off_FFD51890, 0xFFD51890)
NSTUB(unknown_cache_FF81011C, 0xFF81011C)

//my_usrInit_FF810FC8
NSTUB(sysStart_FF810F74, 0xFF810F74)
NSTUB(cacheLibInit_FFD43734, 0xFFD43734)
NSTUB(excVecInit_FFD503B0, 0xFFD503B0)
NSTUB(sysHwInit_FF8103C8, 0xFF8103C8)
STUB(FF810B54)

//my_usrInit_1_FF810B7C
NSTUB(classLibInit_FFD43348, 0xFFD43348)
NSTUB(taskLibInit_FFD333F4, 0xFFD333F4)
NSTUB(qInit_FFD35EA4, 0xFFD35EA4)
//DEF(activeQHead, 0x11844)
STUB(FFD30180)
STUB(FF810504)
NSTUB(kernelInit_FFD35290, 0xFFD35290)

//my_usrRoot_my_usrRoot_FF8110BC
STUB(FF811004)
NSTUB(memInit_FFD3DDC8, 0xFFD3DDC8)
STUB(FFD3D62C)
NSTUB(usrMmuInit_FF810C50, 0xFF810C50)
NSTUB(sysClockInit_FF810B28, 0xFF810B28)
NSTUB(selectInit_FFD3BCBC, 0xFFD3BCBC)
NSTUB(usrRoot_init0_FF811058, 0xFF811058)
NSTUB(usrRoot_init1_FF811030, 0xFF811030)
NSTUB(usrRoot_init2_FF81108C, 0xFF81108C)
NSTUB(selTaskDeleteHookAdd_FFD3BC54, 0xFFD3BC54)
STUB(FFD50CC0)

//my_task_Startup_FF81132C
DEF(aK254, 0xFF81129C)
STUB(FFD16DB4)
DEF(a2009_09_25144532, 0xFF8112AC)
DEF(a3_7_7, 0xFF8112A4)
DEF(aSReadyVerSBuildDateS, 0xFF811240)
NSTUB(printf_FFD421C0, 0xFFD421C0)
STUB(FFD1FDF8)
STUB(FFCFC4C8)
STUB(FFD1CBF0)
NSTUB(InitializeKernel_FFD0557C, 0xFFD0557C)
STUB(FFD1B5A8)
STUB(FFD058B8)
NSTUB(FlushWriteCache_1_FFD0CA18, 0xFFD0CA18)
STUB(FFCFF7A0)
NSTUB(Install3VMemory_FFD17E9C, 0xFFD17E9C)
NSTUB(RegisterISRs_OCH_FFD01A80, 0xFFD01A80)
NSTUB(InitializeTimerSystem_FFD0CD78, 0xFFD0CD78)
NSTUB(InitializeHPTimerSystem_FFD004F0, 0xFFD004F0)
NSTUB(ResourceNameServiceInit_FFD0AC3C, 0xFFD0AC3C)
STUB(FFD08FEC)
STUB(FFD01DA8)
NSTUB(sysClockRateSet_100_FFD1753C, 0xFFD1753C)
NSTUB(InitializeSerialIO_FFD173C0, 0xFFD173C0)
STUB(FFD1B808)
NSTUB(RtcInit_FFCFD72C, 0xFFCFD72C)
NSTUB(InitHPC_FFD1A844, 0xFFD1A844)
STUB(FF819E44)
NSTUB(PowerMgrInit_FFD1B978, 0xFFD1B978)
NSTUB(DisablePowerSave_FFD1B9D4, 0xFFD1B9D4)
STUB(FFD0D494)
STUB(FFD0D998)
DEF(aStartupeventflag, 0xFF8112C0)
NSTUB(CreateEventFlag_FFD03214, 0xFFD03214)
DEF(Startup_TaskMain_FF81195C, 0xFF81195C)
DEF(aTaskmain, 0xFF8112D4)
NSTUB(CreateTask_FFD05A54, 0xFFD05A54)
STUB(FFD0D740)
DEF(aDumpall, 0xFF8112E0)
DEF(loc_FF812B88, 0xFF812B88)
NSTUB(Register_Func_with_Name_FFD100C8, 0xFFD100C8)
NSTUB(Setup_Bootstyle_FuncTable_FFD211B0, 0xFFD211B0)
STUB(FFD1888C)
DEF(aUpdate, 0xFF8112E8)
DEF(Update_FFD20F3C, 0xFFD20F3C)
DEF(aLv_on, 0xFF8112F0)
DEF(Lv_on_FF812CE0, 0xFF812CE0)
DEF(aSend_mpu_0, 0xFF8112F8)
DEF(Send_mpu_FF811158, 0xFF811158)
DEF(aHeap, 0xFF811304)
DEF(sub_FF812C5C, 0xFF812C5C)
DEF(aSetrefreshtime, 0xFF81130C)
DEF(Set_refresh_time_FF812C4C, 0xFF812C4C)
DEF(aLampoff, 0xFF81131C)
DEF(Lamp_off_FF812D10, 0xFF812D10)
DEF(aTftoff, 0xFF811324)
DEF(loc_FF812D20, 0xFF812D20)
NSTUB(taskcreate_CmdShell_FFD10074, 0xFFD10074)






//other
NSTUB(eventproc_RiseEvent, 0xFFCFF728)
NSTUB(SleepTask, 0xFFD05708)
NSTUB(CreateTask, 0xFFD05A54)
NSTUB(dumpf, 0xFFD0E1C4)
NSTUB(FIO_OpenFile, 0xFFCDD54C)
NSTUB(FIO_CreateFile, 0xFFCDD558)
NSTUB(FIO_RemoveFile, 0xFFCDD564)
NSTUB(FIO_CloseFile, 0xFFCDD570)
NSTUB(FIO_ReadFile, 0xFFCDD57C)
NSTUB(FIO_WriteFile, 0xFFCDD588)
NSTUB(FIO_SeekFile, 0xFFCDD594)
NSTUB(ioGlobalStdSet, 0xFFD3F214)
DEF(malloc, 0xFFD3CC64)
DEF(free, 0xFFD3CC4C)
DEF(ReceiveMessageQueue, 0xFFD03FDC)
DEF(CreateMessageQueue, 0xFFD03C60)
DEF(TryReceiveMessageQueue, 0xFFD04288)
DEF(PostMessageQueue, 0xFFD04464)
DEF(TryPostMessageQueue, 0xFFD046C0)
NSTUB(printf, 0xFFD421C0)
NSTUB(printf_log, 0xFFD0D5F4)
NSTUB(EnableBootDisk, 0xFFD21248)
NSTUB(DisableBootDisk, 0xFFD21260)

.align 2



