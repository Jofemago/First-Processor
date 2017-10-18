
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity ALU is
    Port ( crs1 : in  STD_LOGIC_VECTOR (31 downto 0);
           mux : in  STD_LOGIC_VECTOR (31 downto 0);
           aluop : in  STD_LOGIC_VECTOR (5 downto 0);
           aluresult : out  STD_LOGIC_VECTOR (31 downto 0));
end ALU;

architecture Behavioral of ALU is

begin
	process (aluop,mux, crs1)
		begin
		
		case (aluop) is 
			when "000000" => -- equivale al op3 de la suma de enteros
				aluresult <= crs1 + mux  ;
			when "000001" => -- equivale al op3 del and para los enteros
				aluresult <= crs1 AND mux ;
			when "000101" =>-- equivale al and not para los enteros
				aluresult <= (crs1 AND (NOT mux));
	      when "000010" =>-- equivale al or para los enteros
	         aluresult <= crs1 OR mux ;
	      when "000110" => --equivale al or not para los enteros
	         aluresult <= NOT(crs1 OR mux);
	      when "000011" =>--equivale al xor  para los enteros
	         aluresult <= crs1 XOR mux ;
	      when "000111" =>--equivale al Xnor para los enteros
	         aluresult <= crs1 XNOR mux ;
			when "000100" => -- equivale al op3 de la resta de enteros
				aluresult <= crs1 - mux ;

			when others =>
				aluresult <= "00000000000000000000000000000000";
   end case;
		
		
	end process;


end Behavioral;

