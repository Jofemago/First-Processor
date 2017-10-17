
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

--int k = 6


entity InstruccionMemory is
    Port ( address : in  STD_LOGIC_VECTOR (31 downto 0);
           rst : in  STD_LOGIC;
           instruction : out  STD_LOGIC_VECTOR (31 downto 0));
end InstruccionMemory;

architecture syn of InstruccionMemory is
    type rom_type is array (0 to 63) of std_logic_vector (31 downto 0);                 
    signal ROM : rom_type:= ("10000010000100000010000000001000", "10000100000100000011111111111001",
										"10010000000000000100000000000010", "10010010000110000100000000000010",
										"10010100001010000100000000000010", "10010110001110000100000000000010",
										"10011000001000000100000000000010",
                            others => "00000000000000000000000000000000");                        
begin

    process (rst,Address)
    begin
        if (rst = '1') then
            
            instruction <=  "00000000000000000000000000000000"; 
--				Address =>  "00000000000000000000000000000000";  la salida se pone en 0 mientras reset es 1
-- pero cuando este valor es 0 vuelve y toma el actual del address.
			else
				instruction <= ROM(conv_integer(address));
            
        end if;
    end process;


end syn;

