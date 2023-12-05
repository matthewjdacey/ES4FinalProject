library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity gamestate is 
	port(
		startbutton : in std_logic;
		birdpos : in unsigned (9 downto 0);
		towerxpos : in unsigned (9 downto 0);
		towerypos : in unsigned (9 downto 0);
		gameover : out std_logic
		);
end gamestate;

architecture synth of gamestate is 

signal state : std_logic := '1';

begin
	gameover <= state;
	
	-- start playing the game when on game over screen and start button is pressed
	state <= '0' when state = '1' and startbutton = '1' else
	
	-- stop playing when game is not over and tower x position overlaps bird position and bird hitbox collides w/ top or bottom of tower or ground
	'1' when state = '0' and (birdpos > 430 or birdpos < 0 or ((towerxpos > 295 and towerxpos < 395) and (birdpos + 50 > towerypos + 150 or birdpos < towerypos))) else
	-- keep state the same	
	state;
	
end;