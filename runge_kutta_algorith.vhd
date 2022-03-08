library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;
use ieee.fixed_float_types.all;

entity runge_kutta_algorith is
    port (
        clk      : in  std_logic;
        input_alg_1   : in  real;
        input_alg_2   : in  real;
        step     : in  sfixed(16 downto -15);
        result_alg   : real);
end;

architecture structural of runge_kutta_algorith is

signal signal_k1 : sfixed(16 downto -15);
signal signal_k2 : sfixed(16 downto -15);
signal signal_k2_aux : sfixed(32 downto -31);
signal signal_k3 : sfixed(16 downto -15);
signal signal_k3_aux : sfixed(32 downto -31);
signal signal_k4 : sfixed(16 downto -15);
signal signal_k : sfixed(18 downto -15);
signal signal_input1_fixed : sfixed(16 downto -15);
signal signal_input2_fixed : sfixed(16 downto -15);
signal signal_result_alg_sfixed : sfixed(19 downto -15);
CONSTANT mult_2 : sfixed(16 downto -15) := "00000000000000010000000000000000";

component runge_kutta_k1 is
    port(
        clk         : in  std_logic;
        input1      : in  sfixed(16 downto -15);
        input2      : in  sfixed(16 downto -15);       
        step        : in  sfixed(16 downto -15);      
        k1_output   : out  sfixed(16 downto -15);
        ready       : out  std_logic
    );
end component;

component runge_kutta_k2 is
    port(
        clk        : in  std_logic;
        input1     : in  sfixed(16 downto -15);
        input2     : in  sfixed(16 downto -15); 
        input_k1   : in  sfixed(16 downto -15);
        step       : in  sfixed(16 downto -15);                                      
        k2_output  : out  sfixed(16 downto -15);
        ready      : out  std_logic 
    );
end component;

component runge_kutta_k3 is
    port(
        clk        : in  std_logic;
        input1     : in  sfixed(16 downto -15);
        input2     : in  sfixed(16 downto -15);
        input_k2   : in  sfixed(16 downto -15);
        step       : in  sfixed(16 downto -15);          
        k3_output  : out  sfixed(16 downto -15);
        ready      : out  std_logic
    );
end component;

component runge_kutta_k4 is
    port(
        clk        : in  std_logic;
        input1     : in  sfixed(16 downto -15);
        input2     : in  sfixed(16 downto -15);        
        input_k3   : in  sfixed(16 downto -15);
        step       : in  sfixed(16 downto -15);                           
        k4_output  : out  sfixed(16 downto -15);
        ready      : out  std_logic
    );
end component;

component decoder is
    port(
        clk          : in  std_logic;
        input1_real  : in  real ;
        input2_real  : in  real ;
        input1_fixed : out sfixed(16 downto -15);
        input2_fixed : out sfixed(16 downto -15)
    );
end component;

component Multiplier32Bits is
    port(
        CLK: in std_logic;
        operand1: in sfixed(16 downto -15);
        operand2: in sfixed(16 downto -15);
        mult_result: out sfixed(32 downto -31)
    );
end component;

begin

  dec: decoder port map (clk => clk, input1_real => input_alg_1,input2_real => input_alg_2, input1_fixed => signal_input1_fixed ,input2_fixed => signal_input2_fixed); 
  k1: runge_kutta_k1 port map (clk => clk, input1 => signal_input1_fixed,input2 => signal_input2_fixed, step => step,k1_output => signal_k1);
  k2: runge_kutta_k2 port map (clk => clk, input1 => signal_input1_fixed,input2 => signal_input2_fixed, input_k1 => signal_k1 ,step => step,k2_output => signal_k2);
  k3: runge_kutta_k3 port map (clk => clk, input1 => signal_input1_fixed,input2 => signal_input2_fixed, input_k2 => signal_k2 ,step => step,k3_output => signal_k3);
  k4: runge_kutta_k4 port map (clk => clk, input1 => signal_input1_fixed,input2 => signal_input2_fixed, input_k3 => signal_k3 ,step => step,k4_output => signal_k4);  
  mult1   : Multiplier32Bits port map (CLK => clk, operand1 => signal_k2,operand2 => mult_2,mult_result => signal_k2_aux);
  mult2   : Multiplier32Bits port map (CLK => clk, operand1 => signal_k3,operand2 => mult_2,mult_result => signal_k3_aux);
    main_process : process(clk)
    begin

        if(rising_edge(clk)) then
            signal_k <= signal_k1(16 downto -15) + signal_k2_aux(16 downto -15) + signal_k3_aux(16 downto -15) + signal_k4(16 downto -15);
            signal_result_alg_sfixed <= signal_k1 + signal_k2 + signal_k3 + signal_k4;
            --result_alg <= to_real(signal_result_alg_sfixed); 

        end if;
   end process main_process; 

end architecture;

