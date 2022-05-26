LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY controlunit IS
  PORT (
    --Instruction(31-27)
    instructionInput : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
    --RegSrc Sginal
    registerSource : OUT STD_LOGIC;
    --controlUnitSignals
    controlUnitSignals : OUT STD_LOGIC_VECTOR(22 DOWNTO 0)
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
  SIGNAL s_aluOp : STD_LOGIC_VECTOR(4 DOWNTO 0);
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
  SIGNAL s_aluInputPort : STD_LOGIC;
  --W/B signals
  SIGNAL s_wbSelector : STD_LOGIC;
  --HLT signal
  SIGNAL s_hlt : STD_LOGIC;
  --Jump selector signal
  SIGNAL s_jumpTypeSelector : STD_LOGIC_VECTOR(1 DOWNTO 0);
  -- ALU or STACK Signal
  SIGNAL s_AluOrStack : STD_LOGIC;

  -- Store Enable Signal
  SIGNAL s_StoreEnable : STD_LOGIC;
  --Output port signal
  SIGNAL s_outEnable : STD_LOGIC;

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
      s_jumpTypeSelector <= "11";

      --Output port signal
      s_outEnable <= '0';
      --ALU or STACK signal
      s_AluOrStack <= '0';

      --Store Enable Signal
      s_StoreEnable <= '0';
      --HLT ins
    ELSIF instructionInput = "00001" THEN

      -----Register Signals
      s_regWrite <= '0';
      s_regSrc <= '0';

      --ALU signals
      s_aluSrc <= '0';

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
      s_hlt <= '1';

      --Jump selector signal
      s_jumpTypeSelector <= "11";

      --Output port signal
      s_outEnable <= '0';
      --ALU or STACK signal
      s_AluOrStack <= '0';

      --Store Enable Signal
      s_StoreEnable <= '0';

      --SETC
    ELSIF instructionInput = "00010" THEN
      --HLT ins
      -----Register Signals
      s_regWrite <= '0';
      s_regSrc <= '0';

      --ALU signals
      s_aluSrc <= '0';

      --CCR
      s_ccrEnable <= '1';
      s_setC <= '1';

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
      s_jumpTypeSelector <= "11";

      --Output port signal
      s_outEnable <= '0';
      --ALU or STACK signal
      s_AluOrStack <= '0';

      --Store Enable Signal
      s_StoreEnable <= '0';

      --NOT Rdst
    ELSIF instructionInput = "00011" THEN
      -----Register Signals
      s_regWrite <= '1';
      s_regSrc <= '0';

      --ALU signals
      s_aluSrc <= '0';
      --CCR
      s_ccrEnable <= '1';
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
      s_wbSelector <= '1';

      --HLT signal
      s_hlt <= '0';

      --Jump selector signal
      s_jumpTypeSelector <= "11";

      --Output port signal
      s_outEnable <= '0';
      --ALU or STACK signal
      s_AluOrStack <= '0';

      --Store Enable Signal
      s_StoreEnable <= '0';
      --INC Rdst

    ELSIF instructionInput = "00100" THEN

      -----Register Signals
      s_regWrite <= '1';
      s_regSrc <= '0';

      --ALU signals
      s_aluSrc <= '0';

      --CCR
      s_ccrEnable <= '1';
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
      s_wbSelector <= '1';

      --HLT signal
      s_hlt <= '0';

      --Jump selector signal
      s_jumpTypeSelector <= "11";

      --Output port signal
      s_outEnable <= '0';
      --ALU or STACK signal
      s_AluOrStack <= '0';

      --Store Enable Signal
      s_StoreEnable <= '0';

      --OUT Rdst

    ELSIF instructionInput = "00101" THEN

      -----Register Signals
      s_regWrite <= '0';
      s_regSrc <= '0';

      --ALU signals
      s_aluSrc <= '0';

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
      s_hlt <= '1';

      --Jump selector signal
      s_jumpTypeSelector <= "11";

      --Output port signal
      s_outEnable <= '1';

      --ALU or STACK signal
      s_AluOrStack <= '0';

      --Store Enable Signal
      s_StoreEnable <= '0';
      --IN Rdst
    ELSIF instructionInput = "00110" THEN -- Zero
      -----Register Signals
      s_regWrite <= '1';
      s_regSrc <= '0';

      --ALU signals
      s_aluSrc <= '0';
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
      s_aluInputPort <= '1';

      --W/B signals
      s_wbSelector <= '1';

      --HLT signal
      s_hlt <= '0';

      --Jump selector signal
      s_jumpTypeSelector <= "11";

      --Output port signal
      s_outEnable <= '0';

      --ALU or STACK signal
      s_AluOrStack <= '0';

      --Store Enable Signal
      s_StoreEnable <= '0';
      --MOV 
    ELSIF instructionInput = "01000" THEN -- Zero
      -----Register Signals
      s_regWrite <= '1';
      s_regSrc <= '1';

      --ALU signals
      s_aluSrc <= '0';
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
      s_wbSelector <= '1';

      --HLT signal
      s_hlt <= '0';

      --Jump selector signal
      s_jumpTypeSelector <= "11";

      --Output port signal
      s_outEnable <= '0';
      --ALU or STACK signal
      s_AluOrStack <= '0';

      --Store Enable Signal
      s_StoreEnable <= '0';

      --SWAP
    ELSIF instructionInput = "01001" THEN
      -- -----Register Signals
      -- s_regWrite <= '0';
      -- s_regSrc <= '0';

      -- --ALU signals
      -- s_aluSrc <= '0';
      -- --CCR
      -- s_ccrEnable <= '0';
      -- s_setC <= '0';

      -- --Memory signals
      -- s_memWrite <= '0';
      -- s_memRead <= '0';
      -- s_branch <= '0';
      -- s_spEnable <= '0';
      -- s_popOrPush <= '0';

      -- --ALU/Input port signal
      -- s_aluInputPort <= '0';

      -- --W/B signals
      -- s_wbSelector <= '0';

      -- --HLT signal
      -- s_hlt <= '0';

      -- --Jump selector signal
      -- s_jumpTypeSelector <= "11";

      -- --Output port signal
      -- s_outEnable <= '0';

      -- --ALU or STACK signal
      -- s_AluOrStack <= '0';

      -- --Store Enable Signal
      -- s_StoreEnable <= '0';
      --ADD
    ELSIF instructionInput = "01010" THEN
      -----Register Signals
      s_regWrite <= '1';
      s_regSrc <= '1';

      --ALU signals
      s_aluSrc <= '0';
      --CCR
      s_ccrEnable <= '1';
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
      s_wbSelector <= '1';

      --HLT signal
      s_hlt <= '0';

      --Jump selector signal
      s_jumpTypeSelector <= "11";

      --Output port signal
      s_outEnable <= '0';

      --ALU or STACK signal
      s_AluOrStack <= '0';

      --Store Enable Signal
      s_StoreEnable <= '0';

      --SUB
    ELSIF instructionInput = "01011" THEN -- Zero
      -----Register Signals
      s_regWrite <= '1';
      s_regSrc <= '1';

      --ALU signals
      s_aluSrc <= '0';
      --CCR
      s_ccrEnable <= '1';
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
      s_wbSelector <= '1';

      --HLT signal
      s_hlt <= '0';

      --Jump selector signal
      s_jumpTypeSelector <= "11";

      --Output port signal
      s_outEnable <= '0';

      --ALU or STACK signal
      s_AluOrStack <= '0';

      --Store Enable Signal
      s_StoreEnable <= '0';

      --AND
    ELSIF instructionInput = "01100" THEN
      -----Register Signals
      s_regWrite <= '1';
      s_regSrc <= '1';

      --ALU signals
      s_aluSrc <= '0';
      --CCR
      s_ccrEnable <= '1';
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
      s_wbSelector <= '1';

      --HLT signal
      s_hlt <= '0';

      --Jump selector signal
      s_jumpTypeSelector <= "11";

      --Output port signal
      s_outEnable <= '0';

      --ALU or STACK signal
      s_AluOrStack <= '0';

      --Store Enable Signal
      s_StoreEnable <= '0';
      --IADD
    ELSIF instructionInput = "01101" THEN
      -----Register Signals
      s_regWrite <= '1';
      s_regSrc <= '1';

      --ALU signals
      s_aluSrc <= '1';
      --CCR
      s_ccrEnable <= '1';
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
      s_wbSelector <= '1';

      --HLT signal
      s_hlt <= '0';

      --Jump selector signal
      s_jumpTypeSelector <= "11";

      --Output port signal
      s_outEnable <= '0';

      --ALU or STACK signal
      s_AluOrStack <= '0';

      --Store Enable Signal
      s_StoreEnable <= '0';
      --PUSH 
    ELSIF instructionInput = "10000" THEN
      -----Register Signals
      s_regWrite <= '0';
      s_regSrc <= '0';

      --ALU signals
      s_aluSrc <= '0';
      --CCR
      s_ccrEnable <= '0';
      s_setC <= '0';

      --Memory signals
      s_memWrite <= '1';
      s_memRead <= '0';
      s_branch <= '0';
      s_spEnable <= '1';
      s_popOrPush <= '0';

      --ALU/Input port signal
      s_aluInputPort <= '0';

      --W/B signals
      s_wbSelector <= '0';

      --HLT signal
      s_hlt <= '0';

      --Jump selector signal
      s_jumpTypeSelector <= "11";

      --Output port signal
      s_outEnable <= '0';
      --ALU or STACK signal
      s_AluOrStack <= '1';

      --Store Enable Signal
      s_StoreEnable <= '0';

      --POP
    ELSIF instructionInput = "10001" THEN
      -----Register Signals
      s_regWrite <= '1';
      s_regSrc <= '0';

      --ALU signals
      s_aluSrc <= '0';
      --CCR
      s_ccrEnable <= '0';
      s_setC <= '0';

      --Memory signals
      s_memWrite <= '0';
      s_memRead <= '1';
      s_branch <= '0';
      s_spEnable <= '1';
      s_popOrPush <= '1';

      --ALU/Input port signal
      s_aluInputPort <= '0';

      --W/B signals
      s_wbSelector <= '0';

      --HLT signal
      s_hlt <= '0';

      --Jump selector signal
      s_jumpTypeSelector <= "11";

      --Output port signal
      s_outEnable <= '0';
      --ALU or STACK signal
      s_AluOrStack <= '1';

      --Store Enable Signal
      s_StoreEnable <= '0';

      --LDM
    ELSIF instructionInput = "10010" THEN
      -----Register Signals
      s_regWrite <= '1';
      s_regSrc <= '0';

      --ALU signals
      s_aluSrc <= '1';
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
      s_wbSelector <= '1';

      --HLT signal
      s_hlt <= '0';

      --Jump selector signal
      s_jumpTypeSelector <= "11";

      --Output port signal
      s_outEnable <= '0';
      --ALU or STACK signal
      s_AluOrStack <= '0';

      --Store Enable Signal
      s_StoreEnable <= '0';

      --LDD

    ELSIF instructionInput = "10011" THEN
      -----Register Signals
      s_regWrite <= '1';
      s_regSrc <= '1';

      --ALU signals
      s_aluSrc <= '1';
      --CCR
      s_ccrEnable <= '0';
      s_setC <= '0';

      --Memory signals
      s_memWrite <= '0';
      s_memRead <= '1';
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
      s_jumpTypeSelector <= "11";

      --Output port signal
      s_outEnable <= '0';
      --ALU or STACK signal
      s_AluOrStack <= '0';

      --Store Enable Signal
      s_StoreEnable <= '0';

      --STD

    ELSIF instructionInput = "10100" THEN
      -----Register Signals
      s_regWrite <= '0';
      s_regSrc <= '1';

      --ALU signals
      s_aluSrc <= '0';
      --CCR
      s_ccrEnable <= '0';
      s_setC <= '0';

      --Memory signals
      s_memWrite <= '1';
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
      s_jumpTypeSelector <= "11";

      --Output port signal
      s_outEnable <= '0';
      --ALU or STACK signal
      s_AluOrStack <= '0';

      --Store Enable Signal
      s_StoreEnable <= '1';
      --JZ

    ELSIF instructionInput = "11000" THEN
      -----Register Signals
      s_regWrite <= '0';
      s_regSrc <= '0';

      --ALU signals
      s_aluSrc <= '1';
      --CCR
      s_ccrEnable <= '0';
      s_setC <= '0';

      --Memory signals
      s_memWrite <= '0';
      s_memRead <= '0';
      s_branch <= '1';
      s_spEnable <= '0';
      s_popOrPush <= '0';

      --ALU/Input port signal
      s_aluInputPort <= '0';

      --W/B signals
      s_wbSelector <= '0';

      --HLT signal
      s_hlt <= '0';

      --Jump selector signal
      s_jumpTypeSelector <= "00";

      --Output port signal
      s_outEnable <= '0';
      --ALU or STACK signal
      s_AluOrStack <= '0';

      --Store Enable Signal
      s_StoreEnable <= '0';

      --JN
      --JC
      --JMP
      --CALL
      --RET
      --INT
      --RTI
    END IF;
  END PROCESS;

  registerSource <= s_regSrc;
  s_aluOp <= instructionInput;

  controlUnitSignals <= s_regWrite & s_regSrc & s_aluSrc & s_aluOp & s_ccrEnable & s_setC & s_memWrite & s_memRead & s_branch & s_spEnable & s_popOrPush & s_aluInputPort & s_wbSelector & s_hlt & s_jumpTypeSelector & s_AluOrStack & s_StoreEnable & s_outEnable;

END a_controlunit;