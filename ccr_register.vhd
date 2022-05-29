Library ieee;
use ieee.std_logic_1164.all;

Entity ccr_register is 
--Generic (n: integer :=32);
Port(

--ccr input flags from alu
d:in std_logic_vector(2 downto 0):= (others =>'0') ; 

--ccr enable from ex/mem
ccrEnable,clk : in std_logic;

--setC signal from ex/mem
setC: in std_logic;

--ccr output flags to jumpTypeSelector mux
q: out std_logic_vector(2 downto 0):= (others =>'0') 

);
End ccr_register;

Architecture a_ccrRegister of ccr_register is
Begin 
Process(clk,setC)
Begin
IF (rising_edge(clk)) and ccrEnable='1' and setC='1' THEN
	q<='1'&d(1 downto 0);
elsif (rising_edge(clk)) and ccrEnable='1' and setC='0' then
		q<=d;
End IF;
END Process;
End a_ccrRegister;