LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY memoryWriteBack IS
    PORT (
        clk : IN STD_LOGIC;

        --Flush enable
        i_flushEnable : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        --Data from ALU/INPUT PORT MUX
        i_aluInputPortData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

        --Data from MEMORY
        i_memoryData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

        --Write back address
        i_wbAddress : IN STD_LOGIC_VECTOR(2 DOWNTO 0);

        --Control unit from EX/MEM buffer
        i_cuSignals : IN STD_LOGIC_VECTOR(22 DOWNTO 0);
        --Write back selector to the MUX and the forwarding unit
        o_wbSelector : OUT STD_LOGIC;

        --regWrite signal to register file
        o_regWrite : OUT STD_LOGIC;

        --Write Address signal for the forwarding unit
        o_writeAddressFU : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);

        --memory data
        o_memoryData : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);

        --ALU/INPUT input port data
        o_aluInputPortData : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END memoryWriteBack;

ARCHITECTURE a_memoryWriteBack OF memoryWriteBack IS
BEGIN
    PROCESS (clk, i_flushEnable)
    BEGIN
        IF (i_flushEnable(1) = '1' AND rising_edge(clk)) THEN

            o_wbSelector <= '0';

            o_regWrite <= '0';

            o_writeAddressFU <= (OTHERS => '0');

            o_memoryData <= (OTHERS => '0');

            o_aluInputPortData <= (OTHERS => '0');

        ELSIF (rising_edge(clk)) THEN

            o_wbSelector <= i_cuSignals(6);

            o_regWrite <= i_cuSignals(22);

            o_writeAddressFU <= i_wbAddress;

            o_memoryData <= i_memoryData;

            o_aluInputPortData <= i_aluInputPortData;

        END IF;
    END PROCESS;
END a_memoryWriteBack;