LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Memory IS
	PORT (
		clk : IN STD_LOGIC;
		rst : IN STD_LOGIC;

		--Data Segment
		i_memWrite : IN STD_LOGIC;
		i_memRead : IN STD_LOGIC;
		i_dataAddress : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		i_writeData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

		--Instruction segment
		i_PC : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		--Outputs 
		o_instruction : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		o_dataOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END ENTITY Memory;

ARCHITECTURE a_Memory OF Memory IS
	TYPE ram_type IS ARRAY(0 TO 1048575) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL ram : ram_type;
	SIGNAL instructionEnable : STD_LOGIC;
BEGIN
	PROCESS (clk, i_memRead, rst) IS
	BEGIN
		IF (rst = '1') THEN
			instructionEnable <= '0';
			o_instruction <= ram(0);

		ELSIF i_memWrite = '1' THEN
			IF falling_edge(clk) THEN
				o_dataOut <= (OTHERS => 'Z');
				ram(to_integer(unsigned(i_dataAddress))) <= i_writeData;
			END IF;
		ELSIF i_memRead = '1' AND falling_edge(clk) THEN

			o_dataOut <= ram(to_integer(unsigned(i_dataAddress)));
			--ELSE --No memory operation 
			--o_instruction <= ram(to_integer(unsigned(i_PC)));
		END IF;
		IF (rst = '0') THEN
			o_instruction <= ram(to_integer(unsigned(i_PC)));
		END IF;
	END PROCESS;
END a_Memory;