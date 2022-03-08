library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;
use ieee.fixed_float_types.all;

entity runge_kutta_algorith_tb is
end runge_kutta_algorith_tb;

architecture behavior of runge_kutta_algorith_tb is
    component runge_kutta_algorith is
        port (
        clk      : in  std_logic;
        input_alg_1   : in  real;
        input_alg_2   : in  real;
        step     : in  sfixed(16 downto -15);
        result_alg   : real);
    end component;

    signal signal_clk     : std_logic;
    signal signal_input1  : real;
    signal signal_input2  : real;
    signal signal_step    : sfixed(16 downto -15);
    signal signal_result  : real;

    constant clk_period : time := 10 ns;
begin
    uut: runge_kutta_algorith port map (
        clk      => signal_clk,
        input_alg_1   => signal_input1,
        input_alg_2   => signal_input2,
        step     => signal_step,
        result_alg   => signal_result
    );

   -- Clock process definitions
   Clk_process :process
   begin
        signal_clk <= '0';
        wait for clk_period/2;
        signal_clk <= '1';
        wait for clk_period/2;
   end process;

    stim_proc: process
    begin
        wait until rising_edge(signal_clk);
        wait for 20 ns;
        signal_input1 <= 1.1;
        signal_input2 <= 2.2;
        signal_step <= "00000000000000000000000000000001";
        wait for 10 ns;
        signal_input1 <= 1.1;
        signal_input2 <= 2.2;
        wait for 10 ns;
        signal_input1 <= 1.1;
        signal_input2 <= 2.2;
        wait for 10 ns;
        signal_input1 <= 1.1;
        signal_input2 <= 2.2;
        report "Runge Kutta testbench finished";
        wait;
    end process;
end;
