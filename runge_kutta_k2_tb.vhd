library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity runge_kutta_k2_tb is
end runge_kutta_k2_tb;

architecture behavior of runge_kutta_k2_tb is
    component runge_kutta_k2 is
    generic(
       N         : integer := 32);
    port (
        clk         : in  std_logic;
        input       : in  signed(N-1 downto 0);
        input_k1    : in  signed(N-1 downto 0);        
        k2_output   : out  signed(N-1 downto 0);
        ready       : out  std_logic);    
    end component;

    signal signal_clk         : std_logic;
    signal signal_input       : signed (31 downto 0);
    signal signal_input_k1    : signed (31 downto 0);    
    signal signal_output      : signed (31 downto 0);

    constant clk_period : time := 10 ns;
begin
    uut: runge_kutta_k2 port map (
        clk        => signal_clk,
        input      => signal_input,
        input_k1   => signal_input_k1,        
        k2_output  => signal_output            
    );

   -- Clock process definitions
   Clk_process :process
   begin
        signal_clk <= '0';
        wait for clk_period/2;
        signal_clk <= '1';
        wait for clk_period/2;
   end process;

    stim_proc_k2: process
    begin
          
        wait until rising_edge(signal_clk);
        signal_input <= "00000000000000000000000000100011";      
        signal_input_k1 <= "00000000000000000000100000100011";              
        report "runge_kutta_k2 testbench finished";
        wait;
    end process;
end;
