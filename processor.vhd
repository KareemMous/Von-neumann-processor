LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Processor IS
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;

        i_PC : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        i_inputPort : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

        o_aluResult : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        o_flagValues : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        o_Imm : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        o_Datafromsrc1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        o_wbAddress : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        o_inputPort : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        --o_inputPort : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)

    );
END Processor;

ARCHITECTURE a_processor OF Processor IS

    --------------------------------------------------------------------------
    --------------------Fetch Stage-------------------------------------------
    --------------------------------------------------------------------------
    COMPONENT Memory IS
        PORT (
            clk : IN STD_LOGIC;

            --Data Segment
            i_memWrite : IN STD_LOGIC;
            i_memRead : IN STD_LOGIC;
            i_dataAddress : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_writeData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

            --Instruction segment
            i_PC : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            --Outputs 
            o_instruction : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            o_dataOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
    END COMPONENT;
    --------------------------------------------------------------------------
    --------------------Fetch Stage SIgnals-----------------------------------
    --------------------------------------------------------------------------

    SIGNAL s_PC_FS : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_pc_plus_one_FS : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_instruction_FS : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_dataAddress_FS : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_writeData_FS : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_flushEnable_FS : STD_LOGIC_VECTOR(1 DOWNTO 0);

    --------------------------------------------------------------------------
    -------------------------IF/ID buffer-------------------------------------
    --------------------------------------------------------------------------

    COMPONENT fetchDecode IS
        PORT (
            clk : IN STD_LOGIC;
            -- inputs to buffer
            i_instruction : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_PC_plus_one : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_inputPort : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_flushEnable : IN STD_LOGIC_VECTOR(1 DOWNTO 0);

            -- outputs 
            o_instruction31_27 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            o_instruction26_24 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            o_instruction23_21 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            o_instruction20_18 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            o_immediate : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            o_PC_plus_one : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            o_inputPort : IN STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;

    --------------------------------------------------------------------------
    ----------------------------------Decode Stage----------------------------
    --------------------------------------------------------------------------
    COMPONENT SignExtend IS
        PORT (
            i_input : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            o_output : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;
    COMPONENT controlunit IS
        PORT (
            --Instruction(31-27)
            instructionInput : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            --RegSrc Sginal
            registerSource : OUT STD_LOGIC;
            --controlUnitSignals
            controlUnitSignals : OUT STD_LOGIC_VECTOR(22 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT registerFile IS
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            regWrite : IN STD_LOGIC;

            readRegister1 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            readRegister2 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);

            writeRegister : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            writeData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

            readData1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            readData2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;
    --------------------------------------------------------------------------
    -------------------Decode Stage Signals-----------------------------------
    --------------------------------------------------------------------------

    -----inputs to buffer---------

    SIGNAL s_flushEnable_DS : STD_LOGIC_VECTOR(1 DOWNTO 0);

    ------outputs from buffer--------
    SIGNAL s_instruction31_27_DS : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL s_instruction26_24_DS : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL s_instruction23_21_DS : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL s_instruction20_18_DS : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL s_immediate_DS : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL s_PC_plus_one_DS : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_inputPort_DS : STD_LOGIC_VECTOR(31 DOWNTO 0);
    -------------- signals in decode stage --------------
    SIGNAL s_readData1_DS : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_readData2_DS : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_CU_signals_DS : STD_LOGIC_VECTOR(22 DOWNTO 0);
    SIGNAL s_signExtend_DS : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_writeData_DS : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_regSrc_DS : STD_LOGIC;
    -- output of mux to register file---
    SIGNAL s_mux_DS : STD_LOGIC_VECTOR(2 DOWNTO 0);
    --------------------------------------------------------------------------
    --------------------------ID/EX Buffer------------------------------------
    --------------------------------------------------------------------------

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

    ------------------------ID/EX Buffer Signals------------------------------------
    SIGNAL s_flushEnable_ID_EX : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL s_readData1_ID_EX : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_readData2_ID_EX : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_wbAddress_ID_EX : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL s_PC_plus_one_ID_EX : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_inputPort_ID_EX : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_immediate_ID_EX : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_cuSignals_ID_EX : STD_LOGIC_VECTOR(22 DOWNTO 0);
    SIGNAL s_aluOP_ID_EX : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL s_aluSrc_ID_EX : STD_LOGIC;
    ------------------------Store handler------------------------------------

    -----------------------------Execute Stage------------------------------------------
    COMPONENT my_storeHandler IS
        PORT (
            i_immediate : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_readData2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            o_result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
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
    COMPONENT mux2x1 IS
        GENERIC (n : INTEGER := 32);
        PORT (
            input0, input1 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            sel : IN STD_LOGIC;
            outputSel : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
        );
    END COMPONENT;
    -----------------------------Execute Stage Signals------------------------------------------
    SIGNAL s_mux1_readData2OrImm : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_mux2_mux1OrStoreHandler : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_storeHandler : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_aluResult : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_flags : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL s_SP : STD_LOGIC_VECTOR(31 DOWNTO 0);

    --------------------------Memory Stage Signals------------------------------------
    COMPONENT executeMemory IS
        PORT (
            clk : IN STD_LOGIC;
            --input ports
            i_flushEnable : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            i_readData1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_wbAddress : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            i_PC_plus_one : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_inputPort : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_immediate : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            i_cuSignals : IN STD_LOGIC_VECTOR(22 DOWNTO 0);
            i_aluResult : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

            o_cuSignals : OUT STD_LOGIC_VECTOR(22 DOWNTO 0);
            o_readData1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            o_wbAddress : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            o_immediate : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            o_PC_plus_one : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            o_inputPort : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            o_aluResult : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            o_branch : OUT STD_LOGIC;
            o_jumpTypeSelector : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            o_memRead : OUT STD_LOGIC;
            o_memWrite : OUT STD_LOGIC
        );
    END COMPONENT;
    SIGNAL s_cuSignals_EX_MEM : STD_LOGIC_VECTOR(22 DOWNTO 0);
    SIGNAL s_readData1_EX_MEM : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_flushEnable_EX_MEM : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL s_wbAddress_EX_MEM : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL s_immediate_EX_MEM : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_PC_plus_one_EX_MEM : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_inputPort_EX_MEM : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_aluResult_EX_MEM : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_branch_EX_MEM : STD_LOGIC;
    SIGNAL s_jumpTypeSelector_EX_MEM : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL s_memRead_EX_MEM : STD_LOGIC;
    SIGNAL s_memWrite_EX_MEM : STD_LOGIC;
    SIGNAL s_dataMemory : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_mux_alu_inputPort : STD_LOGIC_VECTOR(31 DOWNTO 0);

    --Memory/Write back buffer

    COMPONENT memoryWriteBack IS
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
    END COMPONENT;

    SIGNAL s_wbSelector_WB : STD_LOGIC;
    SIGNAL s_regWrite_WB : STD_LOGIC;
    SIGNAL s_writeAddressFU_WB : STD_LOGIC_VECTOR(2 DOWNTO 0);

    SIGNAL s_flushEnable_WB : STD_LOGIC_VECTOR(1 DOWNTO 0);

    SIGNAL s_aluInputPortData_WB : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_memoryData_WB : STD_LOGIC_VECTOR(31 DOWNTO 0);

    --Write data signal
    SIGNAL s_writeData_WB : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN
    -------------------------Fetch Stage------------------------------------

    s_flushEnable_FS <= "01";
    s_flushEnable_DS <= (OTHERS => '0');
    s_flushEnable_WB <= (OTHERS => '0');

    muxwritedata : mux2x1 PORT MAP(
        s_readData1_EX_MEM,
        --to be edited
        s_immediate_ID_EX,
        '0', s_writeData_FS);

    muxWriteAddress : mux2x1 PORT MAP(
        s_aluResult_EX_MEM,
        --to be edited
        s_SP,
        '0', s_dataAddress_FS);
    mem : Memory PORT MAP(
        clk,
        s_memWrite_EX_MEM,
        s_memRead_EX_MEM,
        s_dataAddress_FS,
        s_writeData_FS,
        i_PC,
        s_instruction_FS,
        s_dataMemory
    );

    s_pc_plus_one_FS <= STD_LOGIC_VECTOR(to_unsigned((to_integer((unsigned(i_PC))) + 1), 32));
    -- --------------------------IF/ID Buffer------------------------------------
    IF_ID : fetchDecode PORT MAP(
        clk,
        s_instruction_FS,
        s_pc_plus_one_FS,
        i_inputPort,
        s_flushEnable_FS,
        s_instruction31_27_DS,
        s_instruction26_24_DS,
        s_instruction23_21_DS,
        s_instruction20_18_DS,
        s_immediate_DS,
        s_PC_plus_one_DS,
        s_inputPort_DS

    );

    signext : SignExtend PORT MAP(
        s_immediate_DS,
        s_signExtend_DS
    );

    ---------------------------Decode Stage----------------------------------------

    cu : controlunit PORT MAP(
        s_instruction31_27_DS,
        s_regSrc_DS,
        s_CU_signals_DS
    );

    muxregsrc : mux2x1 GENERIC MAP(3) PORT MAP(s_instruction26_24_DS, s_instruction23_21_DS, s_regSrc_DS, s_mux_DS);
    regfile : registerFile PORT MAP(
        clk,
        rst,
        s_regWrite_wb,
        s_mux_DS,
        s_instruction20_18_DS,
        s_instruction26_24_DS,
        --input from memosry stage either alu or memory
        s_writeData_WB,
        s_readData1_DS,
        s_readData2_DS

    );
    --------------------------Decode Execute Buffer--------------------------------------
    ID_EX : decodeExecute PORT MAP(
        clk,
        s_flushEnable_DS,
        s_readData1_DS,
        s_readData2_DS,
        s_instruction26_24_DS,
        s_PC_plus_one_DS,
        s_inputPort_DS,
        s_signExtend_DS,
        s_CU_signals_DS,
        s_readData1_ID_EX,
        s_readData2_ID_EX,
        s_aluOP_ID_EX,
        s_aluSrc_ID_EX,
        s_cuSignals_ID_EX,
        s_wbAddress_ID_EX,
        s_immediate_ID_EX,
        s_inputPort_ID_EX,
        s_PC_plus_one_ID_EX
    );
    ----------------------------------Execute Stage------------------------------------------------------
    storehandler : my_storeHandler PORT MAP(
        s_immediate_ID_EX,
        s_readData2_ID_EX,
        s_storeHandler
    );

    mux1 : mux2x1 PORT MAP(s_readData2_ID_EX, s_immediate_ID_EX, s_aluSrc_ID_EX, s_mux1_readData2OrImm);
    mux2 : mux2x1 PORT MAP(s_mux1_readData2OrImm, s_storeHandler, s_cuSignals_ID_EX(1), s_mux2_mux1OrStoreHandler);

    c_alu : ALU PORT MAP(
        s_readData1_ID_EX,
        s_mux2_mux1OrStoreHandler,
        s_aluOP_ID_EX,
        s_aluResult,
        s_flags,
        rst
    );

    o_aluResult <= s_aluResult;
    o_flagValues <= s_flags;
    o_Imm <= s_immediate_ID_EX;
    o_Datafromsrc1 <= s_readData1_ID_EX;
    o_wbAddress <= s_wbAddress_ID_EX;
    o_inputPort <= s_inputPort_ID_EX;

    --------------------------- Memory Stage----------------------------------------
    EX_MEM : executeMemory PORT MAP(
        clk,
        s_flushEnable_EX_MEM,
        s_readData1_ID_EX,
        s_wbAddress_ID_EX,
        s_PC_plus_one_ID_EX,
        s_inputPort_DS,
        s_immediate_ID_EX,
        s_cuSignals_ID_EX,
        s_aluResult,
        s_cuSignals_EX_MEM,
        s_readData1_EX_MEM,
        s_wbAddress_EX_MEM,
        s_immediate_EX_MEM,
        s_PC_plus_one_EX_MEM,
        s_inputPort_EX_MEM,
        s_aluResult_EX_MEM,
        s_branch_EX_MEM,
        s_jumpTypeSelector_EX_MEM,
        s_memRead_EX_MEM,
        s_memWrite_EX_MEM
    );

    mux_alu_inputPort : mux2x1 PORT MAP(s_aluResult_EX_MEM, s_inputPort_EX_MEM, s_cuSignals_EX_MEM(7), s_mux_alu_inputPort);
    ---------------------------Write Back Stage----------------------------------------
    MEM_WB : memoryWriteBack PORT MAP(
        clk,
        s_flushEnable_WB,
        s_mux_alu_inputPort,
        s_dataMemory,
        s_wbAddress_EX_MEM,
        s_cuSignals_EX_MEM,
        s_wbSelector_WB,
        s_regWrite_WB,
        s_writeAddressFU_WB,
        s_memoryData_WB,
        s_aluInputPortData_WB
    );

    WB_MUX : mux2x1 GENERIC MAP(
        32)PORT MAP(
        s_memoryData_WB,
        s_aluInputPortData_WB,
        s_wbSelector_WB,
        s_writeData_WB
    );
END a_processor; -- a_processor