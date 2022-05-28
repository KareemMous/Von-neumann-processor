vsim -gui work.processor
add wave -position insertpoint sim:/processor/*
mem load -filltype value -filldata {00000000000000001010101010101010 } -fillradix symbolic /processor/mem/ram(16)
mem load -filltype value -filldata 10011000000000000000000000010000 -fillradix symbolic /processor/mem/ram(0)
mem load -filltype value -filldata 00011000000000000000000000000000 -fillradix symbolic /processor/mem/ram(1)
mem load -filltype value -filldata 10100000000001000000000000001010 -fillradix symbolic /processor/mem/ram(2)
mem load -filltype value -filldata 01101011001000000000000000111111 -fillradix symbolic /processor/mem/ram(3)
mem load -filltype value -filldata 01100001000011000000000000000000 -fillradix symbolic /processor/mem/ram(4)
add wave -position insertpoint sim:/processor/regfile/Register0/q
add wave -position insertpoint sim:/processor/regfile/Register1/q
add wave -position insertpoint sim:/processor/regfile/Register2/q
add wave -position insertpoint sim:/processor/regfile/Register3/q
add wave -position insertpoint sim:/processor/regfile/Register4/q
add wave -position insertpoint sim:/processor/regfile/Register5/q
force -freeze sim:/processor/i_PC 16#00000000 0
force -freeze sim:/processor/rst 1 0
force -freeze sim:/processor/clk 1 0, 0 {50 ps} -r 100
run
force -freeze sim:/processor/rst 0 0
run
run
run
run
run
run
force -freeze sim:/processor/i_PC 16#00000001 0
run
run
run
run
run
run
force -freeze sim:/processor/i_PC 16#00000002 0
run
run
run
run
run
run
force -freeze sim:/processor/i_PC 16#00000003 0
run
run
run
run
run
run
force -freeze sim:/processor/i_PC 16#00000004 0
run
run
run
run
run
run

