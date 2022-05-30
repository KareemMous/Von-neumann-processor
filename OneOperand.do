vsim -gui work.processor
add wave -position insertpoint sim:/processor/*
add wave -position insertpoint sim:/processor/stack_pointer/*
force -freeze sim:/processor/CLK 1 0, 0 {50 ps} -r 100
mem load -filltype value -filldata 16#000000A0 -fillradix hexadecimal /processor/mem/ram(0)
mem load -filltype value -filldata 16#00000100 -fillradix hexadecimal /processor/mem/ram(1)
mem load -filltype value -filldata 16#00000200 -fillradix hexadecimal /processor/mem/ram(2)
mem load -filltype value -filldata 16#00000250 -fillradix hexadecimal /processor/mem/ram(3)
mem load -filltype value -filldata 16#10000000 -fillradix hexadecimal /processor/mem/ram(160)
mem load -filltype value -filldata 16#00000000 -fillradix hexadecimal /processor/mem/ram(161)
mem load -filltype value -filldata 16#19200000 -fillradix hexadecimal /processor/mem/ram(162)
mem load -filltype value -filldata 16#21200000 -fillradix hexadecimal /processor/mem/ram(163)
mem load -filltype value -filldata 16#31200000 -fillradix hexadecimal /processor/mem/ram(164)
mem load -filltype value -filldata 16#32400000 -fillradix hexadecimal /processor/mem/ram(165)
mem load -filltype value -filldata 16#1A400000 -fillradix hexadecimal /processor/mem/ram(166)
mem load -filltype value -filldata 16#21200000 -fillradix hexadecimal /processor/mem/ram(167)
mem load -filltype value -filldata 16#29200000 -fillradix hexadecimal /processor/mem/ram(168)
mem load -filltype value -filldata 16#2A400000 -fillradix hexadecimal /processor/mem/ram(169)
mem load -filltype value -filldata 16#08000000 -fillradix hexadecimal /processor/mem/ram(170)
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
force -freeze sim:/processor/rst 1 0
run
force -freeze sim:/processor/rst 0 0
run
run
run
run
force -freeze sim:/processor/i_inputPort 16#00000005 0
run
force -freeze sim:/processor/i_inputPort 16#00000010 0
run
run
run
run
run
run
run
run



