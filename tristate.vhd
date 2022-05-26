LIBRARY IEEE;
USE IEEE.std_logic_1164.all;


ENTITY Tristate IS
PORT( q : IN std_logic_vector (31 DOWNTO 0);
 sel: IN std_logic;
  output: OUT std_logic_vector (31 DOWNTO 0)
);
END Tristate;




ARCHITECTURE  a_tristate OF Tristate IS
BEGIN
     output <= (others=>'Z') WHEN sel='0'
     ELSE q  WHEN sel='1';
END a_tristate;


