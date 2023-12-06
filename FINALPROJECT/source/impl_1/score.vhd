library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity score is 
	port(
		gamestate : in std_logic;
		update : in std_logic;
		tower1xpos : in unsigned (9 downto 0);
		tower2xpos : in unsigned (9 downto 0);
		tower3xpos : in unsigned (9 downto 0);
		score : out unsigned (9 downto 0)
		);
end entity;


architecture synth of score is 

type state is (ALIVE, DEAD);
signal s : state := DEAD;
signal scoresig : unsigned (9 downto 0) := 10d"0";

begin 

	s <= ALIVE when gamestate = '0' else DEAD;
	score <= scoresig;
	process(update) is begin
		if rising_edge(update) then
			scoresig <= scoresig + 10d"1" when s = ALIVE and (tower1xpos = 290 or tower2xpos = 290 or tower3xpos = 290) else 
						-- reset score to zero when first tower is moving and other towers aren't (on game start)
						10d"0" when (tower1xpos /= 690 and tower2xpos = 690 and tower3xpos = 690) else
						scoresig;

		end if;
	end process;
end architecture;