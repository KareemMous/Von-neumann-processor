LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY forwardingunit IS

    PORT (

        --From EX/MEM
        i_EX_MEM_writeAddress : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        i_EX_MEM_wbSelector : IN STD_LOGIC;

        --From MEM/WB
        i_MEM_WB_writeAddress : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        i_MEM_WB_wbSelector : IN STD_LOGIC;

        --From IF/ID
        i_IF_ID_readRegister1 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        i_IF_ID_readRegister2 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);

        --Forwarding unit outputs to th MUXs
        o_forwardSignalOp1 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        o_forwardSignalOp2 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END forwardingunit;

ARCHITECTURE a_forwardingunit OF forwardingunit IS
BEGIN

    o_forwardSignalOp1 <=
        "01" WHEN (i_EX_MEM_wbSelector = '1' AND i_IF_ID_readRegister1 = i_EX_MEM_writeAddress)
        ELSE
        "10" WHEN (i_MEM_WB_wbSelector = '1' AND i_IF_ID_readRegister1 = i_MEM_WB_writeAddress)
        ELSE
        "00";

    o_forwardSignalOp2 <= "01" WHEN i_EX_MEM_wbSelector = '1' AND i_IF_ID_readRegister2 = i_EX_MEM_writeAddress ELSE
        "10" WHEN i_MEM_WB_wbSelector = '1' AND i_IF_ID_readRegister2 = i_MEM_WB_writeAddress ELSE
        "00";

END a_forwardingunit;