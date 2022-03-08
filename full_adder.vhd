library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;
use ieee.fixed_float_types.all;

entity full_adder is
    port (
        clk      : in  std_logic;
        operand1 : in  sfixed(16 downto -15);
        operand2 : in  sfixed(16 downto -15);
        carry    : out  std_logic;
        result   : out  sfixed(17 downto -15)
        );
end;

architecture behavioral of full_adder is
    
    begin

    sum_process : process(clk)
    begin

        if(rising_edge(clk)) then
            result <= operand1 + operand2;
            carry <= result(16);
            --result <= temporal(31 downto 0);

        end if;
   end process sum_process; 
end;
