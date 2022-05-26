LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY my_storeHandler IS
    PORT (
        i_immediate : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        i_readData2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        o_result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END my_storeHandler;

ARCHITECTURE a_storeHandler OF my_storeHandler IS
BEGIN
    o_result <= STD_LOGIC_VECTOR(unsigned(i_immediate(31 DOWNTO 0)) + unsigned(i_readData2(31 DOWNTO 0)));
END ARCHITECTURE;