vsim -gui work.processor
add wave -position insertpoint sim:/processor/*
force -freeze sim:/processor/clk 1 0, 0 {50 ps} -r 100
mem load -filltype value -filldata 16#000000FF -fillradix hexadecimal /processor/mem/ram(0)
mem load -filltype value -filldata 16#00000100 -fillradix hexadecimal /processor/mem/ram(1)
mem load -filltype value -filldata 16#00000200 -fillradix hexadecimal /processor/mem/ram(2)
mem load -filltype value -filldata 16#00000250 -fillradix hexadecimal /processor/mem/ram(3)
mem load -filltype value -filldata 16#31200000 -fillradix hexadecimal /processor/mem/ram(255)
mem load -filltype value -filldata 16#32400000 -fillradix hexadecimal /processor/mem/ram(256)
mem load -filltype value -filldata 16#33600000 -fillradix hexadecimal /processor/mem/ram(257)
mem load -filltype value -filldata 16#34800000 -fillradix hexadecimal /processor/mem/ram(258)
mem load -filltype value -filldata 16#45600000 -fillradix hexadecimal /processor/mem/ram(259)
mem load -filltype value -filldata 16#54300000 -fillradix hexadecimal /processor/mem/ram(260)
mem load -filltype value -filldata 16#5EB00000 -fillradix hexadecimal /processor/mem/ram(261)
mem load -filltype value -filldata 16#64F00000 -fillradix hexadecimal /processor/mem/ram(262)
mem load -filltype value -filldata 16#6A40FFFF -fillradix hexadecimal /processor/mem/ram(263)
mem load -filltype value -filldata 16#52280000 -fillradix hexadecimal /processor/mem/ram(264)
mem load -filltype value -filldata 16#56880000 -fillradix hexadecimal /processor/mem/ram(265)
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
force -freeze sim:/processor/i_inputPort 16#00000005 0
run
force -freeze sim:/processor/i_inputPort 16#00000019 0
run
force -freeze sim:/processor/i_inputPort 16#FFFFFFFF 0
run
force -freeze sim:/processor/i_inputPort 16#FFFFF320 0
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
