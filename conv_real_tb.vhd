library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;
use ieee.fixed_float_types.all;


entity conv_real_tb is
end conv_real_tb;

architecture behavior of conv_real_tb is
    component conv_real is
        port (
        clk          : in  std_logic;
        result_alg   : in sfixed(19 downto -15);
        result_alg_real  : out  real );    
    end component;

    signal signal_clk            : std_logic;    
    signal signal_result_alg    : sfixed(19 downto -15);
    signal signal_result_alg_real    : real;

    constant clk_period : time := 10 ns;
begin
    uut: conv_real port map (
        clk           => signal_clk,
        result_alg   => signal_result_alg,
        result_alg_real   => signal_result_alg_real
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
        signal_result_alg <= "00000000000001100000000000000000001";
        wait for 10 ns;
        report "Full adder testbench finished";
        wait;
    end process;
end;
