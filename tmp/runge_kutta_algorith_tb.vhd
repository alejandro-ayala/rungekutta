library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity runge_kutta_algorith_tb is
end runge_kutta_algorith_tb;

architecture behavior of runge_kutta_algorith_tb is
    component runge_kutta_algorith is
    generic(
       N         : integer := 32);
        port (
        clk      : in  std_logic;
        input1   : in  signed(N-1 downto 0);
        input2   : in  signed(N-1 downto 0);
        step     : in  signed(N-1 downto 0);
        result_alg   : out signed(2*N-1 downto 0));
    end component;

    signal signal_clk     : std_logic;
    signal signal_input1  : signed (31 downto 0);
    signal signal_input2  : signed (31 downto 0);
    signal signal_step    : signed (31 downto 0);
    signal signal_result  : signed (63 downto 0);

    constant clk_period : time := 10 ns;
begin
    uut: runge_kutta_algorith port map (
        clk      => signal_clk,
        input1   => signal_input1,
        input2   => signal_input2,
        step     => signal_step,
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
        signal_input1 <= "00000000000000000000000000000001";
        signal_input2 <= "00000000000000000000000000000000";
        signal_step <= "00000000000000000000000000000001";
        wait for 10 ns;
        signal_input1 <= "00000000000000000000000010000001";
        signal_input2 <= "00000000001000000011000000000000";
        wait for 10 ns;
        signal_input1 <= "00000000010000000000000001000001";
        signal_input2 <= "00000000000000000000000010000000";
        wait for 10 ns;
        signal_input1 <= "00000000001000000000000000000001";
        signal_input2 <= "00000100000000000000010000000000";
        report "Runge Kutta testbench finished";
        wait;
    end process;
end;
