
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;



entity Direccionador is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           instrucciones : out  STD_LOGIC_VECTOR (31 downto 0));
end Direccionador;

architecture Behavioral of Direccionador is

	COMPONENT InstruccionMemory
	PORT(
		address : IN std_logic_vector(31 downto 0);
		rst : IN std_logic;          
		instruction : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT regis
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		datain : IN std_logic_vector(31 downto 0);          
		dataout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT sumador32bits
	PORT(
		datainA : IN std_logic_vector(31 downto 0);
		datainB : IN std_logic_vector(31 downto 0);          
		Salida : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;



signal cable1: std_logic_vector(31 downto 0):="00000000000000000000000000000000" ;
signal cable2: std_logic_vector(31 downto 0);
signal cable3: std_logic_vector(31 downto 0);


begin

	Inst_InstruccionMemory: InstruccionMemory PORT MAP(
		address => cable1,
		rst => rst ,
		instruction => instrucciones
	);

	npc: regis PORT MAP(
		clk => clk,
		rst => rst,
		datain => cable3,
		dataout => cable2
	);
	
	pc: regis PORT MAP(
		clk => clk,
		rst => rst,
		datain => cable2,
		dataout => cable1 
	);

	Inst_sumador32bits: sumador32bits PORT MAP(
		datainA => "00000000000000000000000000000001",
		datainB => cable1,
		Salida => cable3
	);
	
	
end Behavioral;

