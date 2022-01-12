library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity input_data_tb is
end input_data_tb;

architecture behavior of input_data_tb is
    component input_data is
    generic(
       N         : integer := 32);
    port (
        clk         : in  std_logic;
        start       : in  std_logic;        
        input      : in  signed(N-1 downto 0);
        output1     : out  signed(N-1 downto 0);
        output2     : out  signed(N-1 downto 0);
        output3     : out  signed(N-1 downto 0);
        output4     : out  signed(N-1 downto 0);
        ready       : out  std_logic);   
    end component;

    signal signal_clk         : std_logic;
    signal signal_input       : signed (31 downto 0);
    signal signal_start       : std_logic;
    signal signal_output1     : signed (31 downto 0);
    signal signal_output2     : signed (31 downto 0);
    signal signal_output3     : signed (31 downto 0);
    signal signal_output4     : signed (31 downto 0);

    constant clk_period : time := 10 ns;
begin
    uut: input_data port map (
        clk        => signal_clk,
        input      => signal_input,
        start      => signal_start,
        output1    => signal_output1,
        output2    => signal_output2,
        output3    => signal_output3,
        output4    => signal_output4                
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
        signal_start <= '0';            
        wait until rising_edge(signal_clk);
        signal_input <= "00000000000000000000000000000001";        
        wait for 10 ns;
        signal_start <= '1';        
        wait for 10 ns;
        signal_input <= "00000000000000000000000000000111";
        wait for 10 ns;
        signal_input <= "00000000000000000000000000000011";
        wait for 10 ns;
        signal_input <= "00000000000000000000000000100101";
        wait for 10 ns;                
        report "Sub testbench finished";
        wait;
    end process;
end;
