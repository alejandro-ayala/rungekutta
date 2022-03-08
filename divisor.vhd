library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity divisor is
    generic(
       N         : integer := 32);
    port (
        clk      : in  std_logic;
        operand1 : in signed(N-1 downto 0);
        div      : in signed(N-1 downto 0);
        result   : out signed(N-1 downto 0));
end;

architecture behavioral of divisor is
    signal temporal     : real range  0.0 to 15.0;  
    
    begin

    div_process : process(clk)
    begin

        if(rising_edge(clk)) then
            --result <= to_signed(to_integer(signed(operand1) / signed(div)),32);
            result <= operand1/div;

        end if;
   end process div_process; 
end;
