library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity runge_kutta_k2 is
    generic(
       N         : integer := 32);
    port (
        clk        : in  std_logic;
        input      : in  signed(N-1 downto 0);
        input_k1   : in  signed(N-1 downto 0);        
        k2_output  : out  signed(N-1 downto 0);
        ready      : out  std_logic);        
end;

architecture behavioral of runge_kutta_k2 is
            
    begin

    runge_kutta_k2_process : process(clk)

    begin
        if(rising_edge(clk)) then
            k2_output <= input;                                              
        end if;

   end process runge_kutta_k2_process; 
end;