/*////////////////////////////////////////////////////////////////////////////////////////
**	Initial entry code
**	For Canon Rebel XS / 1000D
**		By: Coutts
**
**	- Sample project provided by Indy, thank you.
**
**	- These are the first init functions for our code called at boot when our code
**	  is first executed. We use the camera's init funcs to start our "program", then
**	  call Canon's init funcs to boot the camera.
**
**	- I have noted the locations of the original functions (some have been modified here), along with auto-generated
**	  comments for each line from IDA. This may assist new developers in understanding what is happening.
**
**	- For information reading ASM code, please see this wiki page:
**		http://magiclantern.wikia.com/wiki/ASM_introduction
**
**	--- THIS HAS BEEN PORTED FROM THE 450D TO RUN ON THE 1000D ---
//////////////////////////////////////////////////////////////////////////////////////////*/

    .text
    .org 0
    .globl _start, start

start:
_start:
                BL      my_LedBlueOn

                B       loc_FF810054 

// ==========================================

// couldn't locate yet, not used so not necessary yet
my_LedRedOn:
                LDR     R0, =0xC02200A0
                LDR     R1, =0x46
                STR     R1, [R0]
                MOV     PC, LR

// couldn't locate yet, not used so not necessary yet
my_LedRedOff:
                LDR     R0, =0xC02200A0
                LDR     R1, =0x44
                STR     R1, [R0]
                MOV     PC, LR
				
// based off of EdLedOn at 0xFFCFD458
my_LedBlueOn:
                LDR     R0, =0xC02200E8         // R0 = 0xC02200E8
                MOV     R1, #0x48               // R2 = 0x48
                STR     R1, [R0]                // 0xC02200E8 = 0x48
                LDR     R0, =0xC0210014         // R0 = 0xC0210014
                MOV     R1, #1                  // R1 = 1
                STR     R1, [R0]                // 0xC0210014 = 0x1
                MOV     PC, LR					// Return
				
// based off of EdLedOff at 0xFFCFD420
my_LedBlueOff:
				LDR		R0, =0xC0210014			// R0 = 0xC0210014
				MOV		R1, #0					// R1 = 0
				STR		R1, [R0]				// 0xC0210014 = 0
                LDR     R0, =0xC02200E8			// R0 = 0xC02200E8
                MOV     R1, #0x44				// R2 = 0x44
                STR     R1, [R0]				// 0xC02200E8 = 0x44
                MOV     PC, LR					// Return

// ==========================================

