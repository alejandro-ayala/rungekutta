library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;
use ieee.fixed_float_types.all;

entity sub is
    port (
        clk      : in  std_logic;
        operand1 : in  sfixed(16 downto -15);
        operand2 : in  sfixed(16 downto -15);
        result   : out sfixed(17 downto -15));
end;

architecture behavioral of sub is

    
    begin

    sub_process : process(clk)
    begin

        if(rising_edge(clk)) then
            result <= (operand1 - operand2);
            

        end if;
   end process sub_process; 
end;
