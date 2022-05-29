LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
ENTITY Tristate IS
     PORT (
          q : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
          sel : IN STD_LOGIC;
          output : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
     );
END Tristate;
ARCHITECTURE a_tristate OF Tristate IS
BEGIN
     output <= (OTHERS => 'Z') WHEN sel = '0'
          ELSE
          q WHEN sel = '1';
END a_tristate;