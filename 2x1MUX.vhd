library ieee;
use ieee.std_logic_1164.all;

entity mux2x1 is 
	Generic (n: integer :=16);
    port (
            input0,input1: in std_logic_vector(n-1 downto 0);
            sel:in std_logic;
            outputSel :out std_logic_vector(n-1 downto 0)
        ); 
end entity mux2x1;

architecture a_mux2x1 of mux2x1 is 
begin 
outputSel <=   input0 when sel = '0' else
                input1;  
 end architecture a_mux2x1;