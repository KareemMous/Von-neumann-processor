
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

entity controlunit is 
port (
                --Instruction(31-27)
                instructionInput: IN std_logic_vector(4 DOWNTO 0); 
                --RegSrc Sginal
                registerSource: OUT std_logic();
                 --controlUnitSignals
                controlUnitSignals: OUT std_logic_vector()
);
end controlunit;

ARCHITECTURE a_controlunit OF controlunit IS

--Reg
--RegSrc	MemRead  	W/B selector	ALU/InputPort	ALUOp  MemWrite	 ALUSrc	RegWrite	NOP	HLT	SETC	OUTEnable Branch JumpTypeSelector CCREnable	SPEnable	PUSH/POP 	ALU/Stack	HLT Signal

 
--Register Signals
Signal s_regWrite:std_logic;
Signal s_regSrc:std_logic;


--ALU signals
Signal s_aluSrc:std_logic;
Signal s_aluOp:std_logic_vector(4 DOWNTO 0)


--CCR
Signal s_ccrEnable:std_logic;
Signal s_setC:std_logic;


--Memory signals
Signal s_memWrite:std_logic;
Signal s_memRead:std_logic;
Signal s_branch:std_logic;
Signal s_spEnable:std_logic;
Signal s_popOrPush:std_logic;


--ALU/Input port signal
Signal s_aluInputPort:std_logic_vector;


--W/B signals
Signal s_wbSelector:std_logic;


--HLT signal
Signal s_hlt:std_logic;


--Jump selector signal
Signal s_jumpTypeSelector:std_logic_vector(1 DOWNTO 0);

begin 
  process(instructionInput)
  begin

--NOP
 if instructionInput = "00000" then -- Zero
-----Register Signals
s_regWrite<= '0';
 s_regSrc<= '0';

--ALU signals
 s_aluSrc<= '0';
 s_aluOp<= '00000';

--CCR
s_ccrEnable<= '0';
 s_setC<= '0';

--Memory signals
 s_memWrite<= '0';
 s_memRead<= '0';
 s_branch<= '0';
 s_spEnable<= '0';
s_popOrPush<= '0';

--ALU/Input port signal
s_aluInputPort<= '0';

--W/B signals
  s_wbSelector<= '0';

--HLT signal
   s_hlt<= '0';

--Jump selector signal
s_jumpTypeSelector<= '00';

elsif



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




  end process;



END a_controlunit;
