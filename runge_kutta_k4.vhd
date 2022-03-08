library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;
use ieee.fixed_float_types.all;

entity runge_kutta_k4 is
    generic(
       N         : integer := 32);
    port (
        clk        : in  std_logic;
        input1      : in  sfixed(16 downto -15);
        input2      : in  sfixed(16 downto -15);        
        input_k3   : in  sfixed(16 downto -15); 
        step       : in  sfixed(16 downto -15);                             
        k4_output  : out  sfixed(16 downto -15);
        ready      : out  std_logic);        
end;

architecture behavioral of runge_kutta_k4 is

component full_adder is
    port(
        clk      : in  std_logic;
        operand1 : in  sfixed(16 downto -15);
        operand2 : in  sfixed(16 downto -15);
        carry    : out  std_logic;
        result   : out sfixed(17 downto -15)
    );
end component;

component sub is
    port(
        clk      : in  std_logic;
        operand1 : in  sfixed(16 downto -15);
        operand2 : in  sfixed(16 downto -15);
        result   : out sfixed(17 downto -15)
    );
end component;

component Multiplier32Bits is
    port(
        CLK: in std_logic;
        operand1: in sfixed(16 downto -15);
        operand2: in sfixed(16 downto -15);
        mult_result: out sfixed(32 downto -31)
    );
end component;

component ec_diff is
    port(
        clk        : in  std_logic;
        x          : in  sfixed(16 downto -15);
        y          : in  sfixed(16 downto -15); 
        output     : out  sfixed(18 downto -15);
        ready      : out  std_logic  
    );
end component;

signal signal_carry_x: std_logic;
signal signal_carry_y: std_logic;
signal signal_sum_x: sfixed(17 downto -15);
signal signal_sum_y: sfixed(17 downto -15);
signal signal_mult: sfixed(32 downto -31); 
signal signal_ec:   sfixed(18 downto -15);

    begin

mult: Multiplier32Bits port map (CLK => clk, operand1 => signal_ec(16 downto -15),operand2 => step,mult_result => signal_mult);    

sum_X: full_adder port map (clk => clk, operand1 => input1,operand2 => step, carry => signal_carry_x,result => signal_sum_x);
sum_Y: full_adder port map (clk => clk, operand1 => input2,operand2 => input_k3, carry => signal_carry_y,result => signal_sum_y);
func: ec_diff port map (CLK => clk, x => signal_sum_x(16 downto -15),y => signal_sum_y(16 downto -15),output => signal_ec);

    runge_kutta_k4_process : process(clk)

    begin
        if(rising_edge(clk)) then
            k4_output <= signal_mult(16 downto -15);                                                                                               
        end if;

   end process runge_kutta_k4_process; 
end;