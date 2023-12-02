library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tower is 
	port(
		update : in std_logic;
		towerxpos : out unsigned(9 downto 0);
		towerypos : out unsigned(9 downto 0)
	);
end entity;

architecture synth of tower is 

signal xpos : unsigned (9 downto 0);
signal counter : unsigned(9 downto 0) := "1010010011";

begin
	towerxpos <= xpos;
	towerypos <= 50 + (counter mod 280);
	
	process(update) is begin
		
		if rising_edge(update) then
			
			if (xpos = 0) then
				xpos <= "1010110010";
				-- add a "random" big number and mod it to simulate randomness
				counter <= counter + 2435;
				
			else
				xpos <= xpos - 2;
			end if;
		end if;
	end process;
end architecture;