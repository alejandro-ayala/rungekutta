library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity runge_kutta_k4 is
    generic(
       N         : integer := 32);
    port (
        clk        : in  std_logic;
        input      : in  signed(N-1 downto 0);
        input_k3   : in  signed(N-1 downto 0);        
        k4_output  : out  signed(N-1 downto 0);
        ready      : out  std_logic);        
end;

architecture behavioral of runge_kutta_k4 is
            
    begin

    runge_kutta_k4_process : process(clk)

    begin
        if(rising_edge(clk)) then
            k4_output <= input;                                                                                                
        end if;

   end process runge_kutta_k4_process; 
end;