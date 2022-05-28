Library ieee;
use ieee.std_logic_1164.all;

Entity signextend is 
Port(
input:in std_logic_vector(15 downto 0);
output: out std_logic_vector(31 downto 0)
);
End signextend;

Architecture a_signextend of signextend is
Begin 
output<="0000000000000000"&input;
End a_signextend;