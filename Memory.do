vsim -gui work.processor
add wave -position insertpoint  \
sim:/processor/CLK
add wave -position insertpoint sim:/processor/*
add wave -position insertpoint sim:/processor/stack_pointer/*
force -freeze sim:/processor/CLK 1 0, 0 {50 ps} -r 100
mem load -filltype value -filldata 16#00000300 -fillradix hexadecimal /processor/mem/ram(0)
mem load -filltype value -filldata 16#00000700 -fillradix hexadecimal /processor/mem/ram(1)
mem load -filltype value -filldata 16#00000200 -fillradix hexadecimal /processor/mem/ram(2)
mem load -filltype value -filldata 16#00000250 -fillradix hexadecimal /processor/mem/ram(3)
mem load -filltype value -filldata 16#00000100 -fillradix hexadecimal /processor/mem/ram(4)
mem load -filltype value -filldata 16#29200000 -fillradix hexadecimal /processor/mem/ram(256)
mem load -filltype value -filldata 16#08000000 -fillradix hexadecimal /processor/mem/ram(257)
mem load -filltype value -filldata 16#32400000 -fillradix hexadecimal /processor/mem/ram(768)
mem load -filltype value -filldata 16#33600000 -fillradix hexadecimal /processor/mem/ram(769)
mem load -filltype value -filldata 16#34800000 -fillradix hexadecimal /processor/mem/ram(770)
mem load -filltype value -filldata 16#91000005 -fillradix hexadecimal /processor/mem/ram(771)
mem load -filltype value -filldata 16#81000000 -fillradix hexadecimal /processor/mem/ram(772)
mem load -filltype value -filldata 16#82000000 -fillradix hexadecimal /processor/mem/ram(773)
mem load -filltype value -filldata 16#89000000 -fillradix hexadecimal /processor/mem/ram(774)
mem load -filltype value -filldata 16#8A000000 -fillradix hexadecimal /processor/mem/ram(775)
mem load -filltype value -filldata 16#35A00000 -fillradix hexadecimal /processor/mem/ram(776)
mem load -filltype value -filldata 16#A2A00200 -fillradix hexadecimal /processor/mem/ram(777)
mem load -filltype value -filldata 16#A1A00201 -fillradix hexadecimal /processor/mem/ram(778)
mem load -filltype value -filldata 16#9BA00201 -fillradix hexadecimal /processor/mem/ram(779)
mem load -filltype value -filldata 16#9CA00200 -fillradix hexadecimal /processor/mem/ram(780)
mem load -filltype value -filldata 16#8B000000 -fillradix hexadecimal /processor/mem/ram(781)
mem load -filltype value -filldata 16#514C0000 -fillradix hexadecimal /processor/mem/ram(782)
mem load -filltype value -filldata 16#8E000000 -fillradix hexadecimal /processor/mem/ram(783)
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
#force -freeze sim:/processor/pc/D 16#00000300 0

#noforce sim:/processor/pc/D
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
force -freeze sim:/processor/i_inputPort 16#00000010 0
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
force -freeze sim:/processor/regfile/Register6/q 00000019 0

run

