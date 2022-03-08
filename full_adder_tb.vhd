library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;
use ieee.fixed_float_types.all;

entity full_adder_tb is
end full_adder_tb;

architecture behavior of full_adder_tb is
    component full_adder is
        port (
        clk      : in  std_logic;
        operand1 : in  sfixed(16 downto -15);
        operand2 : in  sfixed(16 downto -15);
        carry    : out  std_logic;
        result   : out  sfixed(17 downto -15)
        );
    end component;
    signal signal_clk     : std_logic;
    signal signal_carry   : std_logic;
    signal signal_op1     : sfixed(16 downto -15);
    signal signal_op2     : sfixed(16 downto -15);
    signal signal_result  : sfixed(17 downto -15);

    constant clk_period : time := 10 ns;
begin
    uut: full_adder port map (
        clk      => signal_clk,
        operand1 => signal_op1,
        operand2 => signal_op2,
        carry    => signal_carry,
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
        signal_op1 <= "00000000000000000000000000000001";
        signal_op2 <= "00000000000000000000000000000000";
        wait for 10 ns;
        signal_op1 <= "00000000000000000000000000000001";
        signal_op2 <= "00000000000000000000000000000001";
        wait for 10 ns;
        signal_op1 <= "11111111111111111111111111111110";
        signal_op2 <= "11111111111111111111111111111111";
        wait for 10 ns;
        signal_op1 <= "11111111111111111111111111111111";
        signal_op2 <= "11111111111111111111111111111111";
        wait for 10 ns;
        signal_op1 <= "00000000000000001111111111111110";
        signal_op2 <= "00000000000111111111111111111111";
        wait for 10 ns;
        signal_op1 <= "00000000000000000001111111111111";
        signal_op2 <= "00000000000000000000000011111111";

        report "Full adder testbench finished";
        wait;
    end process;
end;
