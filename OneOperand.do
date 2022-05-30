vsim -gui work.processor
add wave -position insertpoint sim:/processor/*
add wave -position insertpoint sim:/processor/stack_pointer/*
force -freeze sim:/processor/CLK 1 0, 0 {50 ps} -r 100



mem load -filltype value -filldata 16#31200000 -fillradix hexadecimal /processor/mem/ram(0)
mem load -filltype value -filldata 16#32400000 -fillradix hexadecimal /processor/mem/ram(1)
mem load -filltype value -filldata 16#33600000 -fillradix hexadecimal /processor/mem/ram(2)
mem load -filltype value -filldata 10010000000000000000000001111111 -fillradix symbolic /processor/mem/ram(3)
mem load -filltype value -filldata 01101011000000000000000011111111 -fillradix symbolic /processor/mem/ram(4)
mem load -filltype value -filldata 10100011000000000000000000000000 -fillradix symbolic /processor/mem/ram(5)
mem load -filltype value -filldata 10011110000000000000000000000000 -fillradix symbolic /processor/mem/ram(6)

add wave -position insertpoint sim:/processor/c_alu/operandOne
add wave -position insertpoint sim:/processor/c_alu/operandTwo
add wave -position insertpoint sim:/processor/regfile/Register0/q
add wave -position insertpoint sim:/processor/regfile/Register1/q
add wave -position insertpoint sim:/processor/regfile/Register2/q
add wave -position insertpoint sim:/processor/regfile/Register3/q
add wave -position insertpoint sim:/processor/regfile/Register4/q
add wave -position insertpoint sim:/processor/regfile/Register5/q
add wave -position insertpoint sim:/processor/regfile/Register6/q
add wave -position insertpoint sim:/processor/regfile/Register7/q
force -freeze sim:/processor/i_inputPort 16#00000005 0
force -freeze sim:/processor/rst 0 0

run
force -freeze sim:/processor/i_inputPort 16#00000010 0
run
force -freeze sim:/processor/i_inputPort 16#00000015 0
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



