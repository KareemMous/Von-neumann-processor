LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY registerFile IS
	PORT (
		clk : IN STD_LOGIC;
		rst : IN STD_LOGIC;
		regWrite : IN STD_LOGIC;

		readRegister1 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		readRegister2 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);

		writeRegister : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		writeData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

		readData1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		readData2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END ENTITY registerFile;

ARCHITECTURE a_registerFile OF registerFile IS
	COMPONENT my_generic_register IS
		GENERIC (n : INTEGER := 32);
		PORT (
			d : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
			enable, clk, rst : IN STD_LOGIC;
			q : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
		);
	END COMPONENT;

	--Decoder for read Regisers 1 & 2 and write Register -->Address
	COMPONENT e_3x8Decoder IS
		PORT (
			address : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			decodedAddress : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT mux8x1 IS
		GENERIC (n : INTEGER := 32);
		PORT (
			input0, input1, input2, input3, input4, input5, input6, input7 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
			sel : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			outputSel : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT Tristate IS
		PORT (
			q : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			sel : IN STD_LOGIC;
			output : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	END COMPONENT;

	----Signals

	--temp signals for read data 1 and 2
	SIGNAL readOutput1, readOutput2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	--temp signals for q of each register
	SIGNAL qRegister0, qRegister1, qRegister2, qRegister3, qRegister4, qRegister5, qRegister6, qRegister7 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	--Decoded addresses
	SIGNAL readReg1Decoded : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL readReg2Decoded : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL writeRegDecoded : STD_LOGIC_VECTOR (7 DOWNTO 0);
	--Decoded enable
	SIGNAL decodedWriteEnable : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN

	--Read Register 1 decoder
	Decoder1Read : e_3x8Decoder
	PORT MAP(readRegister1, readReg1Decoded);

	--Read Register 2 decoder
	Decoder2Read : e_3x8Decoder
	PORT MAP(readRegister2, readReg2Decoded);

	--Write Register decoder
	Decoder1Write : e_3x8Decoder
	PORT MAP(writeRegister, writeRegDecoded);

	--Output the regWrite address
	--zeros if regWrite=0
	--write address if regWrite !=0

	decodedWriteEnable <= writeRegDecoded AND (regWrite & regWrite & regWrite & regWrite &
		regWrite & regWrite & regWrite & regWrite);
	--Writing in a Register
	--Mapping the outputs of the decoder to the registers
	Register0 : my_generic_register
	GENERIC MAP(32)
	PORT MAP(writeData, decodedWriteEnable(0), clk, rst, qRegister0);
	Register1 : my_generic_register
	GENERIC MAP(32)
	PORT MAP(writeData, decodedWriteEnable(1), clk, rst, qRegister1);
	Register2 : my_generic_register
	GENERIC MAP(32)
	PORT MAP(writeData, decodedWriteEnable(2), clk, rst, qRegister2);
	Register3 : my_generic_register
	GENERIC MAP(32)
	PORT MAP(writeData, decodedWriteEnable(3), clk, rst, qRegister3);
	Register4 : my_generic_register
	GENERIC MAP(32)
	PORT MAP(writeData, decodedWriteEnable(4), clk, rst, qRegister4);
	Register5 : my_generic_register
	GENERIC MAP(32)
	PORT MAP(writeData, decodedWriteEnable(5), clk, rst, qRegister5);
	Register6 : my_generic_register
	GENERIC MAP(32)
	PORT MAP(writeData, decodedWriteEnable(6), clk, rst, qRegister6);
	Register7 : my_generic_register
	GENERIC MAP(32)
	PORT MAP(writeData, decodedWriteEnable(7), clk, rst, qRegister7);
	--Reading rsrc1
	tristateBufferReg0Read1 : Tristate PORT MAP(qRegister0, readReg1Decoded(0), readData1);
	tristateBufferReg1Read1 : Tristate PORT MAP(qRegister1, readReg1Decoded(1), readData1);
	tristateBufferReg2Read1 : Tristate PORT MAP(qRegister2, readReg1Decoded(2), readData1);
	tristateBufferReg3Read1 : Tristate PORT MAP(qRegister3, readReg1Decoded(3), readData1);
	tristateBufferReg4Read1 : Tristate PORT MAP(qRegister4, readReg1Decoded(4), readData1);
	tristateBufferReg5Read1 : Tristate PORT MAP(qRegister5, readReg1Decoded(5), readData1);
	tristateBufferReg6Read1 : Tristate PORT MAP(qRegister6, readReg1Decoded(6), readData1);
	tristateBufferReg7Read1 : Tristate PORT MAP(qRegister7, readReg1Decoded(7), readData1);

	--Reading rsrc2
	tristateBufferReg0Read2 : Tristate PORT MAP(qRegister0, readReg2Decoded(0), readData2);
	tristateBufferReg1Read2 : Tristate PORT MAP(qRegister1, readReg2Decoded(1), readData2);
	tristateBufferReg2Read2 : Tristate PORT MAP(qRegister2, readReg2Decoded(2), readData2);
	tristateBufferReg3Read2 : Tristate PORT MAP(qRegister3, readReg2Decoded(3), readData2);
	tristateBufferReg4Read2 : Tristate PORT MAP(qRegister4, readReg2Decoded(4), readData2);
	tristateBufferReg5Read2 : Tristate PORT MAP(qRegister5, readReg2Decoded(5), readData2);
	tristateBufferReg6Read2 : Tristate PORT MAP(qRegister6, readReg2Decoded(6), readData2);
	tristateBufferReg7Read2 : Tristate PORT MAP(qRegister7, readReg2Decoded(7), readData2);

END ARCHITECTURE;