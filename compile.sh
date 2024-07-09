#!/bin/bash

ghdl -a --ieee=synopsys 00_nand.vhd
ghdl -a --ieee=synopsys 01_not.vhd
ghdl -a --ieee=synopsys 02_and.vhd
ghdl -a --ieee=synopsys 02_or.vhd
ghdl -a --ieee=synopsys 02_xor.vhd
ghdl -a --ieee=synopsys 03_logicGates_tb.vhd
ghdl -a --ieee=synopsys 04_add.vhd
ghdl -a --ieee=synopsys 04_nand3.vhd
ghdl -a --ieee=synopsys 04_sub.vhd
ghdl -a --ieee=synopsys 04_xor3.vhd
ghdl -a --ieee=synopsys 05_add8.vhd
ghdl -a --ieee=synopsys 05_sub8.vhd
ghdl -a --ieee=synopsys 06_addsub8_tb.vhd
ghdl -a --ieee=synopsys 07_cadd8.vhd
ghdl -a --ieee=synopsys 07_shl8.vhd
ghdl -a --ieee=synopsys 07_shr8.vhd
ghdl -a --ieee=synopsys 08_mult8.vhd
ghdl -a --ieee=synopsys 09_mult8_tb.vhd
ghdl -a --ieee=synopsys 10_mux.vhd
ghdl -a --ieee=synopsys 11_mux8.vhd
ghdl -a --ieee=synopsys 12_divblock.vhd
ghdl -a --ieee=synopsys 13_div8.vhd
ghdl -a --ieee=synopsys 14_div8_tb.vhd

ghdl -e --ieee=synopsys logic_gates_tb
ghdl -e --ieee=synopsys addsub8_tb
ghdl -e --ieee=synopsys mult8_tb
ghdl -e --ieee=synopsys div8_tb


ghdl -r --ieee=synopsys logic_gates_tb --vcd=logic_gates_tb.vcd
ghdl -r --ieee=synopsys addsub8_tb --vcd=addsub8_tb.vcd
ghdl -r --ieee=synopsys mult8_tb --vcd=mult8_tb.vcd
ghdl -r --ieee=synopsys div8_tb --vcd=div8_tb.vcd

# Visualisation of the results
# gtkwave logic_gates_tb.vcd
# gtkwave addsub8_tb.vcd
# gtkwave mult8_tb.vcd
# gtkwave div8_tb.vcd

