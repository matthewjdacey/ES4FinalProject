library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pattern_gen is
	port(
		clk : in std_logic;
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
		
		tens : out std_logic_vector(4 downto 0);
		
		rgb : out std_logic_vector(5 downto 0)
	);
end pattern_gen;

architecture synth of pattern_gen is

component jumbo is
        port (
                x : in unsigned(9 downto 0); -- 5bit for 32 pixel bird
                y : in unsigned(9 downto 0);
                rgb : out std_logic_vector(5 downto 0);
				clk : in std_logic
        );
end component;

component startscreen is
        port (
                x : in unsigned(9 downto 0); -- 5bit for 32 pixel bird
                y : in unsigned(9 downto 0);
                rgb : out std_logic_vector(5 downto 0);
				clk : in std_logic
        );
end component;

component digit is
        port (
				digit : in unsigned (4 downto 0);
                x : in unsigned(9 downto 0); -- 5bit for 32 pixel bird
                y : in unsigned(9 downto 0);
                rgb : out std_logic_vector(5 downto 0);
				clk : in std_logic
        );
end component;

signal player_color : std_logic_vector(5 downto 0);
signal start_color : std_logic_vector(5 downto 0);
signal digit1alive_color : std_logic_vector(5 downto 0);
signal digit2alive_color : std_logic_vector(5 downto 0);
signal digit1dead_color : std_logic_vector(5 downto 0);
signal digit2dead_color : std_logic_vector(5 downto 0);

signal player_x : unsigned(9 downto 0);
signal player_y : unsigned(9 downto 0);

signal scoreones : unsigned(4 downto 0); 
signal scoretens : unsigned(4 downto 0);
signal tensint : unsigned(16 downto 0); 

signal digitx : unsigned(9 downto 0);
signal digity : unsigned(9 downto 0);

signal bigx : unsigned(9 downto 0);
signal bigy : unsigned(9 downto 0);

signal digitposx : unsigned(9 downto 0);
signal digitposy : unsigned(9 downto 0);

begin

	player : jumbo port map(x => player_y, y=> player_x, rgb => player_color, clk=>clk);
	start_draw : startscreen port map (x => row, y => column, rgb => start_color, clk=>clk);
	digit1alive : digit port map (digit => scoretens, x => digitx, y => digity, rgb => digit1alive_color, clk=>clk);
	digit2alive : digit port map (digit => scoreones, x => digitx - 18, y => digity, rgb => digit2alive_color, clk=>clk);
	digit1dead : digit port map (digit => scoretens, x => digitx - 200, y => digity - 78, rgb => digit1dead_color, clk=>clk);
	digit2dead : digit port map (digit => scoreones, x => digitx - 217, y => digity - 78, rgb => digit2dead_color, clk=>clk);
	
	
	
	
	
	scoreones <= score mod 5d"10";
	tensint <= score * 7d"52";
	scoretens <= tensint(13 downto 9);
	
	tens <= std_logic_vector(scoretens);
	
	process(clk) is begin
		if rising_edge(clk) then
			player_x <= column - birdpos;
			player_y <= row - 10d"295";
			
			bigx <= "0" & row(9 downto 1);
			bigy <= "0" & column(9 downto 1	);
			digitx <= bigx when gamestate = '1' else row;
			digity <= bigy when gamestate = '1' else column;
			
			rgb <= "000000" when valid = '0' else
				digit1alive_color when gamestate = '0' and (row < 16 and column < 20) and (digit1alive_color = "111111") else
				digit2alive_color when gamestate = '0' and (column < 20 and row < 35 and row > 18) and (digit2alive_color = "111111") else
				digit1dead_color when gamestate = '1'  and (column > 150 and column < 200 and row < 432 and row > 400) and (digit1dead_color = "111111") else
				digit2dead_color when gamestate = '1' and (column > 150 and column < 200 and row < 466 and row > 434) and (digit2dead_color = "111111") else
				-- game over screen, draw something here
				--"111111" when gamestate = '1' and column > 100 and column < 200 and row > 100 and row(0) = '0' and row(1) = '0' and row < (4 * score + 100) else
				start_color when gamestate = '1' else
				-- bird position
				player_color when (row > 295 and row < 345) and column > birdpos and column < (birdpos + 26) else
				"101010" when column > 470 else
				-- tower position
				"010000" when (((row < tower1xpos and (row > (tower1xpos - 50))) and tower1xpos >= 50) or (row < tower1xpos and tower1xpos < 50)) and (column < tower1ypos or column > (tower1ypos + 150)) else
				"010000" when (((row < tower2xpos and (row > (tower2xpos - 50))) and tower2xpos >= 50) or (row < tower2xpos and tower2xpos < 50)) and (column < tower2ypos or column > (tower2ypos + 150)) else
				"010000" when (((row < tower3xpos and (row > (tower3xpos - 50))) and tower3xpos >= 50) or (row < tower3xpos and tower3xpos < 50)) and (column < tower3ypos or column > (tower3ypos + 150)) else
				"011011";
		end if;
	end process;
end;
