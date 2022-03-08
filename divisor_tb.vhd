library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity divisor_tb is
end divisor_tb;

architecture behavior of divisor_tb is
    component divisor is
    generic(
       N         : integer := 32);
        port (
        clk      : in  std_logic;        
        operand1 : in signed(N-1 downto 0);
        div : in signed(N-1 downto 0);
        result   : out signed(N-1 downto 0));
    end component;

    signal signal_clk     : std_logic;
    signal signal_operand1  : signed (31 downto 0);
    signal signal_divisor     : signed (31 downto 0);
    signal signal_result  : signed (31 downto 0);

    constant clk_period : time := 10 ns;
begin
    uut: divisor port map (
        clk      => signal_clk,
        operand1 => signal_operand1,
        div => signal_divisor,
        result   => signal_result
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
        signal_operand1 <= "00000000000000000000000000000010";
        signal_divisor <= "00000000000000000000000000000001";
        wait for 10 ns;
        signal_operand1 <= "00000000000000000000000000100010";
        signal_divisor <= "00000000000000000000000000000010";
        wait for 10 ns;
        signal_operand1 <= "00000000000000000000000000001100";
        signal_divisor <= "00000000000000000000000000000010";
        wait for 10 ns;
        signal_operand1 <= "00000000000000001000000000000000";
        signal_divisor <= "00000000000000000000000000001100";
        wait for 10 ns;
        report "Full divisor testbench finished";
        wait;
    end process;
end;
