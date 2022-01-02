library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Multiplier32Bits is
    port(
        CLK: in std_logic;
        operand1,operand2: in signed(31 downto 0);
        mult_result: out signed(63 downto 0)
    );
end Multiplier32Bits;

architecture Behavioral of Multiplier32Bits is
signal temporal: signed(63 downto 0);

begin

    mult_process: process(CLK,temporal)
    begin
        if(rising_edge(clk)) then
    --Combinational part
            temporal <= (operand1*operand2);
    --Output assigment
            mult_result <= temporal;
        end if;
    end process mult_process;

end Behavioral;
