LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY My_nDFF_PC IS
	GENERIC (n : INTEGER := 32);
	PORT (
		CLK, RST : IN STD_LOGIC;
		D : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		Q : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0) := (OTHERS => '0')
	);
END My_nDFF_PC;

ARCHITECTURE a_nMY_DFF OF My_nDFF_PC IS
BEGIN
	PROCESS (clk, rst)
	BEGIN
		--IF (RST = '1') THEN
		--Q <= (OTHERS => '0');
		IF (rising_edge(clk)) THEN
			Q <= D;
		END IF;
	END PROCESS;
END a_nMY_DFF;