elaborate design: https://lauri.võsandi.com/hdl/ghdl.html
simulation link: https://lauri.võsandi.com/hdl/gtkwave.html

Steps: 

1) Copy design and testbench files: full_adder.vhd and full_adder_testbench.vhd (edit file and copy from link)
2) compile(analyze syntaxis) binary object: 
	-ghdl -a full_adder.vhd
	-ghdl -a full_adder_testbench.vhd
3) Elaborate design unit (the name "full_adder_testbench" must be the same that the entity not that the file name). 
	-ghdl -e full_adder_testbench
4)Elaborate and run design UNIT
	-ghdl -r full_adder_testbench --vcd=full_adder.vcd 
** The following msg is showd if it was sucesfully: "full_adder_testbench.vhd:36:9:@70ns:(report note): Full adder testbench finished"
5) Run the simulation
	gtkwave full_adder.vcd

