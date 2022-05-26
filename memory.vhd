
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY ram IS
	PORT(
		clk : IN std_logic;
		memWrite  : IN std_logic;
		memRead  : IN std_logic;
		instructionAddress : IN std_logic_vector(31 DOWNTO 0);
		dataAddress : IN std_logic_vector(31 DOWNTO 0);	
		address : IN  std_logic_vector(31 DOWNTO 0);
		writeData  : IN  std_logic_vector(31 DOWNTO 0);
		readData : OUT std_logic_vector(31 DOWNTO 0));
END ENTITY ram;

ARCHITECTURE syncrama OF ram IS

	TYPE ram_type IS ARRAY(0 TO 1048575) OF std_logic_vector(31 DOWNTO 0);
	SIGNAL ram : ram_type ;
	
	BEGIN
		PROCESS(clk) IS
			BEGIN
				IF rising_edge(clk) THEN  
					IF memWrite = '1' THEN
						ram(to_integer(unsigned(dataAddress))) <= writeData;
					END IF;
				END IF;
		END PROCESS;
		readData <= ram(to_integer(unsigned(dataAddress))) WHEN memRead='1';
END syncrama;
