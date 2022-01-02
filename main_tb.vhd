library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity runge_kutta_algorith_testbench is
end runge_kutta_algorith_testbench;

architecture behavior of runge_kutta_algorith_testbench is
    component runge_kutta_algorith is
    generic(
       N         : integer := 32);
        port (
        clk      : in  std_logic;
        operand1 : in  signed(N-1 downto 0);
        operand2 : in  signed(N-1 downto 0);
        operand3 : in  signed(N-1 downto 0);
        operand4 : in  signed(N-1 downto 0);
        result_alg   : out signed(2*N-1 downto 0));
    end component;
    signal signal_clk     : std_logic;
    signal signal_op1     : signed (31 downto 0);
    signal signal_op2     : signed (31 downto 0);
    signal signal_op3     : signed (31 downto 0);
    signal signal_op4     : signed (31 downto 0);
    signal signal_result  : signed (63 downto 0);

    constant clk_period : time := 10 ns;
begin
    uut: runge_kutta_algorith port map (
        clk      => signal_clk,
        operand1 => signal_op1,
        operand2 => signal_op2,
        operand3 => signal_op3,
        operand4 => signal_op4,
        result_alg   => signal_result
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
        signal_op3 <= "00000000000000000000000000000001";
        signal_op4 <= "00000000000000000000000000000001";
        wait for 10 ns;
        signal_op1 <= "00000000000000000000000000000001";
        signal_op2 <= "00000000000000000000000000000001";
        signal_op3 <= "00000000000000000000000000000001";
        signal_op4 <= "00000000000000000000000000000001";
        wait for 10 ns;
        signal_op1 <= "00000000000000000000000000000001";
        signal_op2 <= "00000000000000000000000000000010";
        signal_op3 <= "00000000000000000000000000000001";
        signal_op4 <= "00000000000000000000000000000001";
        wait for 10 ns;
        signal_op1 <= "00000000000000000000000000000010";
        signal_op2 <= "00000000000000000000000000000010";
        signal_op3 <= "00000000000000000000000000000001";
        signal_op4 <= "00000000000000000000000000000001";
        report "Runge Kutta testbench finished";
        wait;
    end process;
end;
