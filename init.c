#include "main.h"

#include "init.h"

extern void COPY();

void my_romStart(int startType);
int  my_usrInit(int startType);
int  my_usrRoot(char* pMemPoolStart, unsigned int memPoolSize);

void my_taskcreate_Startup();
void my_task_Startup();
int  my_InitializeIntercom();

void COPY()
{
	int i;
	
	long *from = (long*) 0x800000;
	long *to   = (long*) 0x7F0000;
	
	for (i = 0; i < 0x4000; i++) {
		to[i] = from[i];
	}
}

// entry routine, entry.S calls this, so we enter here after power up.
void my_romStart(int startType)
{
	unknown_cache(&off_FFD51890, &addr_0x1900, 0x35f40 >> 2);
	my_usrInit(startType);
}

int my_usrInit(int startType)
{
	sysStart()
	cacheLibInit(1, 2);
	excVecInit();
	sysHwInit();
	sub_FF810B54();
	my_usrInit_1();
}


void my_usrInit_1()
{
	classLibInit();
	taskLibInit();
	qInit(&readyQHead, qPriBMapClassId, &readyQBMap, 0x100); 
	qInit(&activeQHead, qFifoClassId);
	qInit(&tickQHead,   qPriListClassId);
	workQInit();
	sub_FF810504();
	kernelInit(my_usrRoot, 0x4000, &off_37840, sysMemTop(), 0xC00);
	return 0;
}

int my_sub_FF811004(char* pMemPoolStart, unsigned int memPoolSize)
{
	nullsub_307();
	semBLibInit();
	semMLibInit();
	semCLibInit();
	semQLibInit();
	wdLibInit();
	taskHookInit();	
}

int my_usrRoot(char* pMemPoolStart, unsigned int memPoolSize)
{
	my_sub_FF811004(pMemPoolStart, memPoolSize);
	memInit(pMemPoolStart, memPoolSize);
	memPartLibInit(pMemPoolStart, memPoolSize);
	usrMmuInit();
	sysClockInit();
	selectInit(0x32);
	usrRoot_init0();
	usrRoot_init1();
	usrRoot_init2();
	selTaskDeleteHookAdd();
	sub_FFD50CC0();
	my_taskcreate_Startup();
	return 0;
}

void my_taskcreate_Startup()
{
	sub_FFD16DB4(0xC0220094);
	debug_printf(&aSReadyVerSBuil, &aK254, &a3_7_7, &a2009_09_251445);
	sub_FFD1FDF8();
	sub_FFCFC4C8();
	sub_FFD1CBF0(0x1C0000, &off_9D8000);
	InitializeKernel();
	sub_FFD1B5A8(0x386D4380);		//needs looked at - dealing with SP
	sub_FFD058B8();
	FlushWriteCache_1();
	sub_FFCFF7A0();
	Install3VMemory(0xF8000000);
	RegisterISRs_OCH();
	InitializeTimerSystem(0x32);
	InitializeHPTimerSystem(0x10, 0x8, &off_1BC4);
	ResourceNameServiceInit();
	sub_FFD08FEC(0);
	sub_FFD01DA8();
	sysClockRateSet_100(3);
	InitializeSerialIO();
	sub_FFD1B808(0x386D4380, 0x386D4384);			//needs looked at - SP related
	RtcInit(0x386D4384);							// ????
	InitHPC();
	PowerMgrInit(sub_FF819E44);
	DisablePowerSave();
	sub_FFD0D494(0x1F, 0x180000, 0x40000);
	sub_FFD0D998(0xFFFFFFFF, 0x3);
	CreateEventFlag("StartupEventFlag", 0);
	CreateTask("TaskMain", 0x18, 0x1800, my_Startup_TaskMain, 0);
	sub_FFD0D740();
	Register_Func_with_Name("dumpall", 0, &aDumpall);
	Setup_Bootstyle_FuncTable();
	sub_FFD1888C();
	Register_Func_with_Name("update", 0, &aUpdate);
	Register_Func_with_Name("lv_on", 0, &aLv_on);
	Register_Func_with_Name("send_mpu", 0, &aSend_mpu);
	Register_Func_with_Name("heap", 0, &aHeap);
	Register_Func_with_Name("SetRefreshTime", 0, &aSetrefreshtime);
	Register_Func_with_Name("LampOff", 0, &aLampoff);
	Register_Func_with_Name("TftOff", 0, &aTftoff);
	taskcreate_CmdShell(&aK254);
}

