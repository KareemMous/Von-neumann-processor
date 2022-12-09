LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
ENTITY decodestage IS
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;

        --Instruction input
        instruction : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

        --Register write signal
        regWrite : IN STD_LOGIC;

        --write
        writeData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

        --Input port input
        inputPortDataIn : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

        --Pc+1 input
        pcPlusOneIn : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        --Read register 1 and 2 addresses output for the Hazard Detection Unit
        readRegister1Hazard : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        readRegister2Hazard : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);

        --control unit signals
        controlUnitSignals : OUT STD_LOGIC_VECTOR(22 DOWNTO 0);--To be edited

        -- Read data outputs of the registers
        readData1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        readData2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);

        --Write/Back address
        writeBackAddress : OUT STD_LOGIC;--Not sure

        --input port output to ID/EX stage
        inputPortDataOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);

        --pc+1 output t ID/EX
        pcPlusOneOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);

        --Immediate value output
        immValueSignExt : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ENTITY decodestage;

ARCHITECTURE a_decodestage OF decodestage IS
    ----Components

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
    --RegSrc multiplexer
    COMPONENT mux2x1 IS
        GENERIC (n : INTEGER := 16);
        PORT (
            input0, input1 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            sel : IN STD_LOGIC;
            outputSel : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
        );
    END COMPONENT;
    --Immediate value sign extend
    COMPONENT signextend IS
        PORT (
            input : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            output : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;
    --Register file
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
    ----Signals form IF/ID buffer

    --pc+1 
    SIGNAL pcPlusOneFD : STD_LOGIC_VECTOR(31 DOWNTO 0);

    --input port data
    SIGNAL inputPortFD : STD_LOGIC_VECTOR(31 DOWNTO 0);

    --input instruction
    SIGNAL instructionFD : STD_LOGIC_VECTOR(23 DOWNTO 0);
    --Register source signal from control unit to mux
    SIGNAL regSrcCu : STD_LOGIC;

    --Read register 1 from mux 
    SIGNAL readRegister1Mux : STD_LOGIC_VECTOR(2 DOWNTO 0);

BEGIN

    --Control unit wiring
    controlUnitMap : controlunit
    PORT MAP(instruction(31 DOWNTO 27), regSrcCu, controlUnitSignals);
    --RegisterFile wiring

    registerFileMap : registerfile
    PORT MAP(clk, rst, regWrite, readRegister1Mux, instruction(20 DOWNTO 18), instruction(26 DOWNTO 24), writeData, readData1, readData2);
    --Reg src mux
    regSrcMux : mux2x1 GENERIC MAP(3)
    PORT MAP(instruction(26 DOWNTO 24), instruction(23 DOWNTO 21), regSrcCu, readRegister1Mux);
    --sign extend

    signExtendMap : signextend
    PORT MAP(instruction(15 DOWNTO 0), immValueSignExt);
END a_decodestage;