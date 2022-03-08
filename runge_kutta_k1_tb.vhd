library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;
use ieee.fixed_float_types.all;

entity runge_kutta_k1_tb is
end runge_kutta_k1_tb;

architecture behavior of runge_kutta_k1_tb is
    component runge_kutta_k1 is
    generic(
       N         : integer := 32);
    port (
        clk         : in  std_logic;
        input1      : in  sfixed(16 downto -15);
        input2      : in  sfixed(16 downto -15);    
        step        : in  sfixed(16 downto -15);                        
        k1_output   : out sfixed(16 downto -15);    
        ready       : out  std_logic);    
    end component;

    signal signal_clk         : std_logic;
    signal signal_input1      : sfixed(16 downto -15);
    signal signal_input2      : sfixed(16 downto -15);   
    signal signal_output      : sfixed(16 downto -15);
    signal signal_step        : sfixed(16 downto -15);    

    constant clk_period : time := 10 ns;
begin
    uut: runge_kutta_k1 port map (
        clk        => signal_clk,
        input1     => signal_input1,
        input2     => signal_input2,        
        k1_output  => signal_output ,
        step       => signal_step                                   
    );

   -- Clock process definitions
   Clk_process :process
   begin
        signal_clk <= '0';
        wait for clk_period/2;
        signal_clk <= '1';
        wait for clk_period/2;
   end process;

    stim_proc_k1: process
    begin
          
        wait until rising_edge(signal_clk);
        signal_input1 <= "00000000000000000000000000100011";
        signal_input2 <= "00000000000000000000000000100011";
        signal_step <= "00000000000000000000000000000001"; 

        wait for 100000 ns;    
        report "runge_kutta_k1 testbench finished";
        wait;
    end process;
end;
