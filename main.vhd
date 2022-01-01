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
        result_alg   : out signed(N-1 downto 0));
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
        result   : out signed(N-1 downto 0)
    );
end component;


component Multiplier32Bits is
    port(
        CLK: in std_logic;
        A,B: in signed(31 downto 0);
        R: out signed(31 downto 0)
    );
end component;

signal signal_carry: std_logic;
signal signal_sum: signed(31 downto 0);
signal signal_mult: signed(31 downto 0);
signal signal_temporal     : signed (31 downto 0);

begin
  sum: full_adder port map (clk => clk, operand1 => operand1,operand2 => operand2, carry => signal_carry,result => signal_sum);
  mult: Multiplier32Bits port map (CLK => clk, A => operand1,B => operand2,R => signal_mult);


    main_process : process(clk)
    begin

        if(rising_edge(clk)) then
            signal_temporal <= signal_sum + signal_mult;
            result_alg <= signal_temporal;

        end if;
   end process main_process; 

end architecture;

