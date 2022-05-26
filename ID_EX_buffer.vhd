LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity decodeExecute is
	port(
	clk : in std_logic;
	--input ports
	i_flushEnable : in std_logic_vector(1 downto 0);
	i_readData1,i_readData2 : in std_logic_vector(31 downto 0);
	i_wbAddress : in std_logic_vector(2 downto 0);
	i_PC_plus_one : in std_logic_vector(31 downto 0);
	i_inputPort : in std_logic_vector(31 downto 0);
	i_immediate : in std_logic_vector(31 downto 0);
	i_cuSignals : in std_logic_vector(22 downto 0); 
-- controlUnitSignals <= s_regWrite '1' & s_regSrc '1' & s_aluSrc '1' & s_aluOp '5' & s_ccrEnable '1' & s_setC '1' & s_memWrite '1' & s_memRead '1' & s_branch '1' & s_spEnable '1' & s_popOrPush '1' & s_aluInputPort'1' & s_wbSelector '1' & s_hlt '1' & s_jumpTypeSelector '2' & s_AluOrStack '1' & s_StoreEnable '1' & s_outEnable '1';
	-- output ports
	o_readData1,o_readData2 : out std_logic_vector(31 downto 0);
	o_aluOP : out std_logic_vector(4 downto 0);
	o_aluSrc : out std_logic;
	o_cuSignals : out std_logic_vector(22 downto 0); --23 cu signals - 5 opcode - 1 alusrc = 17 cu signals left to be passed over 
	o_wbAddress : out std_logic_vector(2 downto 0);
	o_immediate : out std_logic_vector(31 downto 0);
	o_inputPort : out std_logic_vector(31 downto 0);
	o_PC_plus_one : out std_logic_vector(31 downto 0)
);
end decodeExecute;



Architecture a_decodeExecBuffer OF decodeExecute IS
BEGIN
	process (clk,i_flushEnable)
	begin
        IF i_flushEnable(1) ='1' and rising_edge(clk) THEN 
        o_cuSignals <= (others => '0');
	o_readData1 <= (others => '0');
	o_readData2 <= (others => '0');
	o_aluOP <= (others=>'0');
	o_aluSrc <=  '0';
	o_wbAddress <= (others=>'0');
	o_immediate <= (others=>'0');
	o_PC_plus_one <= (others=>'0');
        ELSIF (rising_edge(clk) ) THEN
        o_readData1             <= i_readData1     ;   
        o_wbAddress <= i_wbAddress  ;
        o_PC_plus_one        <= i_PC_plus_one     ;
        o_aluOP <= i_cuSignals(19 downto 15);
	o_aluSrc <= i_cuSignals(20);
        o_cuSignals       <= i_cuSignals;
        o_immediate       <= i_immediate   ;
        o_readData2 <= i_readData2   ;
	o_inputPort <= i_inputPort;
	END IF;
	end process;
end a_decodeExecBuffer;


