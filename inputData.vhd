library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity input_data is
    generic(
       N         : integer := 32);
    port (
        clk         : in  std_logic;
        start       : in  std_logic;        
        input      : in  signed(N-1 downto 0);
        output1     : out  signed(N-1 downto 0);
        output2     : out  signed(N-1 downto 0);
        output3     : out  signed(N-1 downto 0);
        output4     : out  signed(N-1 downto 0);
        ready       : out  std_logic);        
end;

architecture behavioral of input_data is
           
    signal counter : natural range 0 to 3;
 
    begin

    input_data_process : process(clk,start)

    begin
        if(rising_edge(clk) AND start = '1') then
            
            case counter is 
                when 0 =>
                    ready <= '0';
                    output1 <= input;
                    counter <= counter + 1;   
                when 1 =>
                    ready <= '0';
                    output2 <= input;
                    counter <= counter + 1;                       
                when 2 =>
                    ready <= '0';
                    output3 <= input;
                    counter <= counter + 1;                       
                when 3 =>
                    output4 <= input;
                    ready <= '1';
                when others => 
                    ready <= '0';                                        
            end case;                                                       
        end if;

   end process input_data_process; 
end;