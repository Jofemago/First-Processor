
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;



entity InstruccionMemory is
    Port ( address : in  STD_LOGIC_VECTOR (31 downto 0);
           rst : in  STD_LOGIC;
           instruction : out  STD_LOGIC_VECTOR (31 downto 0));
end InstruccionMemory;

architecture syn of InstruccionMemory is
    type rom_type is array (0 to 63) of std_logic_vector (31 downto 0);                 
    signal ROM : rom_type:= ("10100000000100000010000000000100", "10100010000100000011111111111010",
									  "10100100000001000000000000010001", "10010000000001001000000000101011",
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

