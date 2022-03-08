library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;
use ieee.fixed_float_types.all;

entity Multiplier32Bits is
    port(
        CLK: in std_logic;
        operand1,operand2: in sfixed(16 downto -15);
        mult_result: out sfixed(32 downto -31)
    );
end Multiplier32Bits;

architecture Behavioral of Multiplier32Bits is

begin

    mult_process: process(CLK)
    begin
        if(rising_edge(clk)) then
            mult_result <= (operand1*operand2);
        end if;
    end process mult_process;

end Behavioral;
