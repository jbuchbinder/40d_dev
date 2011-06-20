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
                LDR     R0, =0xC0400000         // Load from Memory
                LDR     R1, =0x430005           // Load from Memory
                STR     R1, [R0,#8]             // Store to Memory
                MOV     R0, #0xC0000000         // Rd = Op2
                LDR     R1, =0xD9C50000         // Load from Memory
                STR     R1, [R0,#0x10]          // Store to Memory
                LDR     R2, =0xC0200000         // Load from Memory
                MVN     R1, #0
                STR     R1, [R2,#0x10C]         // Store to Memory
                STR     R1, [R2,#0xC]           // Store to Memory
                STR     R1, [R2,#0x1C]          // Store to Memory
                STR     R1, [R2,#0x2C]          // Store to Memory
                STR     R1, [R2,#0x3C]          // Store to Memory
                STR     R1, [R2,#0x4C]          // Store to Memory
                STR     R1, [R2,#0x5C]          // Store to Memory
                STR     R1, [R2,#0x6C]          // Store to Memory
                STR     R1, [R2,#0x7C]          // Store to Memory
                STR     R1, [R2,#0x8C]          // Store to Memory
                STR     R1, [R2,#0x9C]          // Store to Memory
                STR     R1, [R2,#0xAC]          // Store to Memory
                STR     R1, [R2,#0xBC]          // Store to Memory
                STR     R1, [R2,#0xCC]          // Store to Memory
                STR     R1, [R2,#0xDC]          // Store to Memory
                STR     R1, [R2,#0xEC]          // Store to Memory
                STR     R1, [R2,#0xFC]          // Store to Memory
                LDR     SP, =0x1900             // Load from Memory
                MOV     R11, #0                 // Rd = Op2
                LDR     PC, =my_romStart        // Indirect Jump


// 0xFF8100DC
my_romStart:
                MOV     R12, SP                 // Rd = Op2
                STMFD   SP!, {R4,R11,R12,LR,PC} // Store Block to Memory
                SUB     R11, R12, #4            // Rd = Op1 - Op2
                MOV     R4, R0                  // Rd = Op2
                LDR     R3, =0x37840            // Load from Memory
                SUB     R2, R3, #0x1900         // Rd = Op1 - Op2
                MOV     R3, R2,LSR#2            // Rd = Op2
                LDR     R0, =0xFFD51890       // Load from Memory
                MOV     R1, #0x1900             // Rd = Op2
                MOV     R2, R3                  // Rd = Op2
                BL      unknown_cache           // Branch with Link
                MOV     R0, R4                  // Rd = Op2
                BL      my_usrInit              // Branch with Link
                LDMDB   R11, {R4,R11,SP,PC}     // Load Block from Memory



// 0xFF810FC8
my_usrInit:
                MOV     R12, SP                 // Rd = Op2
                STMFD   SP!, {R11,R12,LR,PC}    // Store Block to Memory
                SUB     R11, R12, #4            // Rd = Op1 - Op2
                SUB     SP, SP, #4              // Rd = Op1 - Op2
                STR     R0, [R11,#-0x10]        // Store to Memory
                LDR     R0, [R11,#-0x10]        // Load from Memory
                BL      sysStart                // Branch with Link
                MOV     R0, #1                  // Rd = Op2
                MOV     R1, #2                  // Rd = Op2
                BL      cacheLibInit            // Branch with Link
                BL      excVecInit              // Branch with Link
                BL      sysHwInit               // Branch with Link
                BL      sub_FF810B54            // Branch with Link
                BL      my_usrInit_1            // Branch with Link
                LDMDB   R11, {R11,SP,PC}        // Load Block from Memory
 

// 0xFF810B7C
my_usrInit_1:
                MOV     R12, SP                 // Rd = Op2
                STMFD   SP!, {R11,R12,LR,PC}    // Store Block to Memory
                SUB     R11, R12, #4            // Rd = Op1 - Op2
                SUB     SP, SP, #8              // Rd = Op1 - Op2
                BL      classLibInit            // Branch with Link
                BL      taskLibInit				// Branch with Link
                LDR     R3, =0x11540            // Load from Memory
                LDR     R0, =0x365E0            // Load from Memory
                LDR     R1, [R3]                // Load from Memory
                LDR     R2, =0x36D20            // Load from Memory
                MOV     R3, #0x100              // Rd = Op2
                BL      qInit                   // Branch with Link
                LDR     R3, =0x11580            // Load from Memory
                LDR     R0, =0x113E4            // Load from Memory
                LDR     R1, [R3]                // Load from Memory
                BL      qInit                   // Branch with Link
                LDR     R3, =0x114C4            // Load from Memory
                LDR     R0, =0x33800            // Load from Memory
                LDR     R1, [R3]                // Load from Memory
                BL      qInit                   // Branch with Link
                BL      sub_FFD30180            // Branch with Link
                BL      sub_FF810504            // Branch with Link
                MOV     R3, R0                  // Rd = Op2
                MOV     R2, #0xC00              // Rd = Op2
                STR     R2, [SP,#0]				// Store to Memory
                MOV     R2, #0                  // Rd = Op2
                STR     R2, [SP,#4]				// Store to Memory
                LDR     R0, =my_usrRoot         // Load from Memory
                MOV     R1, #0x4000             // Rd = Op2
                LDR     R2, =0x37840            // Load from Memory
                BL      kernelInit              // Branch with Link
                LDMDB   R11, {R11,SP,PC}        // Load Block from Memory


// 0xFF8110BC
my_usrRoot:
                MOV     R12, SP                 // Rd = Op2
                STMFD   SP!, {R11,R12,LR,PC}    // Store Block to Memory
                SUB     R11, R12, #4            // Rd = Op1 - Op2
                SUB     SP, SP, #8              // Rd = Op1 - Op2
                STR     R0, [R11,#-0x10]        // Store to Memory
                STR     R1, [R11,#0xFFFFFFEC]   // Store to Memory
                BL      sub_FF811004            // Branch with Link
                LDR     R0, [R11,#-0x10]        // Load from Memory
                LDR     R1, [R11,#0xFFFFFFEC]   // Load from Memory
                BL      memInit                 // Branch with Link
                LDR     R0, [R11,#-0x10]        // Load from Memory
                LDR     R1, [R11,#0xFFFFFFEC]   // Load from Memory
                BL      sub_FFD3D62C            // Branch with Link
                BL      usrMmuInit				// Branch with Link
                BL      sysClockInit            // Branch with Link
                MOV     R0, #0x32               // Rd = Op2
                BL      selectInit              // Branch with Link
                BL      usrRoot_init0           // Branch with Link
                BL      usrRoot_init1           // Branch with Link
                BL      usrRoot_init2           // Branch with Link
                BL      selTaskDeleteHookAdd    // Branch with Link
                BL      sub_FFD50CC0            // Branch with Link
                BL      my_usrAppInit           // Branch with Link
                LDMDB   R11, {R11,SP,PC}        // Load Block from Memory


// 0xFF810654
my_usrAppInit:
                MOV     R12, SP					// Rd = Op2
                STMFD   SP!, {R11,R12,LR,PC}	// Store Block to Memory
                SUB     R11, R12, #4			// Rd = Op1 - Op2
                BL      my_task_Startup			// Branch with Link
                LDMDB   R11, {R11,SP,PC}		// Load Block from Memory


// 0xFF81132C
my_task_Startup:

				//BL CreateMyTask
	
                STMFD   SP!, {R4,R5,LR}         // Store Block to Memory
                MOV     R3, #0x38400000         // Rd = Op2
                MOV     R0, #0x94               // Rd = Op2
                LDR     R5, =aK254              // "K254"
                ADD     R3, R3, #0x2D4000       // Rd = Op1 + Op2
                ADD     R0, R0, #0xC0000000     // Rd = Op1 + Op2
                SUB     SP, SP, #0x2C           // Rd = Op1 - Op2
                ADD     R3, R3, #0x380          // Rd = Op1 + Op2
                ADD     R0, R0, #0x220000       // Rd = Op1 + Op2
                STR     R3, [SP,#0x4]			// Store to Memory
                BL      sub_FFD16DB4            // Branch with Link
                LDR     R3, =a2009_09_251445    // "2009.09.25 14:45:32"
                LDR     R2, =a3_7_7             // "3.7.7"
                MOV     R1, R5                  // Rd = Op2
                LDR     R0, =aSReadyVerSBuil    // "--------------------------\n%s READY : V"...
                BL      debug_print				// Branch with Link
                BL      sub_FFD1FDF8            // Branch with Link
                BL      sub_FFCFC4C8            // Branch with Link
                LDR     R1, =0x9D8000
                MOV     R0, #0x1C0000           // Rd = Op2
                BL      sub_FFD1CBF0            // Branch with Link
                BL      InitializeKernel        // Branch with Link
                LDR     R0, [SP,#04]			// Load from Memory
                BL      sub_FFD1B5A8            // Branch with Link
                BL      sub_FFD058B8            // Branch with Link
                BL      FlushWriteCache_1       // Branch with Link
                BL      sub_FFCFF7A0            // Branch with Link
                MOV     R0, #0xF8000000         // Rd = Op2
                BL      Install3VMemory         // Branch with Link
                BL      RegisterISRs_OCH        // Branch with Link
                MOV     R0, #0x32               // Rd = Op2
                BL      InitializeTimerSystem   // Branch with Link
                LDR     R2, =0x1BC4             // Load from Memory
                MOV     R1, #8                  // Rd = Op2
                MOV     R0, #0x10               // Rd = Op2
                BL      InitializeHPTimerSystem // Branch with Link
                BL      ResourceNameServiceInit // Branch with Link
                MOV     R0, #0                  // Rd = Op2
                BL      sub_FFD08FEC            // Branch with Link
                BL      sub_FFD01DA8            // Branch with Link
                MOV     R0, #3                  // Rd = Op2
                BL      sysClockRateSet_100     // Branch with Link
                BL      InitializeSerialIO      // Branch with Link
                ADD     R4, SP, #8				// Rd = Op1 + Op2
                ADD     R0, SP, #4				// Rd = Op1 + Op2
                MOV     R1, R4                  // Rd = Op2
                BL      sub_FFD1B808            // Branch with Link
                MOV     R0, R4                  // Rd = Op2
                BL      RtcInit					// Branch with Link
                BL      InitHPC					// Branch with Link
                LDR     R0, =sub_FF819E44       // Load from Memory
                BL      PowerMgrInit            // Branch with Link
                BL      DisablePowerSave        // Branch with Link
				
				//BL	CreateMyTask
				
                MOV     R2, #0x40000            // Rd = Op2
                MOV     R1, #0x180000           // Rd = Op2
                MOV     R0, #0x1F               // Rd = Op2
                BL      sub_FFD0D494            // Branch with Link
                MOV     R0, #0
                MOV     R1, #3                  // Rd = Op2
                BL      sub_FFD0D998            // Branch with Link
                MOV     R1, #0                  // Rd = Op2
                LDR     R0, =aStartupeventfl    // "StartupEventFlag"
                BL      CreateEventFlag			// Branch with Link
                LDR     R3, =0x11CFC            // Load from Memory
                MOV     R4, #0                  // Rd = Op2
                STR     R0, [R3]                // Store to Memory
                MOV     R1, #0x18               // Rd = Op2
                LDR     R3, =Startup_TaskMain   // Load from Memory
                MOV     R2, #0x1800             // Rd = Op2
                LDR     R0, =aTaskmain          // "TaskMain"
                STR     R4, [SP]				// Store to Memory
                BL      CreateTask				// Branch with Link
				
				BL		CreateMyTask
				
                BL      sub_FFD0D740            // Branch with Link
                MOV     R1, R4                  // Rd = Op2
                LDR     R0, =aDumpall           // "dumpall"
                LDR     R2, =dumpall            // Load from Memory
                BL      Register_Func_with_Name            // Branch with Link
                BL      Setup_Bootstyle_FuncTable          // Branch with Link
                BL      sub_FFD1888C            // Branch with Link
                MOV     R1, R4                  // Rd = Op2
                LDR     R0, =aUpdate            // "update"
                LDR     R2, =Update       // Load from Memory
                BL      Register_Func_with_Name            // Branch with Link
                MOV     R1, R4                  // Rd = Op2
                LDR     R0, =aLv_on             // "lv_on"
                LDR     R2, =lv_on              // Load from Memory
                BL      Register_Func_with_Name            // Branch with Link
                MOV     R1, R4                  // Rd = Op2
                LDR     R0, =aSend_mpu        // "send_mpu"
                LDR     R2, =send_mpu           // Load from Memory
                BL      Register_Func_with_Name            // Branch with Link
                MOV     R1, R4                  // Rd = Op2
                LDR     R0, =aHeap              // "heap"
                LDR     R2, =heap               // Load from Memory
                BL      Register_Func_with_Name            // Branch with Link
                MOV     R1, R4                  // Rd = Op2
                LDR     R0, =aSetrefreshtime    // "SetRefreshTime"
                LDR     R2, =SetRefreshTime     // Load from Memory
                BL      Register_Func_with_Name            // Branch with Link
                MOV     R1, R4                  // Rd = Op2
                LDR     R0, =aLampoff           // "LampOff"
                LDR     R2, =lamp_off            // Load from Memory
                BL      Register_Func_with_Name            // Branch with Link
                MOV     R1, R4                  // Rd = Op2
                LDR     R0, =aTftoff            // "TftOff"
                LDR     R2, =TftOff             // Load from Memory
                BL      Register_Func_with_Name            // Branch with Link
                MOV     R0, R5                  // Rd = Op2
                BL      taskcreate_CmdShell     // Branch with Link
                ADD     SP, SP, #0x2C           // Rd = Op1 + Op2
                LDMFD   SP!, {R4,R5,PC}         // Load Block from Memory




.align 2
fin:
