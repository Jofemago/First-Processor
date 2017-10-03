
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY ALU_tb IS
END ALU_tb;
 
ARCHITECTURE behavior OF ALU_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         crs1 : IN  std_logic_vector(31 downto 0);
         mux : IN  std_logic_vector(31 downto 0);
         aluop : IN  std_logic_vector(5 downto 0);
         aluresult : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal crs1 : std_logic_vector(31 downto 0) := (others => '0');
   signal mux : std_logic_vector(31 downto 0) := (others => '0');
   signal aluop : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal aluresult : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          crs1 => crs1,
          mux => mux,
          aluop => aluop,
          aluresult => aluresult
        );


 

   -- Stimulus process
   stim_proc: process
   begin		

		
		aluop <=  "000000"; -- suma
		mux <= "00000000000000000000000000000001"  ;
		crs1 <=  "00000000000000000000000000000001"  ;
		wait for 10 ns;
		
		aluop <=  "000001"; -- and
		mux <= "10000000000000000000000000000001"  ;
		crs1 <=  "10000000000000001000000000000001" ;
		wait for 10 ns;
		
		aluop <= "000101" ; -- nand
		mux <= "00000000000000000000000000000111"  ;
		crs1 <=  "00000000000000000000000000000111"  ;
		wait for 10 ns;
		
		aluop <= "000010"  ; -- or
		mux <= "00000000001000000000000010000000"  ;
		crs1 <=  "01000000000000010000000001000000"  ;
		wait for 10 ns;
		aluop <= "000110" ; -- nor
		mux <= "00000000000000000000000000110000"  ;
		crs1 <=  "00000000000000000000000000000000" ;
		wait for 10 ns;
		aluop <= "000011" ; -- xor
		mux <= "00000000000000000000000000000101"  ;
		crs1 <=  "00000000000000000000000000000000" ;
		wait for 10 ns;
		
		aluop <= "000111" ; -- xnor
		mux <= "00000000000000000000000000000000"  ;
		crs1 <=  "00000000000000000000000000000101" ;
		wait for 10 ns;
		
		aluop <= "000100" ; -- sub
		mux <= "00000000000000000000000000000001"  ;
		crs1 <=  "00000000000000000000000000000001" ;
		wait for 10 ns;
		

   end process;

END;
