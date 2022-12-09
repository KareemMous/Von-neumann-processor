vsim -gui work.controlunit
# vsim -gui work.controlunit 
# Start time: 02:54:24 on May 26,2022
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.controlunit(a_controlunit)
add wave -position insertpoint  \
sim:/controlunit/instructionInput \
sim:/controlunit/registerSource \
sim:/controlunit/controlUnitSignals \
sim:/controlunit/s_regWrite \
sim:/controlunit/s_regSrc \
sim:/controlunit/s_aluSrc \
sim:/controlunit/s_aluOp \
sim:/controlunit/s_ccrEnable \
sim:/controlunit/s_setC \
sim:/controlunit/s_memWrite \
sim:/controlunit/s_memRead \
sim:/controlunit/s_branch \
sim:/controlunit/s_spEnable \
sim:/controlunit/s_popOrPush \
sim:/controlunit/s_aluInputPort \
sim:/controlunit/s_wbSelector \
sim:/controlunit/s_hlt \
sim:/controlunit/s_jumpTypeSelector \
sim:/controlunit/s_AluOrStack \
sim:/controlunit/s_StoreEnable \
sim:/controlunit/s_outEnable
force -freeze sim:/controlunit/instructionInput 00011 0
run
run
force -freeze sim:/controlunit/instructionInput 01010 0
run
force -freeze sim:/controlunit/instructionInput 10000 0
run
force -freeze sim:/controlunit/instructionInput 10100 0
run