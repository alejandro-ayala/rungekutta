rm work-obj93.cf
rm work-obj08.cf
ghdl -a --std=08  sumador.vhd
ghdl -a --std=08  resta.vhd
ghdl -a --std=08  mult.vhd
ghdl -a --std=08  ec_diff.vhd
ghdl -a --std=08  runge_kutta_k1.vhd
ghdl -a --std=08  runge_kutta_k2.vhd
ghdl -a --std=08  runge_kutta_k3.vhd
ghdl -a --std=08  runge_kutta_k4.vhd
ghdl -a --std=08  runge_kutta_algorith.vhd
ghdl -a --std=08  runge_kutta_algorith_tb.vhd
ghdl -e --std=08 runge_kutta_algorith_tb
ghdl -r --std=08 runge_kutta_algorith_tb --vcd=runge_kutta_algorith_tb.vcd
gtkwave runge_kutta_algorith_tb.vcd