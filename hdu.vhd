LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY hazardDetectionUnit IS
    PORT (
        rst : IN STD_LOGIC;
        i_memRead_ID_EX : IN STD_LOGIC;
        i_memWrite_ID_EX : IN STD_LOGIC;
        i_Rdst_ID_EX : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        -- i_memReadAdd_EX_MEM : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        -- i_memWriteAdd_EX_MEM : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        i_Rsrc1_DS : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        i_Rsrc2_DS : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        i_branch : IN STD_LOGIC;
        -- i_ReturnSignal : IN STD_LOGIC;
        i_hlt : IN STD_LOGIC;
        o_flushEnable_IF_ID : OUT STD_LOGIC_VECTOR(1 DOWNTO 0) := "01";
        o_flushEnable_ID_EX : OUT STD_LOGIC_VECTOR(1 DOWNTO 0) := "01";
        o_flushEnable_EX_MEM : OUT STD_LOGIC_VECTOR(1 DOWNTO 0) := "01";
        o_flushEnable_WB : OUT STD_LOGIC_VECTOR(1 DOWNTO 0) := "01";
        o_structuralHazard : OUT STD_LOGIC := '0'
    );
END hazardDetectionUnit;

ARCHITECTURE arch OF hazardDetectionUnit IS

BEGIN
    o_flushEnable_IF_ID(0) <= '0' WHEN (i_memRead_ID_EX = '1' AND ((i_Rdst_ID_EX = i_Rsrc1_DS) OR (i_Rdst_ID_EX = i_Rsrc2_DS)))
ELSE
    '1';

    o_flushEnable_IF_ID(0) <= '0' WHEN (i_memRead_ID_EX = '1' AND i_memWrite_ID_EX = '1');
    o_flushEnable_IF_ID(1) <= '1' WHEN (i_branch = '1' OR rst = '1') ----When there is jump we flush the buffer at the IF/ID
ELSE
    '0';

    o_flushEnable_ID_EX(1) <= '1' WHEN (i_branch = '1' OR rst = '1') ----When there is jump we flush the buffer at the ID/EX
ELSE
    '0';
    o_flushEnable_EX_MEM(1) <= '1' WHEN (i_branch = '1' OR rst = '1') ----When there is jump we flush the buffer at the EX/MEM
ELSE
    '0';
    o_flushEnable_WB(1) <= '1' WHEN (i_branch = '1' OR rst = '1') ----When there is jump we flush the buffer at the WB
ELSE
    '0';

    o_structuralHazard <= '1' WHEN i_hlt = '1'
        ELSE
        '0' WHEN rst = '1';

END ARCHITECTURE; -- arch