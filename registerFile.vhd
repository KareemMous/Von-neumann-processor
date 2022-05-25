library ieee;
use ieee.std_logic_1164.all;

ENTITY registerFile IS
	PORT(
		clk : IN std_logic;
		rst  : IN std_logic;
		regWrite : IN std_logic;

		readRegister1 : IN std_logic_vector(2 DOWNTO 0);
		readRegister2 : IN std_logic_vector(2 DOWNTO 0);

		writeRegister : IN  std_logic_vector(2 DOWNTO 0);
		writeData : IN std_logic_vector(31 DOWNTO 0);

		readData1 : OUT std_logic_vector(31 DOWNTO 0);
		readData2 : OUT std_logic_vector(31 DOWNTO 0)
);
END ENTITY registerFile;



Architecture a_registerFile of registerFile is 
Component my_generic_register is 
Generic (n: integer :=32);
Port(
d:in std_logic_vector(n-1 downto 0);
enable,clk,rst : in std_logic;
q: out std_logic_vector(n-1 downto 0)
);
End Component;