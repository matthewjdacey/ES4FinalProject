library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity gamestate is 
	port(
		update : in std_logic;
		startbutton : in std_logic;
		birdpos : in unsigned (9 downto 0);
		tower1xpos : in unsigned (9 downto 0);
		tower1ypos : in unsigned (9 downto 0);
		tower2xpos : in unsigned (9 downto 0);
		tower2ypos : in unsigned (9 downto 0);
		tower3xpos : in unsigned (9 downto 0);
		tower3ypos : in unsigned (9 downto 0);
		gameover : out std_logic
		);
end gamestate;

architecture synth of gamestate is

type States is (ALIVE, DEAD);
signal state, nextstate : States := DEAD;

begin
	gameover <= '1' when state = DEAD else '0';
	
	process(update) begin
        if rising_edge(update) then
                state <= nextstate;
        end if;
	end process;
	
	process(all) begin
	-- TODO: add collision testing here
	case state is
			when DEAD => nextstate <= ALIVE when startbutton = '1' else DEAD;
			when ALIVE => nextstate <= DEAD when (birdpos > 430 or birdpos < 0 or ((tower1xpos > 300 and tower1xpos < 395) and (birdpos + 26 > tower1ypos + 150 or birdpos < tower1ypos)))
				else DEAD when (birdpos > 430 or birdpos < 0 or ((tower2xpos > 300 and tower2xpos < 395) and (birdpos + 26 > tower2ypos + 150 or birdpos < tower2ypos)))
				else DEAD when (birdpos > 430 or birdpos < 0 or ((tower3xpos > 300 and tower3xpos < 395) and (birdpos + 26 > tower3ypos + 150 or birdpos < tower3ypos)))
				else ALIVE;
			when others => nextstate <= state;
	end case;
	end process;
	
end;