
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity mux01 is
    Port ( crs2 : in  STD_LOGIC_VECTOR (31 downto 0);
           i : in  STD_LOGIC;
           sevout : in  STD_LOGIC_VECTOR (31 downto 0);
           muxout : out  STD_LOGIC_VECTOR (31 downto 0));
end mux01;

architecture Behavioral of mux01 is

begin
	process (i)
		begin
		if (i = '1') then
			muxout <= sevout;
		else
			muxout <= crs2;
		end if;
	end process;
end Behavioral;

