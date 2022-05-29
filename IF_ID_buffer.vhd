LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY fetchDecode IS
	PORT (
		clk : IN STD_LOGIC;
		-- inputs to buffer
		i_instruction : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		i_PC_plus_one : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		i_inputPort : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		i_flushEnable : IN STD_LOGIC_VECTOR(1 DOWNTO 0);

		-- outputs 
		o_instruction31_27 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		o_instruction26_24 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		o_instruction23_21 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		o_instruction20_18 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		o_immediate : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		o_PC_plus_one : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		o_inputPort : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END fetchDecode;
ARCHITECTURE a_fetchDecode OF fetchDecode IS
BEGIN
	PROCESS (clk, i_flushEnable)
	BEGIN
		IF (i_flushEnable(1) = '1' AND rising_edge(clk)) THEN
			o_instruction31_27 <= "00000";
			o_immediate <= (OTHERS => '0');
			o_PC_plus_one <= (OTHERS => '0');
			o_inputPort <= (OTHERS => '0');
		ELSIF (rising_edge(clk) AND i_flushEnable(0) = '1') THEN
			o_instruction31_27 <= i_instruction(31 DOWNTO 27);
			o_instruction26_24 <= i_instruction(26 DOWNTO 24);
			o_instruction23_21 <= i_instruction(23 DOWNTO 21);
			o_instruction20_18 <= i_instruction(20 DOWNTO 18);
			o_immediate <= i_instruction(15 DOWNTO 0);
			o_PC_plus_one <= i_PC_plus_one;
			o_inputPort <= i_inputPort;
		END IF;
	END PROCESS;
END a_fetchDecode;