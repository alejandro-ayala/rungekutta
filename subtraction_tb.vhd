library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;
use ieee.fixed_float_types.all;

entity subtraction_tb is
end subtraction_tb;

architecture behavior of subtraction_tb is
    component sub is
        port (
        clk      : in  std_logic;
        operand1 : in  sfixed(16 downto -15);
        operand2 : in  sfixed(16 downto -15);
        result   : out sfixed(17 downto -15));
    end component;
    signal signal_clk     : std_logic;
    signal signal_op1     : sfixed(16 downto -15);
    signal signal_op2     : sfixed(16 downto -15);
    signal signal_result  : sfixed(17 downto -15);

    constant clk_period : time := 10 ns;
begin
    uut: sub port map (
        clk      => signal_clk,
        operand1 => signal_op1,
        operand2 => signal_op2,
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
        signal_op1 <= "00000000000000000000000000000101";
        signal_op2 <= "00000000000000000000000000000001";
        wait for 10 ns;
        signal_op1 <= "00000000000000000000100000000111";
        signal_op2 <= "00000000000000000000000000000011";
        wait for 10 ns;
        signal_op1 <= "00000000000000000000000000100011";
        signal_op2 <= "00000000000000000000000000000011";
        wait for 10 ns;
        signal_op1 <= "00000000000000000000000000000011";
        signal_op2 <= "00000000000000000000000000000011";
        report "Sub testbench finished";
        wait;
    end process;
end;
