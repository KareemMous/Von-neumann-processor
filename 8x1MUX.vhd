library ieee;
use ieee.std_logic_1164.all;

entity mux8x1 is 
	Generic (n: integer :=32);
    port (
            input0,input1,input2,input3,input4,input5,input6,input7: in std_logic_vector(n-1 downto 0);
            sel:in std_logic_vector(2 downto 0);
            outputSel :out std_logic_vector(n-1 downto 0)
        ); 
end entity mux8x1;

architecture a_mux8x1 of mux8x1 is 
begin 
with sel select 
outputSel <=    input0 when "000",
                input1 when "001",
                input2 when "010",
                input3 when "011",
                input4 when "100",
                input5 when "101",
                input6 when "110",
                input7 when "111",
		x"00000000" when others;
 end architecture a_mux8x1;
