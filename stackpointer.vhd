
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY stackpointer IS
    --GENERIC (n : INTEGER := 32);
    PORT (
        clk, rst : IN STD_LOGIC;
        i_spEnable : IN STD_LOGIC := '0';--9
        i_popPush : IN STD_LOGIC := '0';--8

        o_sp : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END stackpointer;
ARCHITECTURE a_stackpointer OF stackpointer IS

    ----Components

    --SP address register
    COMPONENT spregister IS
        GENERIC (n : INTEGER := 32);
        PORT (
            d : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            enable, clk, rst : IN STD_LOGIC;
            q : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            inc : OUT INTEGER;
            DEC : OUT INTEGER
        );
    END COMPONENT;

    --multiplexer
    COMPONENT mux2x1 IS
        GENERIC (n : INTEGER := 16);
        PORT (
            input0, input1 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            sel : IN STD_LOGIC;
            outputSel : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT mux2x1int IS
        PORT (
            input0, input1 : IN INTEGER;
            sel : IN STD_LOGIC;
            outputSel : OUT INTEGER;
            spEnable : IN STD_LOGIC
        );
    END COMPONENT;

    COMPONENT adder IS
        GENERIC (n : INTEGER := 32);
        PORT (
            D : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            val : INTEGER;
            Q : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
        );
    END COMPONENT;

    ----Signals

    --Old sp signal from sp register
    SIGNAL s_oldSp : STD_LOGIC_VECTOR(31 DOWNTO 0);
    --Increment/decrement mux output to adder
    SIGNAL s_incDec : INTEGER;
    --New sp signal from adder
    SIGNAL s_newSp : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"000FFFFF";

    SIGNAL s_o_sp : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL o_sp_mux : STD_LOGIC_VECTOR(31 DOWNTO 0);

    --inc and dec signals
    SIGNAL s_inc : INTEGER;
    SIGNAL s_dec : INTEGER;
    --
BEGIN

    --o_sp <= s_oldSp;
    --SP register wiring
    m_spRegister : spregister GENERIC MAP(32) PORT MAP(s_newSp, i_spEnable, clk, '0', s_oldSp, s_inc, s_dec);

    --s_incDec <= 1 WHEN i_popPush = '1' AND i_spEnable = '1' ELSE
    --  - 1 WHEN i_popPush = '0'AND i_spEnable = '1' ELSE
    --0;

    --Increment/decrement mux wiring
    m_mux2x1INt : mux2x1int PORT MAP(s_dec, s_inc, i_popPush, s_incDec, i_spEnable);

    --Adder
    --s_newSp <= STD_LOGIC_VECTOR(to_signed(to_integer(signed(s_oldSp)) + s_incDec, 32));
    inc_dec_adder : adder GENERIC MAP(32) PORT MAP(s_oldSp, s_incDec, s_newSp);
    --mux
    m_mux2x1 : mux2x1 GENERIC MAP(32) PORT MAP(s_newSp, s_oldSp, i_popPush, o_sp);

    --m_regMux2x1 : mux2x1 GENERIC MAP(32) PORT MAP(s_oldSp, s_newSp, i_spEnable, s_o_sp);
END a_stackpointer;