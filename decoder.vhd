library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;
use ieee.fixed_float_types.all;

entity decoder is
    port (
        clk          : in  std_logic;
        input1_real  : in  real ;
        input2_real  : in  real ;
        input1_fixed : out sfixed(16 downto -15);
        input2_fixed : out sfixed(16 downto -15));

end;

architecture behavioral of decoder is

begin
     
    deco_process : process(clk)
    begin

        if(rising_edge(clk)) then
            input1_fixed <= to_sfixed (input1_real,16,-15); 
            input2_fixed <= to_sfixed (input2_real,16,-15); 

        end if;
   end process deco_process; 
end;
