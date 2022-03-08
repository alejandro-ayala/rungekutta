library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity runge_kutta_algorith is
    generic(
       N         : integer := 32);
    port (
        clk      : in  std_logic;
        input1   : in  signed(N-1 downto 0);
        input2   : in  signed(N-1 downto 0);
        step     : in  signed(N-1 downto 0);
        result_alg   : out signed(2*N-1 downto 0));
end;

architecture structural of runge_kutta_algorith is

signal signal_k1 : signed(N-1 downto 0);
signal signal_k2 : signed(N-1 downto 0);
signal signal_k3 : signed(N-1 downto 0);
signal signal_k4 : signed(N-1 downto 0);

component runge_kutta_k1 is
    port(
        clk         : in  std_logic;
        input1      : in  signed(N-1 downto 0);
        input2      : in  signed(N-1 downto 0);        
        step        : in  signed(N-1 downto 0);                
        k1_output   : out  signed(N-1 downto 0);
        ready       : out  std_logic
    );
end component;

component runge_kutta_k2 is
    port(
        clk        : in  std_logic;
        input1     : in  signed(N-1 downto 0);
        input2     : in  signed(N-1 downto 0);        
        input_k1   : in  signed(N-1 downto 0); 
        step       : in  signed(N-1 downto 0);                                       
        k2_output  : out  signed(N-1 downto 0);
        ready      : out  std_logic 
    );
end component;

component runge_kutta_k3 is
    port(
        clk        : in  std_logic;
        input1     : in  signed(N-1 downto 0);
        input2     : in  signed(N-1 downto 0);  
        input_k2   : in  signed(N-1 downto 0); 
        step       : in  signed(N-1 downto 0);                
        k3_output  : out  signed(N-1 downto 0);
        ready      : out  std_logic
    );
end component;

component runge_kutta_k4 is
    port(
        clk        : in  std_logic;
        input1      : in  signed(N-1 downto 0);
        input2      : in  signed(N-1 downto 0);        
        input_k3   : in  signed(N-1 downto 0);  
        step       : in  signed(N-1 downto 0);                              
        k4_output  : out  signed(N-1 downto 0);
        ready      : out  std_logic
    );
end component;


begin
  k1: runge_kutta_k1 port map (clk => clk, input1 => input1,input2 => input2, step => step,k1_output => signal_k1);
  k2: runge_kutta_k2 port map (clk => clk, input1 => input1,input2 => input2, input_k1 => signal_k1 ,step => step,k2_output => signal_k2);
  k3: runge_kutta_k3 port map (clk => clk, input1 => input1,input2 => input2, input_k2 => signal_k2 ,step => step,k3_output => signal_k3);
  k4: runge_kutta_k4 port map (clk => clk, input1 => input1,input2 => input2, input_k3 => signal_k3 ,step => step,k4_output => signal_k4);  

    main_process : process(clk)
    begin

        if(rising_edge(clk)) then
            result_alg <= signal_k1 + signal_k2 + signal_k3 + signal_k4;

        end if;
   end process main_process; 

end architecture;

