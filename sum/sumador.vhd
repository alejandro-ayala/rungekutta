library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity full_adder is
    generic(
       N         : integer := 32);
    port (
        clk      : in  std_logic;
        operand1 : in  signed(N-1 downto 0);
        operand2 : in  signed(N-1 downto 0);
        carry    : out  std_logic;
        add_result   : out signed(N-1 downto 0));
end;

architecture behavioral of full_adder is
    signal temporal     : signed (N downto 0);
    
    begin

    sum_process : process(clk)
    begin

        if(rising_edge(clk)) then
            --signal_op1 <= resize(signed(signal_op1),N);
            --signal_op2 <= resize(signed(signal_op2),N);
            --result <= std_logic_vector(signal_result);
            temporal <= ('0' & operand1) + ('0' & operand2);
            carry <= temporal(32);
            add_result <= temporal(31 downto 0);

        end if;
   end process sum_process; 
end;
