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
	sub_FFD1B5A8(42);
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
	
	
	
	
	CreateMainHeap(0x200000, 0x800000 - 0x10000); // in end of MainHeap - own code - 64 Kb
	
	sub_FFB0FF74();
	sub_FFB2E108(0x386D4380);
	
	EnableDispatch();
	CreateTask("Startup", 0x19, 0x2000, my_task_Startup, 0);
}

void my_task_Startup() {
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
