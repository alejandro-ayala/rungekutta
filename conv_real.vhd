library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;
use ieee.fixed_float_types.all;

entity conv_real is
    port (
        clk          : in  std_logic;
        result_alg   : in sfixed(19 downto -15);
        result_alg_real  : out  real );        
end;

architecture behavioral of conv_real is

begin
     
    conv_real_process : process(clk)
    begin

        if(rising_edge(clk)) then
            result_alg_real <= to_real(result_alg); 

        end if;
   end process conv_real_process; 
end;
