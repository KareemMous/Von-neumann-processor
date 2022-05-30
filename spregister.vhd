LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY spregister IS
	GENERIC (n : INTEGER := 32);
	PORT (
		d : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		enable : IN STD_LOGIC;
		clk, rst : IN STD_LOGIC;
		q : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0) := x"000FFFFF";
		inc : OUT INTEGER;
		DEC : OUT INTEGER
	);
END spregister;

ARCHITECTURE a_spregister OF spregister IS
BEGIN
	PROCESS (clk, rst, enable)
	BEGIN
		IF (rst = '1') THEN
			q <= x"000FFFFF";--2^20-1
		ELSIF (falling_edge(clk)) AND enable = '1' THEN
			q <= d;
			inc <= 1;
			dec <= - 1;
		END IF;
	END PROCESS;
END a_spregister;