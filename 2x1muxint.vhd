LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY mux2x1int IS
    PORT (
        input0, input1 : IN INTEGER;
        sel : IN STD_LOGIC;
        outputSel : OUT INTEGER;
        spEnable : IN STD_LOGIC
    );
END ENTITY mux2x1int;

ARCHITECTURE a_mux2x1int OF mux2x1int IS
BEGIN
    outputSel <= input0 WHEN sel = '0' AND spEnable = '1' ELSE
        input1 WHEN sel = '1' AND spEnable = '1' ELSE
        0;
END ARCHITECTURE a_mux2x1int;