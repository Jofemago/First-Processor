
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY RegisterFile_tb IS
END RegisterFile_tb;
 
ARCHITECTURE behavior OF RegisterFile_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RegisterFile
    PORT(
         rs1 : IN  std_logic_vector(4 downto 0);
         rs2 : IN  std_logic_vector(4 downto 0);
         rd : IN  std_logic_vector(4 downto 0);
         DtoWrite : IN  std_logic_vector(31 downto 0);
         rst : IN  std_logic;
         crs1 : OUT  std_logic_vector(31 downto 0);
         crs2 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal rs1 : std_logic_vector(4 downto 0) := (others => '0');
   signal rs2 : std_logic_vector(4 downto 0) := (others => '0');
   signal rd : std_logic_vector(4 downto 0) := (others => '0');
   signal DtoWrite : std_logic_vector(31 downto 0) := (others => '0');
	signal crs1 : std_logic_vector(31 downto 0) := (others => '0');
	signal crs2 : std_logic_vector(31 downto 0) := (others => '0');
   signal rst : std_logic := '0';

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RegisterFile PORT MAP (
          rs1 => rs1,
          rs2 => rs2,
          rd => rd,
          DtoWrite => DtoWrite,
          rst => rst,
          crs1 => crs1,
          crs2 => crs2
        );


 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		rs1 <= "00000";
		rs2 <="00000"; 
		rd <="00001";
		dToWrite <= "00000000000000000000000000000001";
		
		
		wait for 15 ns;
		rd <="00010";
		dToWrite <= "00000000000000000000000000000010";
		
		wait for 15 ns;
		rd <="00011";
		dToWrite <= "00000000000000000000000000000011";
		
		wait for 15 ns;
		rst <= '1';
--		rd <="00100";
--		dToWrite <= "00000000000000000000000000000100";
--		
--		wait for 15 ns;
--		rd <="00101";
--		dToWrite <= "00000000000000000000000000000101";
		
		wait for 15 ns;
		
		rd <= "00000";
		
		wait for 15 ns;
		
		rs1 <= "00000";
		rs2 <= "00001";
		wait for 15 ns;
		rs1 <= "00001";
		rs2 <= "00010";
		wait for 15 ns;
		rs1 <= "00010";
		rs2 <= "00011";
		wait for 15 ns;
		rs1 <= "00011";
		rs2 <= "00100";
		wait for 15 ns;
		rs1 <= "00100";
		rs2 <= "00101";
		wait for 15 ns;
		
		
		
		
		
    	

  

      -- insert stimulus here 

      wait;
   end process;

END;
