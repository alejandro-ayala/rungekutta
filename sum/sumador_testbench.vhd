library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity full_adder_testbench is
end full_adder_testbench;

architecture behavior of full_adder_testbench is
    component full_adder is
    generic(
       N         : integer := 32);
        port (
        clk      : in  std_logic;
        operand1 : in  signed(N-1 downto 0);
        operand2 : in  signed(N-1 downto 0);
        carry    : out  std_logic;
        result   : out signed(N-1 downto 0));
    end component;
    signal signal_clk     : std_logic;
    signal signal_carry   : std_logic;
    signal signal_op1     : signed (31 downto 0);
    signal signal_op2     : signed (31 downto 0);
    signal signal_result  : signed (31 downto 0);

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
        report "Full adder testbench finished";
        wait;
    end process;
end;