// 0xFF810054
loc_FF810054:
                LDR     R0, =0xC0400000
                LDR     R1, =0x430005
                STR     R1, [R0,#8]
                MOV     R0, #0xC0000000
                LDR     R1, =0xD9C50000
                STR     R1, [R0,#0x10]
                LDR     R2, =0xC0200000
                MVN     R1, #0
                STR     R1, [R2,#0x10C]
                STR     R1, [R2,#0xC]
                STR     R1, [R2,#0x1C]
                STR     R1, [R2,#0x2C]
                STR     R1, [R2,#0x3C]
                STR     R1, [R2,#0x4C]
                STR     R1, [R2,#0x5C]
                STR     R1, [R2,#0x6C]
                STR     R1, [R2,#0x7C]
                STR     R1, [R2,#0x8C]
                STR     R1, [R2,#0x9C]
                STR     R1, [R2,#0xAC]
                STR     R1, [R2,#0xBC]
                STR     R1, [R2,#0xCC]
                STR     R1, [R2,#0xDC]
                STR     R1, [R2,#0xEC]
                STR     R1, [R2,#0xFC]
                LDR     SP, =0x1900
                MOV     R11, #0
                LDR     PC, =my_romStart


// 0xFF8100DC
my_romStart:
                MOV     R12, SP
                STMFD   SP!, {R4,R11,R12,LR,PC}
                SUB     R11, R12, #4
                MOV     R4, R0
                LDR     R3, =0x37840
                SUB     R2, R3, #0x1900
                MOV     R3, R2,LSR#2
                LDR     R0, =0xFFD51890
                MOV     R1, #0x1900
                MOV     R2, R3
                BL      unknown_cache
                MOV     R0, R4
                BL      my_usrInit
                LDMDB   R11, {R4,R11,SP,PC}


// 0xFF810FC8
my_usrInit:
                MOV     R12, SP
                STMFD   SP!, {R11,R12,LR,PC}
                SUB     R11, R12, #4
                SUB     SP, SP, #4
                STR     R0, [R11,#-0x10]
                LDR     R0, [R11,#-0x10]
                BL      sysStart
                MOV     R0, #1
                MOV     R1, #2
                BL      cacheLibInit
                BL      excVecInit
                BL      sysHwInit
                BL      sub_FF810B54
                BL      my_usrInit_1
                LDMDB   R11, {R11,SP,PC}
 

// 0xFF810B7C
my_usrInit_1:
                MOV     R12, SP
                STMFD   SP!, {R11,R12,LR,PC}
                SUB     R11, R12, #4
                SUB     SP, SP, #8
                BL      classLibInit
                BL      taskLibInit
                LDR     R3, =0x11540
                LDR     R0, =0x365E0
                LDR     R1, [R3]
                LDR     R2, =0x36D20
                MOV     R3, #0x100
                BL      qInit
                LDR     R3, =0x11580
                LDR     R0, =activeQHead
                LDR     R1, [R3]
                BL      qInit
                LDR     R3, =0x114C4
                LDR     R0, =0x33800
                LDR     R1, [R3]
                BL      qInit
                BL      sub_FFD30180
                BL      sub_FF810504
                MOV     R3, R0
                MOV     R2, #0xC00
                STR     R2, [SP]
                MOV     R2, #0
                STR     R2, [SP,#4]
                LDR     R0, =my_usrRoot
                MOV     R1, #0x4000
                LDR     R2, =0x37840
                BL      kernelInit
                LDMDB   R11, {R11,SP,PC}


// 0xFF8110BC
my_usrRoot:
                MOV     R12, SP
                STMFD   SP!, {R11,R12,LR,PC}
                SUB     R11, R12, #4
                SUB     SP, SP, #8
                STR     R0, [R11,#-0x10]
                STR     R1, [R11,#0xFFFFFFEC]
                BL      sub_FF811004
                LDR     R0, [R11,#-0x10]
                LDR     R1, [R11,#0xFFFFFFEC]
                BL      memInit
                LDR     R0, [R11,#-0x10]
                LDR     R1, [R11,#0xFFFFFFEC]
                BL      sub_FFD3D62C
                BL      usrMmuInit
                BL      sysClockInit
                MOV     R0, #0x32
                BL      selectInit
                BL      usrRoot_init0
                BL      usrRoot_init1
                BL      usrRoot_init2
                BL      selTaskDeleteHookAdd
                BL      sub_FFD50CC0
                BL      my_usrAppInit
                LDMDB   R11, {R11,SP,PC}


// 0xFF810654
my_usrAppInit:
                MOV     R12, SP
                STMFD   SP!, {R11,R12,LR,PC}
                SUB     R11, R12, #4
                BL      my_task_Startup
                LDMDB   R11, {R11,SP,PC}


// 0xFF81132C
my_task_Startup:
                STMFD   SP!, {R4,R5,LR}
                MOV     R3, #0x38400000
                MOV     R0, #0x94
                LDR     R5, =aK254
                ADD     R3, R3, #0x2D4000
                ADD     R0, R0, #0xC0000000
                SUB     SP, SP, #0x2C
                ADD     R3, R3, #0x380
                ADD     R0, R0, #0x220000
                STR     R3, [SP,#4]
                BL      sub_FFD16DB4
                LDR     R3, =a2009_09_251445
                LDR     R2, =a3_7_7
                MOV     R1, R5
                LDR     R0, =aSReadyVerSBuil
                BL      debug_print
                BL      sub_FFD1FDF8
                BL      sub_FFCFC4C8
                LDR     R1, =0x9D8000
                MOV     R0, #0x1C0000
                BL      sub_FFD1CBF0
                BL      InitializeKernel
                LDR     R0, [SP,#4]
                BL      sub_FFD1B5A8
                BL      sub_FFD058B8
                BL      FlushWriteCache_1
                BL      sub_FFCFF7A0
                MOV     R0, #0xF8000000
                BL      Install3VMemory
                BL      RegisterISRs_OCH
                MOV     R0, #0x32
                BL      InitializeTimerSystem
                LDR     R2, =0x1BC4
                MOV     R1, #8
                MOV     R0, #0x10
                BL      InitializeHPTimerSystem
                BL      ResourceNameServiceInit
                MOV     R0, #0
                BL      sub_FFD08FEC
                BL      sub_FFD01DA8
                MOV     R0, #3
                BL      sysClockRateSet_100
                BL      InitializeSerialIO
                ADD     R4, SP, #8
                ADD     R0, SP, #4
                MOV     R1, R4
                BL      sub_FFD1B808
                MOV     R0, R4
                BL      RtcInit
                BL      InitHPC
                LDR     R0, =loc_FF819E44
                BL      PowerMgrInit
                BL      DisablePowerSave
                MOV     R2, #0x40000
                MOV     R1, #0x180000
                MOV     R0, #0x1F
                BL      sub_FFD0D494
                MVN     R0, #0
                MOV     R1, #3
                BL      sub_FFD0D998
                MOV     R1, #0
                LDR     R0, =aStartupeventfl
                BL      CreateEventFlag
                LDR     R3, =0x11CFC
                MOV     R4, #0
                STR     R0, [R3]
                MOV     R1, #0x18
                LDR     R3, =Startup_TaskMain
                MOV     R2, #0x1800
                LDR     R0, =aTaskmain
                STR     R4, [SP]
                BL      CreateTask
                BL      CreateMyTask
                BL      sub_FFD0D740
                MOV     R1, R4
                LDR     R0, =aDumpall
                LDR     R2, =dumpall
                BL      Register_Func_with_Name
                BL      Setup_Bootstyle_FuncTable
                BL      sub_FFD1888C
                MOV     R1, R4
                LDR     R0, =aUpdate
                LDR     R2, =Update
                BL      Register_Func_with_Name
                MOV     R1, R4
                LDR     R0, =aLv_on
                LDR     R2, =lv_on
                BL      Register_Func_with_Name
                MOV     R1, R4
                LDR     R0, =aSend_mpu
                LDR     R2, =send_mpu
                BL      Register_Func_with_Name
                MOV     R1, R4
                LDR     R0, =aHeap
                LDR     R2, =heap
                BL      Register_Func_with_Name
                MOV     R1, R4
                LDR     R0, =aSetrefreshtime
                LDR     R2, =SetRefreshTime
                BL      Register_Func_with_Name
                MOV     R1, R4
                LDR     R0, =aLampoff
                LDR     R2, =lamp_off
                BL      Register_Func_with_Name
                MOV     R1, R4
                LDR     R0, =aTftoff
                LDR     R2, =TftOff
                BL      Register_Func_with_Name
                MOV     R0, R5
                BL      taskcreate_CmdShell
                ADD     SP, SP, #0x2C
                LDMFD   SP!, {R4,R5,PC}
 




.align 2
fin:
