LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY SignExtend IS
    PORT (
        i_input : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        o_output : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END SignExtend;

ARCHITECTURE a_signExtend OF SignExtend IS

BEGIN

    o_output <= "0000000000000000" & i_input;

END a_signExtend; -- a_signExtend