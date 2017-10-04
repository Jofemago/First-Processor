
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity CPU is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           aluresult : out  STD_LOGIC_VECTOR (31 downto 0));
end CPU;

architecture Behavioral of CPU is

	
	
	COMPONENT sumador32bits
	PORT(
		datainA : IN std_logic_vector(31 downto 0);
		datainB : IN std_logic_vector(31 downto 0);          
		Salida : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;



	COMPONENT regis -- program counters
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		datain : IN std_logic_vector(31 downto 0);          
		dataout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
		COMPONENT InstruccionMemory
	PORT(
		address : IN std_logic_vector(31 downto 0);
		rst : IN std_logic;          
		instruction : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT ControlUnit
	PORT(
		op : IN std_logic_vector(1 downto 0);
		op3 : IN std_logic_vector(5 downto 0);          
		aluop : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
	COMPONENT RegisterFile
	PORT(
		rs1 : IN std_logic_vector(4 downto 0);
		rs2 : IN std_logic_vector(4 downto 0);
		rd : IN std_logic_vector(4 downto 0);
		DtoWrite : IN std_logic_vector(31 downto 0);
		rst : IN std_logic;          
		crs1 : OUT std_logic_vector(31 downto 0);
		crs2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT SEU
	PORT(
		imm13 : IN std_logic_vector(12 downto 0);          
		seuout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
		COMPONENT mux01
	PORT(
		crs2 : IN std_logic_vector(31 downto 0);
		i : IN std_logic;
		seuin : IN std_logic_vector(31 downto 0);          
		muxout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT ALU
	PORT(
		crs1 : IN std_logic_vector(31 downto 0);
		mux : IN std_logic_vector(31 downto 0);
		aluop : IN std_logic_vector(5 downto 0);          
		aluresult : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;






signal auxpcs : std_logic_vector(31 downto 0); -- conect el pc con el npc
signal auxpcsumim : std_logic_vector(31 downto 0); -- conecta al pc con el sumador y el instruccion memory
signal auxsumnpc : std_logic_vector(31 downto 0); -- conecta el sumador al npc
signal auxinsIM : std_logic_vector(31 downto 0); -- sale del instruccion memory y conecta todos los modulos de ls siguientes señales


	signal auxop : std_logic_vector(1 downto 0) := auxinsIM(31 downto 30); -- conecta bits(31,30) del IM con Control_unit
	signal auxop3 : std_logic_vector(5 downto 0) := auxinsIM(24 downto 19); -- conecta bits(24,19) del IM con Control_unit
	signal auxrs1 : std_logic_vector(4 downto 0) := auxinsIM(18 downto 14); -- conecta bits(18,14) del IM con con el rs1 del registerfile
	signal auxrs2 : std_logic_vector(4 downto 0) := auxinsIM(4 downto 0);-- conecta bits(4,0) del IM con el rs2 del registerfile
	signal auxrd : std_logic_vector(4 downto 0) := auxinsIM(29 downto 25);-- conecta bits(29,25) del IM con el rd del registerfile
	signal auxi : std_logic := auxinsIM(13);-- conecta bit 13 del IM con el multiplexor
	signal auximm3 : std_logic_vector(12 downto 0) := auxinsIM(12 downto 0);-- conecta bits(12,0) del IM con el seu
	

signal auxcontalu : std_logic_vector(5 downto 0); -- conecta la alu con unidad de control
signal auxcrs1 : std_logic_vector(31 downto 0); -- conecta la salida del crs1 del RF a la alu
signal auxcrs2 : std_logic_vector(31 downto 0);-- conecta la salida del crs2 del RF al multiplexor
signal auxmuxalu : std_logic_vector(31 downto 0); -- conecta el multiplexor a la alu
signal auxseumux : std_logic_vector(31 downto 0); -- conecta seu al mux para que este decida si pasa el crs2 o lo imm3

signal auxresult : std_logic_vector(31 downto 0); -- conecta el DrtoWrite del register file con la alu y adicionalmente entrega la salida de la CPU

begin



	SUMADOR: sumador32bits PORT MAP(
		datainA => "00000000000000000000000000000001",
		datainB => auxpcsumim,
		Salida =>  auxsumnpc
	);

	NPC: regis PORT MAP(
		clk => clk,
		rst => rst,
		datain =>auxsumnpc ,
		dataout => auxpcs
	);

	PC: regis PORT MAP(
		clk => clk,
		rst => rst,
		datain => auxpcs,
		dataout => auxpcsumim
	);
	
		IM: InstruccionMemory PORT MAP(
		address => auxpcsumim,
		rst => rst,
		instruction => auxinsIM
	);
	
	
		CU: ControlUnit PORT MAP( -- controlunit
		op => auxop,
		op3 => auxop3,
		aluop => auxcontalu
	);
	
		RegisterF: RegisterFile PORT MAP( -- register file
		rs1 => auxrs1,
		rs2 => auxrs2,
		rd =>  auxrd,
		DtoWrite => auxresult,
		rst => rst,
		crs1 => auxcrs1,
		crs2 => auxcrs2
	);
	
	ISEU: SEU PORT MAP(-- unidad de extension de signo
		imm13 => auximm3,
		seuout => auxseumux
	);

	MULTIPLEXOR: mux01 PORT MAP(
		crs2 => auxcrs2,
		i => auxi,
		seuin => auxseumux,
		muxout => auxmuxalu
	);
	
	
	IALU: ALU PORT MAP(
		crs1 => auxcrs1,
		mux => auxmuxalu,
		aluop => auxcontalu,
		aluresult => auxresult
	);


 aluresult <= auxresult;
	


end Behavioral;

