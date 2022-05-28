
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY stackpointer IS
    --GENERIC (n : INTEGER := 32);
    PORT (
        clk, rst : IN STD_LOGIC;
        i_spEnable : IN STD_LOGIC;
        i_popPush : IN STD_LOGIC;

        o_sp : OUT STD_LOGIC_VECTOR(19 DOWNTO 0)
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
            q : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
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
            outputSel : OUT INTEGER
        );
    END COMPONENT;

    ----Signals

    --Old sp signal from sp register
    SIGNAL s_oldSp : STD_LOGIC_VECTOR(19 DOWNTO 0);
    --Increment/decrement mux output to adder
    SIGNAL s_incDec : INTEGER;
    --New sp signal from adder
    SIGNAL s_newSp : STD_LOGIC_VECTOR(19 DOWNTO 0);

    --
BEGIN
    --SP register wiring
    m_spRegister : spregister GENERIC MAP(20) PORT MAP(s_newSp, clk, rst, i_spEnable, s_oldSp);

    --Increment/decrement mux wiring
    m_mux2x1INt : mux2x1int PORT MAP(1, -1, i_popPush, s_incDec);

    --Adder
   s_newSp <= std_logic_vector(to_signed(to_integer(signed(s_oldSp))+s_incDec, s_newSp'length));

    --mux
    m_mux2x1 : mux2x1 Generic Map(20) PORT MAP(s_newSp, s_oldSp, i_popPush, o_sp);

END a_stackpointer;