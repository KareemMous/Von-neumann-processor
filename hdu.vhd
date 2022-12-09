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
    PROCESS (i_memRead_ID_EX, i_memWrite_ID_EX)
    BEGIN
        IF (i_memRead_ID_EX = '1' OR i_memWrite_ID_EX = '1') THEN
            o_flushEnable_IF_ID(0) <= '0';
        ELSE
            o_flushEnable_IF_ID(0) <= '1';
        END IF;
    END PROCESS;

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

    o_structuralHazard <= '1' WHEN(i_hlt = '1'OR i_memRead_ID_EX = '1' OR i_memWrite_ID_EX = '1')
        ELSE
        '0' WHEN rst = '1'
        ELSE
        '0';

END ARCHITECTURE; -- arch