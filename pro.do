vsim -gui work.processor
# vsim -gui work.processor 
# Start time: 19:44:15 on May 27,2022
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.processor(a_processor)
# Loading work.mux2x1(a_mux2x1)
# Loading work.memory(a_memory)
# Loading work.fetchdecode(a_fetchdecode)
# Loading work.signextend(a_signextend)
# Loading work.controlunit(a_controlunit)
# Loading work.registerfile(a_registerfile)
# Loading work.e_3x8decoder(a_3x8decoder)
# Loading work.my_generic_register(arch_register)
# Loading work.tristate(a_tristate)
# Loading work.decodeexecute(a_decodeexecbuffer)
# Loading work.my_storehandler(a_storehandler)
# Loading work.alu(arch)
add wave -position insertpoint sim:/processor/*
add wave -position insertpoint  \
sim:/processor/regfile/Register0/d\
sim:/processor/regfile/Register1/d\
sim:/processor/regfile/Register0/q\
sim:/processor/regfile/Register1/q
force -freeze sim:/processor/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/processor/rst 1 0
force -freeze sim:/processor/i_PC 16#00000000 0
mem load -filltype value -filldata 10010000000000000000000000000001 -fillradix symbolic /processor/mem/ram(0)
mem load -filltype value -filldata 11111111111111111111111111111110 -fillradix symbolic /processor/mem/ram(1)
mem load -filltype value -filldata {00100000000000000000000000000000 } -fillradix symbolic /processor/mem/ram(2)
run
force -freeze sim:/processor/rst 0 0

run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
force -freeze sim:/processor/i_PC 00000000000000000000000000000010 0
run
run
run
run
run
run
mem load -filltype value -filldata 10100000000001000000000000000110 -fillradix symbolic /processor/mem/ram(4)
force -freeze sim:/processor/i_PC 16#00000004 0