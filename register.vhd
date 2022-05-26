Library ieee;
use ieee.std_logic_1164.all;

Entity my_generic_register is 
Generic (n: integer :=32);
Port(
d:in std_logic_vector(n-1 downto 0);
enable,clk,rst : in std_logic;
q: out std_logic_vector(n-1 downto 0)
);
End my_generic_register;

Architecture Arch_Register of my_generic_register is
Begin 
Process(clk,rst)
Begin
IF(rst='1') THEN 
	q<= (others=>'0');
ELSIF (rising_edge(clk)) and enable='1' THEN
	q<=d;
End IF;
END Process;
End Arch_Register;