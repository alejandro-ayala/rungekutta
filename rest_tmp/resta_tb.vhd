library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sub_testbench is
end sub_testbench;

architecture behavior of sub_testbench is
    component sub is
    generic(
       N         : integer := 32);
        port (
        clk      : in  std_logic;
        operand1 : in  signed(N-1 downto 0);
        operand2 : in  signed(N-1 downto 0);
        result   : out signed(N-1 downto 0));
    end component;
    signal signal_clk     : std_logic;
    signal signal_op1     : signed (31 downto 0);
    signal signal_op2     : signed (31 downto 0);
    signal signal_result  : signed (31 downto 0);

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
