LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY e_3X8Decoder IS
    PORT (
        address : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        decodedAddress : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)

    );
END e_3X8Decoder;
ARCHITECTURE
    a_3x8Decoder OF e_3X8Decoder IS
BEGIN
    decodedAddress <= "00000001"WHEN address(2 DOWNTO 0) = "000"
        ELSE
        "00000010" WHEN address (2 DOWNTO 0) = "001"
        ELSE
        "00000100" WHEN address (2 DOWNTO 0) = "010"
        ELSE
        "00001000" WHEN address (2 DOWNTO 0) = "011"
        ELSE
        "00010000" WHEN address (2 DOWNTO 0) = "100"
        ELSE
        "00100000" WHEN address (2 DOWNTO 0) = "101"
        ELSE
        "01000000" WHEN address (2 DOWNTO 0) = "110"
        ELSE
        "10000000" WHEN address (2 DOWNTO 0) = "111"
        ELSE
        "00000000";

END a_3x8Decoder;