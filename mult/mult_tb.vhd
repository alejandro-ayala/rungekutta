library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Multiplier32Bits_testbench is
end Multiplier32Bits_testbench;

architecture behavior of Multiplier32Bits_testbench is
    component Multiplier32Bits is
    port(
        CLK: in std_logic;
        A,B: in signed(31 downto 0);
        mult_result: out signed(63 downto 0));
    end component;
    signal signal_clk     : std_logic;
    signal signal_A     : signed (31 downto 0);
    signal signal_B     : signed (31 downto 0);
    signal signal_result  : signed (63 downto 0);
    constant clk_period : time := 10 ns;
begin
    uut: Multiplier32Bits port map (
        CLK      => signal_clk,
        A => signal_A,
        B => signal_B,
        mult_result    => signal_result
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
        signal_A <= "00000000000000000000000000000001";
        signal_B <= "00000000000000000000000000000001";
        wait for 10 ns;
        signal_A <= "00000000000000000000000000000100";
        signal_B <= "00000000000000000000000000000010";
        wait for 10 ns;
        signal_A <= "00000000000000000000000000000101";
        signal_B <= "00000000000000000000000000000100";
        wait for 10 ns;
        signal_A <= "00000000000000000000000000001000";
        signal_B <= "00000000000000000000000000001000";
        wait for 10 ns;
        signal_A <= "00000000000000000000000010001000";
        signal_B <= "00000000000000000000000000001001";
        wait for 10 ns;
        signal_A <= "00000000000000000000000000001000";
        signal_B <= "00000000000000000000000000001000";
        wait for 10 ns;
        signal_A <= "11111111111111111111111111111111";
        signal_B <= "11111111111111111111111111111110";
        wait for 10 ns;
        signal_A <= "11111111111111111111111111111111";
        signal_B <= "00000000000000000000000000000001";
        report "Multiplier testbench finished";
        wait;
    end process;
end;
