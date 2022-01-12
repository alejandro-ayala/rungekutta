library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity runge_kutta_algorith is
    generic(
       N         : integer := 32);
    port (
        clk      : in  std_logic;
        operand1 : in  signed(N-1 downto 0);
        operand2 : in  signed(N-1 downto 0);
        operand3 : in  signed(N-1 downto 0);
        operand4 : in  signed(N-1 downto 0);
        result_alg   : out signed(2*N-1 downto 0));
end;

architecture structural of runge_kutta_algorith is

signal signal_in0 : std_logic_vector(N-1 downto 0);
signal signal_in1 : std_logic_vector(N-1 downto 0);
signal signal_out : std_logic_vector(N-1 downto 0);

component full_adder is
    port(
        clk      : in  std_logic;
        operand1 : in  signed(N-1 downto 0);
        operand2 : in  signed(N-1 downto 0);
        carry    : out  std_logic;
        add_result   : out signed(N-1 downto 0)
    );
end component;

component sub is
    port(
        clk      : in  std_logic;
        operand1 : in  signed(N-1 downto 0);
        operand2 : in  signed(N-1 downto 0);
        result   : out signed(N-1 downto 0)
    );
end component;

component Multiplier32Bits is
    port(
        CLK: in std_logic;
        operand1,operand2: in signed(31 downto 0);
        mult_result: out signed(63 downto 0)
    );
end component;

signal signal_carry: std_logic;
signal signal_sum: signed(31 downto 0);
signal signal_sub: signed(31 downto 0);

signal signal_mult: signed(63 downto 0);
signal signal_temporal     : signed (63 downto 0);

signal signal_carry2: std_logic;
signal signal_sum2: signed(31 downto 0);
signal signal_mult2: signed(63 downto 0);

begin
  sumA: full_adder port map (clk => clk, operand1 => operand1,operand2 => operand2, carry => signal_carry,add_result => signal_sum);
  multA: Multiplier32Bits port map (CLK => clk, operand1 => operand3,operand2 => operand4,mult_result => signal_mult);
  sumB: full_adder port map (clk => clk, operand1 => operand3,operand2 => operand4, carry => signal_carry2,add_result => signal_sum2);
  multB: Multiplier32Bits port map (CLK => clk, operand1 => operand1,operand2 => operand2,mult_result => signal_mult2);
  rest: sub port map (CLK => clk, operand1 => signal_mult,operand2 => signal_mult2,result => signal_sub);

    main_process : process(clk)
    begin

        if(rising_edge(clk)) then
            signal_temporal <= signal_sum + signal_mult + signal_sum2 + signal_mult2 - signal_sub;
            result_alg <= signal_temporal;

        end if;
   end process main_process; 

end architecture;

