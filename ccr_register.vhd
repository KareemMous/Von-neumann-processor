LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ccr_register IS
	--Generic (n: integer :=32);
	PORT (

		--ccr input flags from alu
		d : IN STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');

		--ccr enable from ex/mem
		ccrEnable, clk : IN STD_LOGIC;

		--setC signal from ex/mem
		setC : IN STD_LOGIC;

		--ccr output flags to jumpTypeSelector mux
		q : OUT STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0')

	);
END ccr_register;

ARCHITECTURE a_ccrRegister OF ccr_register IS
BEGIN
	PROCESS (clk, setC)
	BEGIN
		IF (rising_edge(clk)) AND ccrEnable = '1' AND setC = '1' THEN
			q <= d(2 DOWNTO 1) & '1';
		ELSIF (rising_edge(clk)) AND ccrEnable = '1' AND setC = '0' THEN
			q <= d;
		END IF;
	END PROCESS;
END a_ccrRegister;