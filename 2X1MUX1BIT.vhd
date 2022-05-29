LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY mux2x11bit IS
    PORT (
        input0, input1 : IN STD_LOGIC;
        sel : IN STD_LOGIC;
        outputSel : OUT STD_LOGIC
    );
END ENTITY mux2x11bit;

ARCHITECTURE a_mux2x11bit OF mux2x11bit IS
BEGIN
    outputSel <= input0 WHEN sel = '0' ELSE
        input1;
END ARCHITECTURE a_mux2x11bit;