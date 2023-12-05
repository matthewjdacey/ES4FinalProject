library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity gravity is
port(
	update: in std_logic;
	reset: in std_logic;
	jump: in std_logic;
	gamestate : in std_logic;
	position: out unsigned(9 downto 0)
);
end;

architecture synth of gravity is

	signal velocity: signed(15 downto 0) := "0000000000000000";
	signal dt: signed(23 downto 0) := "000000000000000000000000";
	signal pos: signed(23 downto 0) := "000000000000000000000000";
	signal intposition : unsigned(9 downto 0);
	
	signal was_jump : std_logic := '0';
	
	type state is (ALIVE, DEAD);
	signal s : state := DEAD;
begin
	process (update, gamestate) begin
		if rising_edge(update) then
			
			case s is 
				when DEAD =>
					if gamestate = '0' then
						s <= ALIVE;
					else 
						s <= DEAD;
					end if;
				when ALIVE =>
					if gamestate = '1' then
						s <= DEAD;
					else 
						s <= ALIVE;
					end if;
				when others => s <= DEAD;
			end case;
					
			if intposition > 10d"480" then
				pos <= 24d"0";
				velocity <= 16d"0";
			elsif velocity > 16d"1024" then
				velocity <= 16d"1024";
			else
				velocity <= velocity + 16d"32";
			end if;
			
			if jump and not was_jump then
				was_jump <= '1';
				velocity <= 16d"0" - 16d"512";
			elsif jump and was_jump then
				was_jump <= '1';
			else
				was_jump <= '0';
			end if;
			
			dt <= velocity * 8d"50";
			
			-- position is y = 200 to start the game
			pos <= "000011001000000000000000" when s = DEAD else pos + dt;

		end if;
	end process;
	

	position <= intposition;
	intposition <= unsigned(pos(21 downto 12));
end;
