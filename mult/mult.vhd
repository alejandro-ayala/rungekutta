library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Multiplier32Bits is
    port(
        CLK: in std_logic;
        A,B: in signed(31 downto 0);
        mult_result: out signed(63 downto 0)
    );
end Multiplier32Bits;

architecture Behavioral of Multiplier32Bits is
signal state: signed(63 downto 0);

begin

    mult_process: process(CLK,state)
    begin
        if(rising_edge(clk)) then
    --Combinational part
            state <= (A*B);
    --Output assigment
            mult_result <= state;
        end if;
    end process mult_process;

end Behavioral;