void my_task_Startup()
{
	CreateTask("TaskTuneData", 0x18, 0x1800, sub_FF8115A8, 0); //not sure about that 0
	printf_log(0, 5, "[STARTUP] TaskMain");
	sub_FFC43B60();
	//sub_FFC42A64(
	
	
	
	
	
	
	
	
	
	DebugManager(1, 0x1F, 0x180000, 0x40000, 0x1C0000);
	
	dmstart();
	dmProcInit();
	
	initialize(); // task_dispatcher
	
	sub_FFAFE5BC();
	SetAssert();
	EventProcedureServiceInit();
	ShutDownProcInit();
	Install3VMemory(0xF8000000);
	RomManagerInit();
	CreateParamPubInstance();
	PropertyServiceInit();
	ErrorNumberListInit();
	FatalErrorsProcInit();
	RegisterISRs_OCH();
	BlockUntilAfterTimeoutProcInit(50);
	
	sub_FFB07740(0x10, 8, 0x1BBC);
	ResourceNameServiceInit();
	
	MemorySuite(0);
	
	sysClockRateSet_100(3);
	
	sub_FFB2BD6C();
	
	InitializeSerialIO();
	
	RtcInit(0x386D4380);
	
	AdjDefectsInit();
	
	CameraAdjsInit();
	
	SetAssertProc(AssertPrepare, 0);
	
	my_InitializeIntercom(); // InitializeIntercom();
	
	AfeGainCmosParamInit();
	
	EngineInit();
	
	EDmacPriorityManager();
	
	EngineResourceInit();
	
	PowerMgrInit(0);
	
	ClockInit(1);
	
	RegisterISR_CAPREADY();
	
	FaceSensorInit();
	
	RemDrvInit();
	ActSweepInit();
	
	LcdInit();
	
	DisplayInit1();
	
	DisplayInit2();
	
	PowerSaveProcInit();
	
	sub_FFA03B0C();
	
	sub_FFA05114();
	
	InitializeImagePlayDriver();
	
	LensNameTblInit();
	
	LensPOTblInit();
	
	FlyingInit();
	
	CaptureInit();
	
	BathtubSaturateInit();
	
	Module_CaptureImagePass();
	
	ClearSomeCapMem();
	
	ColorAdjustmentsInit();
	
	Module_PreDarkPassInit();
	
	LoadSystemInfo();
	
	SharedBufferInit(0x10800000, 0x18000000, 0xEE0000, 0xEE0000);
	
	FileCacheInit();
	PackMemInit();
	
	ImagePropInit();
	DigPropInit();
	
	ShootMainInit();
	
	OlcInfoInit();
	
	RegisterISR_EMERGENCY_CARDDOOR();
	
	MainCtrlInit();
	
	CaptureSemaphoreInit();
	
	VShadingInit();
	
	Module_CaptureDarkPassInit();
	
	Module_DarkSubtractionPassInit();
	BathtubInit();
	
	Module_BathtubCorrectPassInit();
	
	Module_VObIntegPassInit();
	
	SetProjectionInit();
	Module_DefectsDetectPassInit();
	
	DefsInit();
	WbDetectionInit();
	ObInit();
	
	Module_WbDetectionPassInit();
	DefsProcInit();
	
	Module_ObAreaCopyPassInit();
	Module_AdditionVTwoLinePassInit();
	
	VShadingProcInit();
	Module_VShadingCorrectPassInit();
	
	sub_FFA24838();
	HuffmanInit();
	
	RawToJpegPass_L_Init();
	RawToJpegPass_M2_Init();
	
	RawToJpegPass_S_Init();
	YcToJpegLargeFastInit();
	
	YcToJpegM2FastInit();
	YcToJpegSFastInit();
	
	RawToLosslessInit();
	Module_YcToTwainInit();
	
	RawToYcPass_S_Init();
	RawToYPackPass_S_Init();
	
	DvlpInit();
	DecodeJpegPassInit();
	HistPassInit();
	RectangleColorPassInit();
	RectangleCopyPassInit();
	
	ResizeYuvPassInit();
	sub_FFA35354();
	LpfPassInit();
	
	EncodeJpegPassInit();
	AdjRgbGainInit();
	LuckyInit();
	
	SysInfoProcInit();
	
	TablesInit();
	
	ColorInit();
	
	CtrlManRecursiveLock();
	
	CtrlSrvInit(0x19);
	
	LangConInit();
	sub_FF926E40();
	
	CreateDispSwControlPubInstance();
	
	CreateMemoryManagerPubInstance();
	
	my_GUIInit(); //GUIInit();
	GUIApiCalls();
	
	InitializeImagePlayer();
	
	ColorBarProcsInit();
	LcdAdjustProcsInit();
	
	sub_FFB29348();
	CMOSParamInit();
	
	CameraSettingsInit();
	BootDiskProcsInit();
	
	DDDInit();
	TFTInit();
	
	RegisterResourceName(hResourceName, "USR ROOT DEVICE HANDLE", 0x7B);
	
	RegisterResource_env(0xC02200B8, "U2VBUS");
	RegisterResource_env(1, "USBC20 VBUS SUPPORT");
	
	RegisterResource_env(0x14, "DEVICESPEED");
	USBC20_Init();
	USBC20_USBIF_Init();
	
	USBC20_BUFCON_Init();
	USBC20_CLK_Init();
	USBC20_HDMAC_Init();
	
	DCPClassFunctionsInit();
	USBDriverInit();
	RapiSwitcherInit();
	
	DCPClassInit();
	RAPITransportUSBInit();
	PTPRespondInit();
	
	PTPFrameworkInit();
	StartupPtpResponder();
	
	RapiTransportManagerInit();
	DCPClassInit();
	
	EventProcServerInit();
	sub_FFA5D8A0();
	DCPInit();
	
	SesnMngrInit();
	MemMngrInit();
	InitializeRapiTransportManager();
	
	PrintInit();
	sub_FF95EC54();
	SomePrintInit();
	sub_FF9EB94C();
	
	InitializeUSBDriver();
	TransMemoryInit();
	InitializeComCtrl();
	
	FactoryModeInit();
	DP_Init(0, 0x1B, 0, 0);
	return_0();
	
	sub_FF98CF4C();
	EdLedProcsInit();
	CallBacksInit();
	
	RegistNotifyConnectDT();
	DPOF_Initialize();
	
	MpuMonInit();
	
	StartConsole();
}

int my_InitializeIntercom() {
	printf("InitializeIntercom\n");
	InitIntercomData(intercom_proxy);
	CreateIntercomSem();
	
	return 0;
}
