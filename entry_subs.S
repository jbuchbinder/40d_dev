///////////////////////////////////////////////////////////////////////////////////////
//	stubs for 1000d based off of 450d project from engelmarkus - thank you for your help!
//	initial testings for Canon Rebel XS / 1000d.
//
//	by: Coutts
///////////////////////////////////////////////////////////////////////////////////////

.text
.org 0


#define NSTUB(name,addr) \
.global name; \
name = addr

//my_romStart_FF8100DC
NSTUB(off_FFD51890, 0xFFD51890)
NSTUB(unknown_cache_FF81011C, 0xFF81011C)

//my_usrInit_FF810FC8
NSTUB(sysStart_FF810F74, 0xFF810F74)
NSTUB(cacheLibInit_FFD43734, 0xFFD43734)
NSTUB(excVecInit_FFD503B0, 0xFFD503B0)
NSTUB(sysHwInit_FF8103C8, 0xFF8103C8)
NSTUB(sub_FF810B54, 0xFF810B54)

//my_usrInit_1_FF810B7C
NSTUB(classLibInit_FFD43348, 0xFFD43348)
NSTUB(taskLibInit_FFD333F4, 0xFFD333F4)
NSTUB(qInit_FFD35EA4, 0xFFD35EA4)
NSTUB(sub_FFD30180, 0xFFD30180)
NSTUB(sub_FF810504, 0xFF810504)
NSTUB(kernelInit_FFD35290, 0xFFD35290)

//my_usrRoot_my_usrRoot_FF8110BC
NSTUB(sub_FF811004, 0XFF811004)
NSTUB(memInit_FFD3DDC8, 0xFFD3DDC8)
NSTUB(sub_FFD3D62C, 0xFFD3D62C)
NSTUB(usrMmuInit_FF810C50, 0xFF810C50)
NSTUB(sysClockInit_FF810B28, 0xFF810B28)
NSTUB(selectInit_FFD3BCBC, 0xFFD3BCBC)
NSTUB(usrRoot_init0_FF811058, 0xFF811058)
NSTUB(usrRoot_init1_FF811030, 0xFF811030)
NSTUB(usrRoot_init2_FF81108C, 0xFF81108C)
NSTUB(selTaskDeleteHookAdd_FFD3BC54, 0xFFD3BC54)
NSTUB(sub_FFD50CC0, 0xFFD50CC0)

//my_task_Startup_FF81132C
NSTUB(aK254, 0xFF81129C)
NSTUB(sub_FFD16DB4, 0xFFD16D84)
NSTUB(a2009_09_25144532, 0xFF8112AC)
NSTUB(a3_7_7, 0xFF8112A4)
NSTUB(aSReadyVerSBuildDateS, 0xFF811240)
NSTUB(printf_FFD421C0, 0xFFD421C0)
NSTUB(my_9D8000, 0x9D8000)
NSTUB(sub_FFD1FDF8, 0xFFD1FDF8)
NSTUB(sub_FFCFC4C8, 0xFFCFC4C8)
NSTUB(sub_FFD1CBF0, 0xFFD1CBF0)
NSTUB(InitializeKernel_FFD0557C, 0xFFD0557C)
NSTUB(sub_FFD1B5A8, 0xFFD1B5A8)
NSTUB(sub_FFD058B8, 0xFFD058B8)
NSTUB(FlushWriteCache_1_FFD0CA18, 0xFFD0CA18)
NSTUB(sub_FFCFF7A0, 0xFFCFF7A0)
NSTUB(Install3VMemory_FFD17E9C, 0xFFD17E9C)
NSTUB(RegisterISRs_OCH_FFD01A80, 0xFFD01A80)
NSTUB(InitializeTimerSystem_FFD0CD78, 0xFFD0CD78)
NSTUB(InitializeHPTimerSystem_FFD004F0, 0xFFD004F0)
NSTUB(ResourceNameServiceInit_FFD0AC3C, 0xFFD0AC3C)
NSTUB(sub_FFD08FEC, 0xFFD08FEC)
NSTUB(sub_FFD01DA8, 0xFFD01DA8)
NSTUB(sysClockRateSet_100_FFD1753C, 0xFFD1753C)
NSTUB(InitializeSerialIO_FFD173C0, 0xFFD173C0)
NSTUB(sub_FFD1B808, 0xFFD1B808)
NSTUB(RtcInit_FFCFD72C, 0xFFCFD72C)
NSTUB(InitHPC_FFD1A844, 0xFFD1A844)
NSTUB(sub_FF819E44, 0xFF819E44)
NSTUB(PowerMgrInit_FFD1B978, 0xFFD1B978)
NSTUB(DisablePowerSave_FFD1B9D4, 0xFFD1B9D4)
NSTUB(sub_FFD0D494, 0xFFD0D494)
NSTUB(sub_FFD0D998, 0xFFD0D998)
NSTUB(aStartupeventflag, 0xFF8112C0)
NSTUB(CreateEventFlag_FFD03214, 0xFFD03214)
NSTUB(Startup_TaskMain_FF81195C, 0xFF81195C)
NSTUB(aTaskmain, 0xFF8112D4)
NSTUB(CreateTask_FFD05A54, 0xFFD05A54)
NSTUB(sub_FFD0D740, 0xFFD0D740)
NSTUB(aDumpall, 0xFF8112E0)
NSTUB(loc_FF812B88, 0xFF812B88)
NSTUB(Register_Func_with_Name_FFD100C8, 0xFFD100C8)
NSTUB(Setup_Bootstyle_FuncTable_FFD211B0, 0xFFD211B0)
NSTUB(sub_FFD1888C, 0xFFD1888C)
NSTUB(aUpdate, 0xFF8112E8)
NSTUB(Update_FFD20F3C, 0xFFD20F3C)
NSTUB(aLv_on, 0xFF8112F0)
NSTUB(Lv_on_FF812CE0, 0xFF812CE0)
NSTUB(aSend_mpu_0, 0xFF8112F8)
NSTUB(Send_mpu_FF811158, 0xFF811158)
NSTUB(aHeap, 0xFF811304)
NSTUB(sub_FF812C5C, 0xFF812C5C)
NSTUB(aSetrefreshtime, 0xFF81130C)
NSTUB(Set_refresh_time_FF812C4C, 0xFF812C4C)
NSTUB(aLampoff, 0xFF81131C)
NSTUB(Lamp_off_FF812D10, 0xFF812D10)
NSTUB(aTftoff, 0xFF811324)
NSTUB(loc_FF812D20, 0xFF812D20)
NSTUB(taskcreate_CmdShell_FFD10074, 0xFFD10074)






//other
NSTUB(eventproc_RiseEvent, 0xFFCFF728)
NSTUB(msleep, 0xFFD05708)
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
NSTUB(malloc, 0xFFD3CC64)
NSTUB(free, 0xFFD3CC4C)
NSTUB(ReceiveMessageQueue, 0xFFD03FDC)
NSTUB(CreateMessageQueue, 0xFFD03C60)
NSTUB(TryReceiveMessageQueue, 0xFFD04288)
NSTUB(PostMessageQueue, 0xFFD04464)
NSTUB(TryPostMessageQueue, 0xFFD046C0)
NSTUB(printf, 0xFFD421C0)
NSTUB(printf_log, 0xFFD0D5F4)
NSTUB(EnableBootDisk, 0xFFD21248)
NSTUB(DisableBootDisk, 0xFFD21260)


NSTUB(prop_request_change, 0xFFC3ED7C)

.align 2


