library ieee;
use ieee.std_logic_1164.all;

entity main is
    Port ( Y : in  STD_LOGIC_VECTOR (7 downto 0);
           X : in  STD_LOGIC_VECTOR (7 downto 0);
           P : out  STD_LOGIC_VECTOR (15 downto 0));
end main;

architecture Behavioral of main is
function maj (i1,i2,i3 : std_logic) return std_logic is 
begin 
	return ((i1 and i2) or (i1 and i3) or (i2 and i3));
end maj;
begin -------------------
process (X,Y)
type arreglo8x8 is array (0 to 7) of std_logic_vector (7 downto 0);
variable componentes: arreglo8x8; --bits de componente 
variable suma: arreglo8x8; --bits de suma del sumador completo
variable sumador: arreglo8x8;	--bits de salida de acarreo del sumador completo 
variable ras,rac: std_logic_vector (7 downto 0); --suma de sumador 
begin --inicia proceso
	for i in 0 to 7 loop for j in 0 to 7 loop 
		componentes(i)(j) := y(i) and X(j); --calculo de producto
	end loop; end loop;
	for j in 0 to 7 loop 
		suma(0)(j) := componentes(0)(j);	--inicializar primer renglon 
		sumador(0)(j) := '0';		--sumadores 
	end loop;	
	for i in 1 to 7 loop  --hacer todos los sumadores completos excepto el ultimo renglon
		for j in 0 to 6 loop 
		suma(i)(j) := componentes(i)(j) xor suma(i-1)(j+1) xor sumador(i-1)(j);
		sumador(i)(j) := maj(componentes(i)(j), suma(i-1)(j+1),sumador(i-1)(j));
		suma(i)(7) := componentes (i)(7);  -- senal de suma del sumador virtual que esta en el extremo izquierdo 
		end loop;  
		
		
	end loop;
	rac(0) := '0';
	for i in 0 to 6 loop  --sumador  final 
		ras(i) := suma(7)(i+1) xor sumador(7)(i) xor rac(i);
		rac(i+1) := maj(suma(7)(i+1),sumador(7)(i),rac(i));
	end loop;
	for i in 0 to 7 loop 
		p(i) <= suma(i)(0);  --primeros 8 bits de producto de las sumas del sumador 
	end loop;
	for i in 8 to 14 loop 
		p(i) <= ras(i-8); --siguientes 7 bits de la sumas del sumador 
	end loop;
	p(15) <= rac(7); --ultimo bit del acarreo del sumador en rizo

end process;
end Behavioral;

