library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sub is
    generic(
       N         : integer := 32);
    port (
        clk      : in  std_logic;
        operand1 : in  signed(N-1 downto 0);
        operand2 : in  signed(N-1 downto 0);
        result   : out signed(N-1 downto 0));
end;

architecture behavioral of sub is
    signal temporal     : signed (N-1 downto 0);
    
    begin

    sub_process : process(clk)
    begin

        if(rising_edge(clk)) then
            temporal <= (operand1 - operand2);
            result <= temporal(31 downto 0);

        end if;
   end process sub_process; 
end;
