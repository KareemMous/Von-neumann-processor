library ieee;
Use ieee.std_logic_1164.all;

ENTITY e_3X8Decoder IS
PORT
(
address : IN std_logic_vector(2 DOWNTO 0);
decodedAddress : OUT std_logic_vector(7 DOWNTO 0)

);
end e_3X8Decoder;
ARCHITECTURE
a_3x8Decoder OF e_3X8Decoder is 
begin 
decodedAddress<= "00000001"when address(2 downto 0) ="000"
else "00000010" when  address (2 downto 0)="001"
else "00000100" when  address (2 downto 0)="010"
else "00001000" when address (2 downto 0)="011"
else "00010000" when address (2 downto 0)="100"
else "00100000" when address (2 downto 0)="101"
else "01000000" when address (2 downto 0)="110"
else "10000000" when address (2 downto 0)="111"
else "00000000";

end a_3x8Decoder;

