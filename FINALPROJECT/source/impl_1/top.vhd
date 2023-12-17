library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is
	port(
		clk : in std_logic;
		output_freq : out std_logic;
		HSYNC : out std_logic := '1';
		VSYNC : out std_logic := '1';
		rgb : out std_logic_vector(5 downto 0);
		nes_data : in std_logic;
		nes_latch : out std_logic;
		nes_clk : out std_logic;
		leds : out std_logic_vector(7 downto 0);
		tens : out std_logic_vector(4 downto 0); 
		scoreout : out std_logic_vector(9 downto 0)
	);
end top;

architecture synth of top is

	component score is 
		port(
			gamestate : in std_logic;
			update : in std_logic;
			tower1xpos : in unsigned (9 downto 0);
			tower2xpos : in unsigned (9 downto 0);
			tower3xpos : in unsigned (9 downto 0);
			score : out unsigned (9 downto 0)
			);
	end component;

	component tower is
		generic(
			towerstart : integer := 0
		);
		port(
			update : in std_logic;
			gamestate : in std_logic;
			towerxpos : out unsigned(9 downto 0);
			towerypos : out unsigned(9 downto 0)
		);
	end component;
	

	component gravity is
		port(
		update: in std_logic;
		reset: in std_logic;
		jump: in std_logic;
		gamestate : in std_logic;
		position: out unsigned(9 downto 0)
	);
	end component;

	component mypll is
		port(
			ref_clk_i: in std_logic;
			rst_n_i: in std_logic;
			outcore_o: out std_logic;
			outglobal_o: out std_logic
		);
	end component;
	
	component vga is
		port(
			clk : in std_logic;
			gameclk : out std_logic;
			HSYNC : out std_logic := '1';
			VSYNC : out std_logic := '1';
			valid : out std_logic := '1';
			r : out unsigned(9 downto 0);
			c : out unsigned(9 downto 0)
		);
	end component;
	
	component nes is
	  port (
	    data : in std_logic;
	    NES_Latch   : out std_logic;
	    NES_Clock   : out std_logic;
	    output : out std_logic_vector(7 downto 0);
		clk : in std_logic
	  );
	end component;
	
	component gamestate is 
	port(
		update : in std_logic;
		startbutton : in std_logic;
		birdpos : in unsigned (9 downto 0);
		tower1xpos : in unsigned (9 downto 0);
		tower1ypos : in unsigned (9 downto 0);
		tower2xpos : in unsigned (9 downto 0);
		tower2ypos : in unsigned (9 downto 0);
		tower3xpos : unsigned (9 downto 0);
		tower3ypos : unsigned (9 downto 0);
		gameover : out std_logic
		);
	end component;
	
	component pattern_gen is
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
			
			tower3xpos : unsigned (9 downto 0);
			tower3ypos : unsigned (9 downto 0);

			score : in unsigned (9 downto 0); 
			
			tens : out std_logic_vector(4 downto 0); 
			
			rgb : out std_logic_vector(5 downto 0)
		);
	end component;
	
	component HSOSC is
	generic (CLKHF_DIV : String := "0b00");
	port(
		CLKHFPU : in std_logic := 'X';
		CLKHFEN : in std_logic := 'X';
		CLKHF : out std_logic := 'X'
	);
	end component;
	
	signal gameclk : std_logic;
	signal resetdisplay : std_logic := '1'; 
	signal vga_clk : std_logic;
	signal valid : std_logic;
	signal row : unsigned (9 downto 0);
	signal column : unsigned (9 downto 0);
	signal gameover : std_logic := '1';
	
	signal tower1xpos : unsigned (9 downto 0);
	signal tower1ypos : unsigned (9 downto 0 );
	signal tower2xpos : unsigned (9 downto 0);
	signal tower2ypos : unsigned (9 downto 0);
	signal tower3xpos : unsigned (9 downto 0);
	signal tower3ypos : unsigned (9 downto 0);
	
	signal birdpos : unsigned(9 downto 0);
	signal clkhf : std_logic;
	signal gamescore : unsigned(9 downto 0);
	
begin
    osc : HSOSC port map (CLKHFPU => '1', CLKHFEN => '1', CLKHF => clkhf);
	scoreout <= std_logic_vector(gamescore);


	mypll_1 : mypll
	port map(
		ref_clk_i => clk,
		rst_n_i => resetdisplay,
		outcore_o => output_freq,
		outglobal_o => vga_clk
	);
	
	vga_1 : vga
	port map(
		clk => vga_clk,
		gameclk => gameclk,
		HSYNC => HSYNC,
		VSYNC => VSYNC,
		valid => valid,
		r => row,
		c => column
	);
	
	gravity_1 : gravity
	port map(
		update => gameclk,
		reset => '0',
		jump => leds(7),
		gamestate => gameover,
		position => birdpos
	);
		
	tower_1 : tower
	generic map (towerstart => 0)
	port map(
		update => gameclk,
		gamestate => gameover,
		towerxpos => tower1xpos,
		towerypos => tower1ypos
	);
	
	tower_2 : tower
	generic map (towerstart => 46)
	port map(
		update => gameclk,
		gamestate => gameover,
		towerxpos => tower2xpos,
		towerypos => tower2ypos
	);
	
	tower_3 : tower
	generic map (towerstart => 92)
	port map(
		update => gameclk,
		gamestate => gameover,
		towerxpos => tower3xpos,
		towerypos => tower3ypos
	);
	
	pattern_gen_1 : pattern_gen 
	port map(
		clk => vga_clk,
		valid => valid,
		row => row,
		column => column,
		gamestate => gameover,
		birdpos => birdpos,
		tower1xpos => tower1xpos,
		tower1ypos => tower1ypos,
		tower2xpos => tower2xpos,
		tower2ypos => tower2ypos,
		tower3xpos => tower3xpos,
		tower3ypos => tower3ypos,
		score => gamescore,
		tens => tens,
		rgb => rgb
	);
	
	nes_1 : nes
	port map (
		data => nes_data,
		NES_Latch => nes_latch,
		NES_Clock => nes_clk,
		output=>leds,
		clk => clkhf
	);
	
	gamestate_1 : gamestate
	port map (
		update => gameclk,
		startbutton => leds(4),
		birdpos => birdpos,
		tower1xpos => tower1xpos,
		tower1ypos => tower1ypos,
		tower2xpos => tower2xpos,
		tower2ypos => tower2ypos,
		tower3xpos => tower3xpos,
		tower3ypos => tower3ypos,
		gameover => gameover
		);
		
	score_1 : score
	port map(
		gamestate => gameover,
		update => gameclk,
		tower1xpos => tower1xpos,
		tower2xpos => tower2xpos,
		tower3xpos => tower3xpos,
		score => gamescore
	);
		
	
end;