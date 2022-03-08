library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;
use ieee.fixed_float_types.all;


entity decoder_tb is
end decoder_tb;

architecture behavior of decoder_tb is
    component decoder is
        port (
        clk          : in  std_logic;
        input1_real  : in  real ;
        input2_real  : in  real ;
        input1_fixed : out sfixed(16 downto -15);
        input2_fixed : out sfixed(16 downto -15));
    end component;

    signal signal_clk            : std_logic;    
    signal signal_input1_real    : real;
    signal signal_input2_real    : real;
    signal signal_input1_fixed   : sfixed(16 downto -15);
    signal signal_input2_fixed   : sfixed(16 downto -15);

    constant clk_period : time := 10 ns;
begin
    uut: decoder port map (
        clk           => signal_clk,
        input1_real   => signal_input1_real,
        input2_real   => signal_input2_real,
        input1_fixed  => signal_input1_fixed,
        input2_fixed  => signal_input2_fixed
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
        signal_input1_real <= 9.75;
        signal_input2_real <= 4.5;
        wait for 10 ns;
       -- signal_input1_real <= 2.2;
        --signal_input2_real <= 4.5;
        --wait for 10 ns;
        --signal_input1_real <= 1.2;
        --signal_input2_real <= 7.1;
        --wait for 10 ns;
        --signal_input1_real <= 2.2;
        --signal_input2_real <= 4.5;
        report "Full adder testbench finished";
        wait;
    end process;
end;
