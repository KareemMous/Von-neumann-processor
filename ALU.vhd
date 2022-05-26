LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY ALU IS
    PORT (
        operandOne : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        operandTwo : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        AluOp : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        flags : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        reset : IN STD_LOGIC
    );
END ALU;

ARCHITECTURE arch OF ALU IS

    SIGNAL notOperandOne : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL incrementedoperandOne : STD_LOGIC_VECTOR (32 DOWNTO 0);
    SIGNAL movedOperandOne : STD_LOGIC_VECTOR (31 DOWNTO 0);

    SIGNAL AdderResult : STD_LOGIC_VECTOR(32 DOWNTO 0);
    SIGNAL CoutAdder : STD_LOGIC;
    SIGNAL subtraction : STD_LOGIC_VECTOR (32 DOWNTO 0);
    SIGNAL OperandOneAndOperandTwo : STD_LOGIC_VECTOR (32 DOWNTO 0);

    SIGNAL Result_internal : STD_LOGIC_VECTOR (31 DOWNTO 0);
    SIGNAL zf : STD_LOGIC;
    SIGNAL nf : STD_LOGIC;
    SIGNAL cf : STD_LOGIC;
    SIGNAL flagEnable : STD_LOGIC;
    SIGNAL incrementCF : STD_LOGIC;
    SIGNAL deccrementCF : STD_LOGIC;
    SIGNAL tempoperandOne : STD_LOGIC_VECTOR (32 DOWNTO 0);
    SIGNAL tempoperandTwo : STD_LOGIC_VECTOR (32 DOWNTO 0);

BEGIN
    --Adder: adder_32bit port map(operandOne,operandTwo,CarryIn,AdderResult,CoutAdder);

    tempoperandOne <= '0' & operandOne;
    tempoperandTwo <= '0' & operandTwo;

    notOperandOne <= NOT operandOne;
    incrementedoperandOne <= STD_LOGIC_VECTOR(signed(tempoperandTwo(32 DOWNTO 0)) + 1);
    subtraction <= STD_LOGIC_VECTOR(signed(tempoperandOne(32 DOWNTO 0)) - signed(tempoperandTwo(32 DOWNTO 0)));
    AdderResult <= STD_LOGIC_VECTOR(signed(tempoperandOne(32 DOWNTO 0)) + signed(tempoperandTwo(32 DOWNTO 0)));
    ----------------0010-- shift Right 0000 |10 -> 1
    Result_internal <=
        --NOT
        (notOperandOne) WHEN AluOp = "00011"
        ELSE
        --INC
        (incrementedoperandOne(31 DOWNTO 0)) WHEN AluOp = "00100"
        ELSE
        --MOV
        (operandOne) WHEN AluOp = "01000"
        ELSE
        --AND
        (operandOne AND operandTwo) WHEN AluOp = "01100"
        ELSE
        --ADD and IADD
        (AdderResult(31 DOWNTO 0)) WHEN AluOp = "01010" OR AluOp = "01101"
        ELSE
        --SUB
        (subtraction(31 DOWNTO 0)) WHEN AluOp = "01011";
    --Negative flag
    nf <= ('1') WHEN (signed(Result_internal) < 0 AND (AluOp /= "01000" AND AluOp /= "00000"AND AluOp /= "10011" AND AluOp /= "10100"))
        ELSE
        (nf) WHEN (AluOp = "01000" OR AluOp = "00000"OR AluOp /= "10011" OR AluOp /= "10100")
        ELSE
        ('0') WHEN (reset = '1')
        ELSE
        ('0');

    zf <= ('1') WHEN (signed(Result_internal) = 0 AND (AluOp /= "01000" AND AluOp /= "00000" AND AluOp /= "10011" AND AluOp /= "10100"))
        ELSE
        (zf) WHEN (AluOp = "01000" OR AluOp = "00000" OR AluOp /= "10011" AND AluOp /= "10100")
        ELSE
        ('0') WHEN (reset = '1')
        ELSE
        ('0');
    cf <=
        (AdderResult(32)) WHEN AluOp = "01010" OR AluOp = "01101" --0001
        ELSE
        --subtraction
        ('1') WHEN((AluOp = "01011") AND ((signed(tempoperandOne(31 DOWNTO 0))) > (signed(tempoperandTwo(31 DOWNTO 0)))))
        ELSE
        ('0') WHEN((AluOp = "01011") AND ((signed(tempoperandOne(31 DOWNTO 0))) < (signed(tempoperandTwo(31 DOWNTO 0)))))
        ELSE
        --increment
        (incrementedoperandOne(32)) WHEN AluOp = "00100"
        ELSE
        ('0') WHEN (reset = '1')
        ELSE
        -- mov nop 
        (cf) WHEN (AluOp = "01000" OR AluOp = "00000" OR AluOp = "10011" OR AluOp = "10100");

    flagEnable <= ('0') WHEN (AluOp = "01000" OR AluOp = "00000" OR AluOp = "10011" OR AluOp = "10100")
        ELSE
        ('1');

    result <= Result_internal(31 DOWNTO 0);
    flags <= (flagEnable, nf, zf, cf);
END ARCHITECTURE; -- arch