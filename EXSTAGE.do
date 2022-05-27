vsim -gui work.ex_stage
# vsim -gui work.ex_stage 
# Start time: 01:49:48 on May 27,2022
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.ex_stage(a_exstage)
# Loading work.decodeexecute(a_decodeexecbuffer)
# Loading ieee.numeric_std(body)
# Loading work.my_storehandler(a_storehandler)
# Loading work.mux2x1(a_mux2x1)
# Loading work.alu(arch)
add wave -position insertpoint  \
sim:/ex_stage/clk \
sim:/ex_stage/rst \
sim:/ex_stage/i_flushEnable \
sim:/ex_stage/i_readData1 \
sim:/ex_stage/i_readData2 \
sim:/ex_stage/i_wbAddress \
sim:/ex_stage/i_PC_plus_one \
sim:/ex_stage/i_inputPort \
sim:/ex_stage/i_immediate \
sim:/ex_stage/i_cuSignals \
sim:/ex_stage/o_aluResult \
sim:/ex_stage/o_flagValues \
sim:/ex_stage/o_Imm \
sim:/ex_stage/o_Datafromsrc1 \
sim:/ex_stage/o_wbAddress \
sim:/ex_stage/o_inputPort \
sim:/ex_stage/s_readData1 \
sim:/ex_stage/s_readData2 \
sim:/ex_stage/s_aluOP \
sim:/ex_stage/s_aluSrc \
sim:/ex_stage/s_cuSignals \
sim:/ex_stage/s_wbAddress \
sim:/ex_stage/s_immediate \
sim:/ex_stage/s_inputPort \
sim:/ex_stage/s_PC_plus_one \
sim:/ex_stage/s_mux1_readData2OrImm \
sim:/ex_stage/s_mux2_mux1OrStoreHandler \
sim:/ex_stage/s_storeHandler \
sim:/ex_stage/s_aluResult \
sim:/ex_stage/s_flags
force -freeze sim:/ex_stage/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/ex_stage/rst 0 0
force -freeze sim:/ex_stage/i_flushEnable 00 0
force -freeze sim:/ex_stage/i_readData1 16#FFFFFFF0 0
force -freeze sim:/ex_stage/i_readData2 16#0000000F 0
force -freeze sim:/ex_stage/i_wbAddress 010 0
force -freeze sim:/ex_stage/i_PC_plus_one 16#FFFFFFF0 0
force -freeze sim:/ex_stage/i_inputPort 11111111111111111111111111110000 0
force -freeze sim:/ex_stage/i_immediate 11111111111111111011111111110000 0
force -freeze sim:/ex_stage/i_cuSignals 11001010100000001011000 0
run
# ** Warning: NUMERIC_STD."=": metavalue detected, returning FALSE
#    Time: 0 ps  Iteration: 0  Instance: /ex_stage/c_alu
# ** Warning: NUMERIC_STD."<": metavalue detected, returning FALSE
#    Time: 0 ps  Iteration: 0  Instance: /ex_stage/c_alu
# ** Warning: NUMERIC_STD."=": metavalue detected, returning FALSE
#    Time: 0 ps  Iteration: 1  Instance: /ex_stage/c_alu
# ** Warning: NUMERIC_STD."<": metavalue detected, returning FALSE
#    Time: 0 ps  Iteration: 1  Instance: /ex_stage/c_alu
# ** Warning: NUMERIC_STD."<": metavalue detected, returning FALSE
#    Time: 0 ps  Iteration: 2  Instance: /ex_stage/c_alu
# ** Warning: NUMERIC_STD."=": metavalue detected, returning FALSE
#    Time: 0 ps  Iteration: 2  Instance: /ex_stage/c_alu
run
force -freeze sim:/ex_stage/i_cuSignals 11000100100000001011000 0
run
run
force -freeze sim:/ex_stage/i_cuSignals 11001011100000001011000 0
run
force -freeze sim:/ex_stage/i_cuSignals 11000011100000001011000 0
run