LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY EX_Stage IS
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        i_flushEnable : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        i_readData1, i_readData2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        i_wbAddress : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        i_PC_plus_one : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        i_inputPort : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        i_immediate : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        i_cuSignals : IN STD_LOGIC_VECTOR(22 DOWNTO 0);

        o_aluResult : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        o_flagValues : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        o_Imm : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        o_Datafromsrc1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        o_wbAddress : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        o_inputPort : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)

    );
END EX_Stage;

ARCHITECTURE a_exStage OF EX_Stage IS

    COMPONENT mux2x1 IS
        GENERIC (n : INTEGER := 32);
        PORT (
            input0, input1 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            sel : IN STD_LOGIC;
            outputSel : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT ALU IS
        PORT (
            operandOne : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
            operandTwo : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
            AluOp : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            flags : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            reset : IN STD_LOGIC
        );
    END COMPONENT;

    COMPONENT decodeExecute IS
        PORT (
            clk : IN STD_LOGIC;
            --input ports
            i_flushEnable : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            i_readData1, i_readData2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_wbAddress : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            i_PC_plus_one : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_inputPort : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_immediate : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_cuSignals : IN STD_LOGIC_VECTOR(22 DOWNTO 0);
            o_readData1, o_readData2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            o_aluOP : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            o_aluSrc : OUT STD_LOGIC;
            o_cuSignals : OUT STD_LOGIC_VECTOR(22 DOWNTO 0); --23 cu signals - 5 opcode - 1 alusrc = 17 cu signals left to be passed over 
            o_wbAddress : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            o_immediate : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            o_inputPort : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            o_PC_plus_one : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL s_readData1, s_readData2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_aluOP : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL s_aluSrc : STD_LOGIC;
    SIGNAL s_cuSignals : STD_LOGIC_VECTOR(22 DOWNTO 0); --23 cu signals - 5 opcode - 1 alusrc = 17 cu signals left to be passed over 
    SIGNAL s_wbAddress : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL s_immediate : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_inputPort : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_PC_plus_one : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_mux1_readData2OrImm : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_mux2_mux1OrStoreHandler : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_storeHandler : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_aluResult : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_flags : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN

    ID_EX : decodeExecute PORT MAP(clk, i_flushEnable, i_readData1, i_readData2, i_wbAddress, i_PC_plus_one, i_inputPort, i_immediate, i_cuSignals, s_readData1, s_readData2, s_aluOP, s_aluSrc, s_cuSignals, s_wbAddress, s_immediate, s_inputPort, s_PC_plus_one);
    --store handler

    mux1 : mux2x1 PORT MAP(s_readData2, s_immediate, i_cuSignals(20), s_mux1_readData2OrImm);
    mux2 : mux2x1 PORT MAP(s_mux1_readData2OrImm, s_storeHandler, i_cuSignals(1), s_mux2_mux1OrStoreHandler);

    c_alu : ALU PORT MAP(s_readData1, s_mux2_mux1OrStoreHandler, i_cuSignals(19 DOWNTO 15), s_aluResult, s_flags, rst);
END a_exStage; -- a_exStage