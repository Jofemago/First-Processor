
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY ControlUnite_tb IS
END ControlUnite_tb;
 
ARCHITECTURE behavior OF ControlUnite_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ControlUnit
    PORT(
         op : IN  std_logic_vector(1 downto 0);
         op3 : IN  std_logic_vector(5 downto 0);
         aluop : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal op : std_logic_vector(1 downto 0) := (others => '0');
   signal op3 : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal aluop : std_logic_vector(5 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ControlUnit PORT MAP (
          op => op,
          op3 => op3,
          aluop => aluop
        );
		  
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 10 ns;	
		op3 <= "100000";
		wait for 10 ns;
		op <= "01";
		op3 <= "100000";
		wait for 10 ns;
		op <= "10";
		op3 <= "110000";
		wait for 10 ns;
		op <= "00";
		op3 <= "000000";


      -- insert stimulus here 

      wait;
   end process;

END;
