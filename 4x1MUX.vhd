library ieee;
use ieee.std_logic_1164.all;

entity mux4x1 is 
	Generic (n: integer :=32);
    port (
            input0,input1,input2,input3: in std_logic_vector(n-1 downto 0);
            sel:in std_logic_vector(1 downto 0);
            outputSel :out std_logic_vector(n-1 downto 0)
        ); 
end entity mux4x1;

architecture a_mux4x1 of mux4x1 is 
begin 
outputSel <=   input0 when sel = "00" else
                input1 when sel = "01" else
                input2 when sel ="10"  else 
                input3;                 
 end architecture a_mux4x1;