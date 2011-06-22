/*////////////////////////////////////////////////////////////////////////////////////////
**	Initial entry code
**	For Canon Rebel XS / 1000D
**		By: Coutts
**
**	- Sample project provided by engelmarkus, thank you.
**
**	- This is taken directly from the 1000d dump.
**
**	- I have noted the locations of the original functions (some have been modified here).
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
BL my_LedBlueOn

BL loc_FF810054

// ==============
my_LedBlueOn:
LDR R0, =0xC02200E8
LDR R1, =0x46
STR R1, [R0]
MOV PC, LR

my_LedBlueOff:
LDR R0, =0xC02200E8
LDR R1, =0x44
STR R1, [R0]
MOV PC, LR
// ===============

loc_FF810054:
LDR     R0, =0xC0400000
LDR     R1, =0x430005
STR     R1, [R0,#8]
MOV     R0, #0xC0000000
LDR     R1, =0xD9C50000
STR     R1, [R0,#0x10]
LDR     R2, =0xC0200000
MOV     R1, #0xFFFFFFFF
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
LDR     PC, =my_romStart_FF8100DC

my_romStart_FF8100DC:
MOV     R12, SP
STMFD   SP!, {R4,R11,R12,LR,PC}
SUB     R11, R12, #4
MOV     R4, R0
LDR     R3, =0x37840
SUB     R2, R3, #0x1900
MOV     R3, R2,LSR#2
LDR     R0, =off_FFD51890
MOV     R1, #0x1900
MOV     R2, R3
BL      unknown_cache_FF81011C
MOV     R0, R4
BL      my_usrInit_FF810FC8
LDMDB   R11, {R4,R11,SP,PC}

my_usrInit_FF810FC8:
MOV     R12, SP
STMFD   SP!, {R11,R12,LR,PC}
SUB     R11, R12, #4
SUB     SP, SP, #4
STR     R0, [R11,#-0x10]
LDR     R0, [R11,#-0x10]
BL      sysStart_FF810F74
MOV     R0, #1
MOV     R1, #2
BL      cacheLibInit_FFD43734
BL      excVecInit_FFD503B0
BL      sysHwInit_FF8103C8
BL      sub_FF810B54
BL      my_usrInit_1_FF810B7C
LDMDB   R11, {R11,SP,PC}

my_usrInit_1_FF810B7C:
MOV     R12, SP
STMFD   SP!, {R11,R12,LR,PC}
SUB     R11, R12, #4
SUB     SP, SP, #8
BL      classLibInit_FFD43348
BL      taskLibInit_FFD333F4
LDR     R3, =0x11540
LDR     R0, =0x365E0
LDR     R1, [R3]
LDR     R2, =0x36D20
MOV     R3, #0x100
BL      qInit_FFD35EA4
LDR     R3, =0x11580
LDR     R0, =0x113E4    // activeQHead
LDR     R1, [R3]
BL      qInit_FFD35EA4
LDR     R3, =0x114C4
LDR     R0, =0x33800
LDR     R1, [R3]
BL      qInit_FFD35EA4
BL      sub_FFD30180
BL      sub_FF810504
MOV     R3, R0
MOV     R2, #0xC00
STR     R2, [SP,#0x18-0x18]
MOV     R2, #0
STR     R2, [SP,#0x18-0x14]
LDR     R0, =my_usrRoot_FF8110BC
MOV     R1, #0x4000
LDR     R2, =0x37840
BL      kernelInit_FFD35290
LDMDB   R11, {R11,SP,PC}

my_usrRoot_FF8110BC:
MOV     R12, SP
STMFD   SP!, {R11,R12,LR,PC}
SUB     R11, R12, #4
SUB     SP, SP, #8
STR     R0, [R11,#-0x10]
STR     R1, [R11,#-0x14]
BL      sub_FF811004
LDR     R0, [R11,#-0x10]
LDR     R1, [R11,#-0x14]
BL      memInit_FFD3DDC8
LDR     R0, [R11,#-0x10]
LDR     R1, [R11,#-0x14]
BL      sub_FFD3D62C
BL      usrMmuInit_FF810C50
BL      sysClockInit_FF810B28
MOV     R0, #0x32
BL      selectInit_FFD3BCBC
BL      usrRoot_init0_FF811058
BL      usrRoot_init1_FF811030
BL      usrRoot_init2_FF81108C
BL      selTaskDeleteHookAdd_FFD3BC54
BL      sub_FFD50CC0
BL      my_usrAppInit_FF810654
LDMDB   R11, {R11,SP,PC}

my_usrAppInit_FF810654:
MOV     R12, SP
STMFD   SP!, {R11,R12,LR,PC}
SUB     R11, R12, #4
BL      my_task_Startup_FF81132C
LDMDB   R11, {R11,SP,PC}

my_task_Startup_FF81132C:
STMFD   SP!, {R4,R5,LR}
MOV     R3, #0x38400000
MOV     R0, #0x94
LDR     R5, =aK254
ADD     R3, R3, #0x2D4000
ADD     R0, R0, #0xC0000000
SUB     SP, SP, #0x2C
ADD     R3, R3, #0x380
ADD     R0, R0, #0x220000
STR     R3, [SP,#0x38-0x34]
BL      sub_FFD16DB4
LDR     R3, =a2009_09_25144532
LDR     R2, =a3_7_7
MOV     R1, R5
LDR     R0, =aSReadyVerSBuildDateS
BL      printf_FFD421C0
BL      sub_FFD1FDF8
BL      sub_FFCFC4C8
//    MOV     R1, #0x9D8000
LDR R1, =0x9D8000
MOV     R0, #0x1C0000
BL      sub_FFD1CBF0
BL      InitializeKernel_FFD0557C
LDR     R0, [SP,#0x38-0x34]
BL      sub_FFD1B5A8
BL      sub_FFD058B8
BL      FlushWriteCache_1_FFD0CA18
BL      sub_FFCFF7A0
MOV     R0, #0xF8000000
BL      Install3VMemory_FFD17E9C
BL      RegisterISRs_OCH_FFD01A80
MOV     R0, #0x32
BL      InitializeTimerSystem_FFD0CD78
LDR     R2, =0x1BC4
MOV     R1, #8
MOV     R0, #0x10
BL      InitializeHPTimerSystem_FFD004F0
BL      ResourceNameServiceInit_FFD0AC3C
MOV     R0, #0
BL      sub_FFD08FEC
BL      sub_FFD01DA8
MOV     R0, #3
BL      sysClockRateSet_100_FFD1753C
BL      InitializeSerialIO_FFD173C0
ADD     R4, SP, #0x38-0x30
ADD     R0, SP, #0x38-0x34
MOV     R1, R4
BL      sub_FFD1B808
MOV     R0, R4
BL      RtcInit_FFCFD72C
BL      InitHPC_FFD1A844
LDR     R0, =sub_FF819E44
BL      PowerMgrInit_FFD1B978
BL      DisablePowerSave_FFD1B9D4
MOV     R2, #0x40000
MOV     R1, #0x180000
MOV     R0, #0x1F
BL      sub_FFD0D494
MOV     R0, #0xFFFFFFFF
MOV     R1, #3
BL      sub_FFD0D998
MOV     R1, #0
LDR     R0, =aStartupeventflag
BL      CreateEventFlag_FFD03214
LDR     R3, =0x11CFC
MOV     R4, #0
STR     R0, [R3]
MOV     R1, #0x18
LDR     R3, =Startup_TaskMain_FF81195C
MOV     R2, #0x1800
LDR     R0, =aTaskmain
STR     R4, [SP,#0x38-0x38]
BL      CreateTask_FFD05A54

BL      CreateMyTask

BL      sub_FFD0D740
MOV     R1, R4
LDR     R0, =aDumpall
LDR     R2, =loc_FF812B88
BL      Register_Func_with_Name_FFD100C8
BL      Setup_Bootstyle_FuncTable_FFD211B0
BL      sub_FFD1888C
MOV     R1, R4
LDR     R0, =aUpdate
LDR     R2, =Update_FFD20F3C
BL      Register_Func_with_Name_FFD100C8
MOV     R1, R4
LDR     R0, =aLv_on
LDR     R2, =Lv_on_FF812CE0
BL      Register_Func_with_Name_FFD100C8
MOV     R1, R4
LDR     R0, =aSend_mpu_0
LDR     R2, =Send_mpu_FF811158
BL      Register_Func_with_Name_FFD100C8
MOV     R1, R4
LDR     R0, =aHeap
LDR     R2, =sub_FF812C5C
BL      Register_Func_with_Name_FFD100C8
MOV     R1, R4
LDR     R0, =aSetrefreshtime
LDR     R2, =Set_refresh_time_FF812C4C
BL      Register_Func_with_Name_FFD100C8
MOV     R1, R4
LDR     R0, =aLampoff
LDR     R2, =Lamp_off_FF812D10
BL      Register_Func_with_Name_FFD100C8
MOV     R1, R4
LDR     R0, =aTftoff
LDR     R2, =loc_FF812D20
BL      Register_Func_with_Name_FFD100C8
MOV     R0, R5
BL      taskcreate_CmdShell_FFD10074
ADD     SP, SP, #0x2C
LDMFD   SP!, {R4,R5,PC}
//    RET

.align 2
fin:
