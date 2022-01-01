library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Multiplier32Bits is
    port(
        CLK: in std_logic;
        A,B: in signed(31 downto 0);
        R: out signed(31 downto 0)
    );
end Multiplier32Bits;

architecture Behavioral of Multiplier32Bits is
signal next_state: signed(63 downto 0);
signal state: signed(31 downto 0);

begin

    Sequential: process(CLK,state,next_state)
    begin
        if CLK'event and CLK = '1' then
            state <= next_state(61 downto 30);
        else
            state <= state;
        end if;
    end process Sequential;

    --Combinational part
        next_state <= (A*B);

    --Output assigment
    R <= state;

end Behavioral;
