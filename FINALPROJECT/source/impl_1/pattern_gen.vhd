library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pattern_gen is
	port(
		valid : in std_logic;
		row : in unsigned(9 downto 0);
		column : in unsigned(9 downto 0);
		
		birdpos : in unsigned(9 downto 0);
		towerxpos : in unsigned(9 downto 0);
		towerypos : in unsigned(9 downto 0);
		
		rgb : out std_logic_vector(5 downto 0)
	);
end pattern_gen;

architecture synth of pattern_gen is

begin
	rgb <= "000000" when valid = '0' else 
		   -- bird position
		   "111111" when row < 50 and column > birdpos and column < (birdpos + 50) else
		   -- tower position
		   "111111" when (((row < towerxpos and (row > (towerxpos - 50))) and towerxpos >= 50) or (row < towerxpos and towerxpos < 50)) and (column < towerypos or column > (towerypos + 50)) else
		   "000000";
end;
