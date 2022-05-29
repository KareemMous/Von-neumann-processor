LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY my_generic_register IS
	GENERIC (n : INTEGER := 32);
	PORT (
		d : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		enable, clk, rst : IN STD_LOGIC;
		q : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
	);
END my_generic_register;

ARCHITECTURE Arch_Register OF my_generic_register IS
BEGIN
	PROCESS (clk, rst)
	BEGIN
		IF (rst = '1') THEN
			q <= (OTHERS => '0');
		ELSIF (falling_edge(clk)) AND enable = '1' THEN
			q <= d;
		END IF;
	END PROCESS;
END Arch_Register;