vsim -gui work.processor
add wave -position insertpoint sim:/processor/*
add wave -position insertpoint sim:/processor/stack_pointer/*
force -freeze sim:/processor/CLK 1 0, 0 {50 ps} -r 100
mem load -filltype value -filldata 16#00000010 -fillradix hexadecimal /processor/mem/ram(0)
mem load -filltype value -filldata 16#00000900 -fillradix hexadecimal /processor/mem/ram(1)
mem load -filltype value -filldata 16#00000200 -fillradix hexadecimal /processor/mem/ram(2)
mem load -filltype value -filldata 16#00000250 -fillradix hexadecimal /processor/mem/ram(3)
mem load -filltype value -filldata 16#10000000 -fillradix hexadecimal /processor/mem/ram(2304)
mem load -filltype value -filldata 16#60000000 -fillradix hexadecimal /processor/mem/ram(2305)
mem load -filltype value -filldata 16#2B600000 -fillradix hexadecimal /processor/mem/ram(2306)
mem load -filltype value -filldata 16#F8000000 -fillradix hexadecimal /processor/mem/ram(2307)
mem load -filltype value -filldata 16#60000000 -fillradix hexadecimal /processor/mem/ram(512)
mem load -filltype value -filldata 16#2EC00000 -fillradix hexadecimal /processor/mem/ram(513)
mem load -filltype value -filldata 16#F8000000 -fillradix hexadecimal /processor/mem/ram(514)
mem load -filltype value -filldata 16#10000000 -fillradix hexadecimal /processor/mem/ram(592)
mem load -filltype value -filldata 16#60000000 -fillradix hexadecimal /processor/mem/ram(593)
mem load -filltype value -filldata 16#2A400000 -fillradix hexadecimal /processor/mem/ram(594)
mem load -filltype value -filldata 16#F8000000 -fillradix hexadecimal /processor/mem/ram(595)
mem load -filltype value -filldata 16#31200000 -fillradix hexadecimal /processor/mem/ram(16)
mem load -filltype value -filldata 16#32400000 -fillradix hexadecimal /processor/mem/ram(17)
mem load -filltype value -filldata 16#33600000 -fillradix hexadecimal /processor/mem/ram(18)
mem load -filltype value -filldata 16#34800000 -fillradix hexadecimal /processor/mem/ram(19)
mem load -filltype value -filldata 16#84000000 -fillradix hexadecimal /processor/mem/ram(20)
mem load -filltype value -filldata 16#F0000001 -fillradix hexadecimal /processor/mem/ram(21)
mem load -filltype value -filldata 16#D8000030 -fillradix hexadecimal /processor/mem/ram(22)
mem load -filltype value -filldata 16#21200000 -fillradix hexadecimal /processor/mem/ram(23)
mem load -filltype value -filldata 16#65340000 -fillradix hexadecimal /processor/mem/ram(48)
mem load -filltype value -filldata 16#C0000050 -fillradix hexadecimal /processor/mem/ram(49)
mem load -filltype value -filldata 16#10000000 -fillradix hexadecimal /processor/mem/ram(50)
mem load -filltype value -filldata 16#C0000030 -fillradix hexadecimal /processor/mem/ram(80)
mem load -filltype value -filldata 16#D0000100 -fillradix hexadecimal /processor/mem/ram(81)
mem load -filltype value -filldata 16#1DA00000 -fillradix hexadecimal /processor/mem/ram(82)
mem load -filltype value -filldata 16#F0000000 -fillradix hexadecimal /processor/mem/ram(83)
mem load -filltype value -filldata 16#36C00000 -fillradix hexadecimal /processor/mem/ram(84)
mem load -filltype value -filldata 16#C8000700 -fillradix hexadecimal /processor/mem/ram(85)
mem load -filltype value -filldata 16#21200000 -fillradix hexadecimal /processor/mem/ram(86)
mem load -filltype value -filldata 16#10000000 -fillradix hexadecimal /processor/mem/ram(1792)
mem load -filltype value -filldata 16#8E000000 -fillradix hexadecimal /processor/mem/ram(1793)
mem load -filltype value -filldata 16#E0000300 -fillradix hexadecimal /processor/mem/ram(1794)
mem load -filltype value -filldata 16#26C00000 -fillradix hexadecimal /processor/mem/ram(1795)
mem load -filltype value -filldata 16#00000000 -fillradix hexadecimal /processor/mem/ram(1796)
mem load -filltype value -filldata 16#00000000 -fillradix hexadecimal /processor/mem/ram(1797)
mem load -filltype value -filldata 16#56780000 -fillradix hexadecimal /processor/mem/ram(768)
mem load -filltype value -filldata 16#51280000 -fillradix hexadecimal /processor/mem/ram(769)
mem load -filltype value -filldata 16#E8000000 -fillradix hexadecimal /processor/mem/ram(770)
mem load -filltype value -filldata 16#10000000 -fillradix hexadecimal /processor/mem/ram(771)
mem load -filltype value -filldata 16#00000000 -fillradix hexadecimal /processor/mem/ram(1280)
mem load -filltype value -filldata 16#00000000 -fillradix hexadecimal /processor/mem/ram(1281)
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
force -freeze sim:/processor/i_inputPort 16#00000030 0
run
force -freeze sim:/processor/i_inputPort 16#00000050 0
run
force -freeze sim:/processor/i_inputPort 16#00000100 0
run
force -freeze sim:/processor/i_inputPort 16#00000300 0
run

