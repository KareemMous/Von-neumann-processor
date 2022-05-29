LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY mux4x11bit IS
    PORT (
        input0, input1, input2, input3 : IN STD_LOGIC;
        sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        outputSel : OUT STD_LOGIC
    );
END ENTITY mux4x11bit;

ARCHITECTURE a_mux4x11bit OF mux4x11bit IS
BEGIN
    outputSel <= input0 WHEN sel = "00" ELSE
        input1 WHEN sel = "01" ELSE
        input2 WHEN sel = "10" ELSE
        input3;
END ARCHITECTURE a_mux4x11bit;