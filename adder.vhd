LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY adder IS
  GENERIC (n : INTEGER := 32);
  PORT (
    D : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
    val : INTEGER;
    Q : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
  );
END adder;

ARCHITECTURE arch OF adder IS

BEGIN
  Q <= STD_LOGIC_VECTOR(
    to_signed(
    to_integer(unsigned(D)) + val
    , n));

END ARCHITECTURE; -- arch