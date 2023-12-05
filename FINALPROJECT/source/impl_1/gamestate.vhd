library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity gamestate is 
	port(
		startbutton : in std_logic;
		birdpos : in unsigned (9 downto 0);
		tower1xpos : in unsigned (9 downto 0);
		tower1ypos : in unsigned (9 downto 0);
		tower2xpos : in unsigned (9 downto 0);
		tower2ypos : in unsigned (9 downto 0);
		gameover : out std_logic;
		update : in std_logic
		);
end gamestate;

architecture synth of gamestate is 

signal state, nextstate : std_logic := '1';

begin

	process (update) begin
		if rising_edge(update) then
			nextstate <= state;
		end if;
	end process;
	--gameover <= state;
	
	-- start playing the game when on game over screen and start button is pressed
	state <= '0' when (state = '1' and startbutton = '1') else
	
	-- stop playing when game is not over and tower x position overlaps bird position and bird hitbox collides w/ top or bottom of tower or ground
	
	'1' when state = '0' and (
			birdpos > 430 or birdpos < 0 or (
				(tower1xpos > 295 and tower1xpos < 395)
				and (birdpos + 50 > tower1ypos + 150 or birdpos < tower1ypos)
			)
	        or (
				(tower2xpos > 295 and tower2xpos < 395)
				and (birdpos + 50 > tower2ypos + 150 or birdpos < tower2ypos)
		    ))
	else
	-- keep state the same	
	state;
	
end;