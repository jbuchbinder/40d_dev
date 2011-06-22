	.text
	.org 0
///////////////////////////////////////////////////////////////////////////////////////
//	stubs for 1000d based off of 450d project from Indy - thank you for your help!
//	initial testings for Canon Rebel XS / 1000d.
//
//	by: Coutts
///////////////////////////////////////////////////////////////////////////////////////
	
#define DEF(n,a)\
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




////////////////////////////////////////////////////////
//		stubs used in entry.S
//
//	entry.S is copied directly from the 1000d dump
////////////////////////////////////////////////////////

//my_romStart
NSTUB(unknown_cache, 0xFF81011C)

//my_usrInit
NSTUB(sysStart, 0xFF810F74)
NSTUB(cacheLibInit, 0xFFD43734)
NSTUB(excVecInit, 0xFFD503B0)
NSTUB(sysHwInit, 0xFF8103C8)
STUB(FF810B54)

//my_usrInit_1
NSTUB(classLibInit, 0xFFD43348)
NSTUB(taskLibInit, 0xFFD333F4)
NSTUB(qInit, 0xFFD35EA4)
DEF(activeQHead, 0x113E4)
STUB(FFD30180)
STUB(FF810504)
NSTUB(kernelInit, 0xFFD35290)

//my_usrRoot
STUB(FF811004)
NSTUB(memInit, 0xFFD3DDC8)
STUB(FFD3D62C)
NSTUB(usrMmuInit, 0xFF810C50)
NSTUB(sysClockInit, 0xFF810B28)
NSTUB(selectInit, 0xFFD3BCBC)
NSTUB(usrRoot_init0, 0xFF811058)
NSTUB(usrRoot_init1, 0xFF811030)
NSTUB(usrRoot_init2, 0xFF81108C)
NSTUB(selTaskDeleteHookAdd, 0xFFD3BC54)
STUB(FFD50CC0)

//my_task_Startup
DEF(aK254, 0xFF81129C)
STUB(FFD16DB4)
DEF(a2009_09_251445, 0xFF8112AC)
DEF(a3_7_7, 0xFF8112A4)
DEF(aSReadyVerSBuil, 0xFF811240)
NSTUB(debug_print, 0xFFD421C0)
STUB(FFD1FDF8)
STUB(FFCFC4C8)
STUB(FFD1CBF0)
NSTUB(InitializeKernel, 0xFFD0557C)
STUB(FFD1B5A8)
STUB(FFD058B8)
NSTUB(FlushWriteCache_1, 0xFFD0CA18)
STUB(FFCFF7A0)
NSTUB(Install3VMemory, 0xFFD17E9C)
NSTUB(RegisterISRs_OCH, 0xFFD01A80)
NSTUB(InitializeTimerSystem, 0xFFD0CD78)
NSTUB(InitializeHPTimerSystem, 0xFFD004F0)
NSTUB(ResourceNameServiceInit, 0xFFD0AC3C)
STUB(FFD08FEC)
STUB(FFD01DA8)
NSTUB(sysClockRateSet_100, 0xFFD1753C)
NSTUB(InitializeSerialIO, 0xFFD173C)
STUB(FFD1B808)
NSTUB(RtcInit, 0xFFCFD72C)
NSTUB(InitHPC, 0xFFD1A844)
DEF(loc_FF819E44, 0xFF819E44)
NSTUB(PowerMgrInit, 0xFFD1B978)
NSTUB(DisablePowerSave, 0xFFD1B9D4)
STUB(FFD0D494)
STUB(FFD0D998)
DEF(aStartupeventfl, 0xFF8112C0)
NSTUB(CreateEventFlag, 0xFFD03214)
DEF(Startup_TaskMain, 0xFF81195C)
DEF(aTaskmain, 0xFF8112D4)
NSTUB(CreateTask, 0xFFD05A54)
STUB(FFD0D740)
DEF(aDumpall, 0xFF8112E0)
DEF(dumpall, 0xFF812B88)
NSTUB(Register_Func_with_Name, 0xFFD100C8)
NSTUB(Setup_Bootstyle_FuncTable, 0xFFD211B0)
STUB(FFD1888C)
DEF(aUpdate, 0xFF8112E8)
DEF(Update, 0xFFD20F3C)
DEF(aLv_on, 0xFF8112F0)
DEF(lv_on, 0xFF812CE0)
DEF(aSend_mpu, 0xFF8112F8)
DEF(send_mpu, 0xFF811158)
DEF(aHeap, 0xFF811304)
DEF(heap, 0xFF812C5C)
DEF(aSetrefreshtime, 0xFF81130C)
DEF(SetRefreshTime, 0xFF812C4C)
DEF(aLampoff, 0xFF81131C)
DEF(lamp_off, 0xFF812D10)
DEF(aTftoff, 0xFF811324)
DEF(TftOff, 0xFF812D20)
NSTUB(taskcreate_CmdShell, 0xFFD10074)


//////////////////////////////////////////////////////////////////
//		stubs used elsewhere throughout the project
//////////////////////////////////////////////////////////////////

NSTUB(SleepTask, 0xFFD05708)
NSTUB(FIO_RemoveFile, 0xFFCDD564)
NSTUB(FIO_CreateFile, 0xFFCDD558)
NSTUB(FIO_CloseFile, 0xFFCDD570)
NSTUB(FIO_WriteFile, 0xFFCDD588)
NSTUB(FIO_SeekFile, 0xFFCDD594)
NSTUB(FIO_ReadFile, 0xFFCDD57C)
NSTUB(FIO_OpenFile, 0xFFCDD54C)
NSTUB(ioGlobalStdSet, 0xFFD3F214)
NSTUB(dumpf, 0xFFD0E1C4)
NSTUB(malloc, 0xFFD3CC64)
NSTUB(free, 0xFFD3CC4C)
NSTUB(ReceiveMessageQueue, 0xFFD03FDC)
NSTUB(CreateMessageQueue, 0xFFD03C60)
NSTUB(TryReceiveMessageQueue, 0xFFD04288)
NSTUB(PostMessageQueue, 0xFFD04464)
NSTUB(TryPostMessageQueue, 0xFFD046C0)
NSTUB(printf_log, 0xFFD0D5F4)
NSTUB(EdLedOn, 0xFFCFD458)
.align 2
