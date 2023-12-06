library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pattern_gen is
	port(
		valid : in std_logic;
		row : in unsigned(9 downto 0);
		column : in unsigned(9 downto 0);
		gamestate : in std_logic;
		
		birdpos : in unsigned(9 downto 0);
		tower1xpos : in unsigned(9 downto 0);
		tower1ypos : in unsigned(9 downto 0);
		
		tower2xpos : in unsigned(9 downto 0);
		tower2ypos : in unsigned(9 downto 0);
		
		tower3xpos : in unsigned(9 downto 0);
		tower3ypos : in unsigned(9 downto 0);
		
		score : in unsigned (9 downto 0); 
		
		rgb : out std_logic_vector(5 downto 0)
	);
end pattern_gen;

architecture synth of pattern_gen is

begin
	rgb <= "000000" when valid = '0' else
		   -- game over screen, draw something here
		   "111111" when gamestate = '1' and column > 100 and column < 200 and row > 100 and row(0) = '0' and row(1) = '0' and row < (4 * score + 100) else
		   "101011" when gamestate = '1' else
		   -- bird position
		   "111111" when (row > 295 and row < 345) and column > birdpos and column < (birdpos + 50) else
		   "101010" when column > 470 else
		   -- tower position
		   "010000" when (((row < tower1xpos and (row > (tower1xpos - 50))) and tower1xpos >= 50) or (row < tower1xpos and tower1xpos < 50)) and (column < tower1ypos or column > (tower1ypos + 150)) else
		   "010000" when (((row < tower2xpos and (row > (tower2xpos - 50))) and tower2xpos >= 50) or (row < tower2xpos and tower2xpos < 50)) and (column < tower2ypos or column > (tower2ypos + 150)) else
		   "010000" when (((row < tower3xpos and (row > (tower3xpos - 50))) and tower3xpos >= 50) or (row < tower3xpos and tower3xpos < 50)) and (column < tower3ypos or column > (tower3ypos + 150)) else
		   
		   "011011";
end;
