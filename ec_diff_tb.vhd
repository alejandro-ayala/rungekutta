library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;
use ieee.fixed_float_types.all;

entity ec_diff_tb is
end ec_diff_tb;

architecture behavior of ec_diff_tb is
    component ec_diff is
    port (
        clk        : in  std_logic;
        x          : in  sfixed(16 downto -15);
        y          : in  sfixed(16 downto -15);
        output     : out  sfixed(18 downto -15);
        ready      : out  std_logic);    
    end component;

    signal signal_clk         : std_logic;
    signal signal_x           : sfixed(16 downto -15);
    signal signal_y           : sfixed(16 downto -15);
    signal signal_output      : sfixed(18 downto -15);

    constant clk_period : time := 10 ns;
begin
    uut: ec_diff port map (
        clk        => signal_clk,
        x          => signal_x,
        y          => signal_y,
        output     => signal_output
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
        signal_x <= "00000000000000000000000000000001";  
        signal_y <= "00000000000000000000000000000011";                                                
        report "ec_diff testbench finished";
        wait;
    end process;
end;
