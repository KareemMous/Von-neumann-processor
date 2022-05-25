
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY controlunit IS
  PORT (
    --Instruction(31-27)
    instructionInput : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
    --RegSrc Sginal
    registerSource : OUT STD_LOGIC();
    --controlUnitSignals
    controlUnitSignals : OUT STD_LOGIC_VECTOR()
  );
END controlunit;

ARCHITECTURE a_controlunit OF controlunit IS

  --Reg
  --RegSrc	MemRead  	W/B selector	ALU/InputPort	ALUOp  MemWrite	 ALUSrc	RegWrite	NOP	HLT	SETC	OUTEnable Branch JumpTypeSelector CCREnable	SPEnable	PUSH/POP 	ALU/Stack	HLT Signal
  --Register Signals
  SIGNAL s_regWrite : STD_LOGIC;
  SIGNAL s_regSrc : STD_LOGIC;
  --ALU signals
  SIGNAL s_aluSrc : STD_LOGIC;
  SIGNAL s_aluOp : STD_LOGIC_VECTOR(4 DOWNTO 0)
  --CCR
  SIGNAL s_ccrEnable : STD_LOGIC;
  SIGNAL s_setC : STD_LOGIC;
  --Memory signals
  SIGNAL s_memWrite : STD_LOGIC;
  SIGNAL s_memRead : STD_LOGIC;
  SIGNAL s_branch : STD_LOGIC;
  SIGNAL s_spEnable : STD_LOGIC;
  SIGNAL s_popOrPush : STD_LOGIC;
  --ALU/Input port signal
  SIGNAL s_aluInputPort : STD_LOGIC_VECTOR;
  --W/B signals
  SIGNAL s_wbSelector : STD_LOGIC;
  --HLT signal
  SIGNAL s_hlt : STD_LOGIC;
  --Jump selector signal
  SIGNAL s_jumpTypeSelector : STD_LOGIC_VECTOR(1 DOWNTO 0);

BEGIN
  PROCESS (instructionInput)
  BEGIN

    --NOP
    IF instructionInput = "00000" THEN -- Zero
      -----Register Signals
      s_regWrite <= '0';
      s_regSrc <= '0';
      --ALU signals
      s_aluSrc <= '0';
      s_aluOp <= '00000';

      --CCR
      s_ccrEnable <= '0';
      s_setC <= '0';

      --Memory signals
      s_memWrite <= '0';
      s_memRead <= '0';
      s_branch <= '0';
      s_spEnable <= '0';
      s_popOrPush <= '0';

      --ALU/Input port signal
      s_aluInputPort <= '0';

      --W/B signals
      s_wbSelector <= '0';

      --HLT signal
      s_hlt <= '0';

      --Jump selector signal
      s_jumpTypeSelector <= '00';

    ELSIF
      +
      --HLT
      --SETC
      --NOT Rdst
      --INC Rdst
      --OUT Rdst
      --IN Rdst
      --MOV 
      --SWAP
      --ADD
      --SUB
      --AND
      --IADD

      --PUSH 
      --POP
      --LDM
      --LDD
      --STD

      --JZ
      --JN
      --JC
      --JMP
      --CALL
      --RET
      --INT
      --RTI
    END PROCESS;

  END a_controlunit;