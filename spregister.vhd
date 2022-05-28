Library ieee;
use ieee.std_logic_1164.all;

Entity spregister is 
Generic (n: integer :=32);
Port(
d:in std_logic_vector(n-1 downto 0);
enable,clk,rst : in std_logic;
q: out std_logic_vector(n-1 downto 0)
);
End spregister;

Architecture a_spregister of spregister is
Begin 
Process(clk,rst)


Begin
IF(rst='1') THEN 
	q<= x"0000FFFFF";--2^20-1
ELSIF (falling_edge(clk)) and enable='1' THEN
	q<=d;
End IF;
END Process;
End a_spregister;