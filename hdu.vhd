LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY hazardDetectionUnit IS
    PORT (
        rst : IN STD_LOGIC;
        i_memRead_ID_EX : IN STD_LOGIC;
        i_memWrite_ID_EX : IN STD_LOGIC;
        i_Rdst_ID_EX : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        i_memReadAdd_EX_MEM : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        i_memWriteAdd_EX_MEM : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        i_Rsrc1_DS : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        i_Rsrc2_DS : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        o_flushEnable : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        o_structuralHazard : OUT STD_LOGIC;
        i_branch : IN STD_LOGIC;
        i_hlt : IN STD_LOGIC
    );
END hazardDetectionUnit;

ARCHITECTURE arch OF hazardDetectionUnit IS

BEGIN
    o_flushEnable(0) <= '0' WHEN (i_memRead_ID_EX = '1' AND ((i_Rdst_ID_EX = i_Rsrc1_DS) OR (i_Rdst_ID_EX = i_Rsrc2_DS))) ELSE
    '1';
    o_flushEnable(1) <= ('1') WHEN (JumpOrNot = '1' OR ReturnSignal = '1') ----When there is jump we flush the buffer at the ID/EX
ELSE
    ('0');

END ARCHITECTURE; -- arch
© 2022 GitHub, Inc.
Terms
Pr