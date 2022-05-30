
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY My_nDFF_OUTPORT IS
      GENERIC (n : INTEGER := 32);
      PORT (
            W_Enable : IN STD_LOGIC;
            D : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            Q : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
      );
END My_nDFF_OUTPORT;

ARCHITECTURE a_nMY_DFF OF My_nDFF_OUTPORT IS
BEGIN

      Q <= D WHEN W_Enable = '1';

END a_nMY_DFF;