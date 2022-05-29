LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY executeMemory IS
    PORT (
        clk : IN STD_LOGIC;
        --input ports
        i_flushEnable : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        i_readData1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        i_wbAddress : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        i_PC_plus_one : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        i_immediate : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        i_cuSignals : IN STD_LOGIC_VECTOR(22 DOWNTO 0);
        i_aluResult : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

        o_cuSignals : OUT STD_LOGIC_VECTOR(22 DOWNTO 0);
        o_readData1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        o_wbAddress : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        o_immediate : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        o_PC_plus_one : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        o_aluResult : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        o_branch : OUT STD_LOGIC;
        o_jumpTypeSelector : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        o_memRead : OUT STD_LOGIC;
        o_memWrite : OUT STD_LOGIC
    );
END executeMemory;

ARCHITECTURE a_executeMemoryBuffer OF executeMemory IS
BEGIN
    PROCESS (clk, i_flushEnable)
    BEGIN
        IF (i_flushEnable(1) = '1' AND rising_edge(clk)) THEN
            o_cuSignals <= (OTHERS => '0');
            o_readData1 <= (OTHERS => '0');
            o_wbAddress <= (OTHERS => '0');
            o_immediate <= (OTHERS => '0');
            o_PC_plus_one <= (OTHERS => '0');
            o_aluResult <= (OTHERS => '0');
            o_branch <= '0';
            o_jumpTypeSelector <= (OTHERS => '0');
            o_memRead <= '0';
            o_memWrite <= '0';
        ELSIF (rising_edge(clk)) THEN
            o_cuSignals <= i_cuSignals;
            o_readData1 <= i_readData1;
            o_wbAddress <= i_wbAddress;
            o_immediate <= i_immediate;
            o_PC_plus_one <= i_PC_plus_one;
            o_aluResult <= i_aluResult;
            o_branch <= i_cuSignals(10);
            o_jumpTypeSelector <= i_cuSignals(4 DOWNTO 3);
            o_memRead <= i_cuSignals(11);
            o_memWrite <= i_cuSignals(12);

        END IF;
    END PROCESS;
END a_executeMemoryBuffer;