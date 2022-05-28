library ieee;
use ieee.std_logic_1164.all;

entity mux2x1int is 
    port (
            input0,input1: in integer;
            sel:in std_logic;
            outputSel :out integer
        ); 
end entity mux2x1int;

architecture a_mux2x1int of mux2x1int is 
begin 
outputSel <=   input0 when sel = '0' else
                input1;  
 end architecture a_mux2x1int;