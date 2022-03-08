library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;
use ieee.fixed_float_types.all;

entity ec_diff is
    port (
        clk        : in  std_logic;
        x          : in  sfixed(16 downto -15);
        y          : in  sfixed(16 downto -15);
        output     : out  sfixed(18 downto -15);
        ready      : out  std_logic);        
end;

architecture behavioral of ec_diff is

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

signal signal_carry: std_logic;
signal signal_sum: sfixed(17 downto -15);
signal signal_diff: sfixed(17 downto -15);
signal signal_mult_x: sfixed(32 downto -31); 
signal signal_mult_y: sfixed(32 downto -31);

    begin

mult_X: Multiplier32Bits port map (CLK => clk, operand1 => x,operand2 => x,mult_result => signal_mult_x); 
mult_Y: Multiplier32Bits port map (CLK => clk, operand1 => y,operand2 => y,mult_result => signal_mult_y);    
add:    full_adder port map (clk => clk, operand1 => signal_mult_x(31 downto 0),operand2 => signal_mult_y(31 downto 0), carry => signal_carry,result => signal_sum);
diff:   sub port map (CLK => clk, operand1 => signal_mult_y(31 downto 0),operand2 => signal_mult_x(31 downto 0),result => signal_diff);

    ec_diff_process : process(clk)

    begin
        if(rising_edge(clk)) then
            output <= signal_sum + signal_diff;      
                                                     
        end if;

   end process ec_diff_process; 
end;