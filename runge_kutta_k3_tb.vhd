library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;
use ieee.fixed_float_types.all;

entity runge_kutta_k3_tb is
end runge_kutta_k3_tb;

architecture behavior of runge_kutta_k3_tb is
    component runge_kutta_k3 is
    port (
        clk        : in  std_logic;
        input1     : in  sfixed(16 downto -15);
        input2     : in  sfixed(16 downto -15);     
        input_k2   : in  sfixed(16 downto -15); 
        step       : in  sfixed(16 downto -15);                
        k3_output  : out  sfixed(16 downto -15);
        ready      : out  std_logic);    
    end component;

    signal signal_clk         : std_logic;
    signal signal_input1      : sfixed(16 downto -15);
    signal signal_input2      : sfixed(16 downto -15);    
    signal signal_input_k2    : sfixed(16 downto -15);    
    signal signal_output      : sfixed(16 downto -15);
    signal signal_step        : sfixed(16 downto -15);  

    constant clk_period : time := 10 ns;
begin
    uut: runge_kutta_k3 port map (
        clk        => signal_clk,
        input1      => signal_input1,
        input2      => signal_input2,        
        input_k2      => signal_input_k2,
        k3_output    => signal_output,
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

    stim_proc: process
    begin
        wait until rising_edge(signal_clk);
        signal_step <= "00000000000000000000000000000001";                      
        signal_input1 <= "00000000000000000000000000000001"; 
        signal_input2 <= "00000001000000000000000000000001";           
        signal_input_k2 <= "00000000000000000000000000000011";                                                
        report "runge_kutta_k3 testbench finished";
        wait;
    end process;
end;
