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
		leds : out std_logic_vector(7 downto 0)
	);
end top;

architecture synth of top is

	component tower is 
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
	    output : out std_logic_vector(7 downto 0)
	  );
	end component;
	
	component gamestate is 
	port(
		startbutton : in std_logic;
		birdpos : in unsigned (9 downto 0);
		towerxpos : in unsigned (9 downto 0);
		towerypos : in unsigned (9 downto 0);
		gameover : out std_logic
		);
	end component;
	
	component pattern_gen is
		port(
			valid : in std_logic;
			row : in unsigned(9 downto 0);
			column : in unsigned(9 downto 0);
			gamestate : in std_logic;
			birdpos : in unsigned(9 downto 0);
			towerxpos : in unsigned(9 downto 0);
			towerypos :in unsigned(9 downto 0);
			rgb : out std_logic_vector(5 downto 0)
			
		);
	end component;
	
	signal gameclk : std_logic;
	signal resetdisplay : std_logic := '1'; 
	signal vga_clk : std_logic;
	signal valid : std_logic;
	signal row : unsigned (9 downto 0);
	signal column : unsigned (9 downto 0);
	signal gameover : std_logic := '1';
	signal towerxpos : unsigned (9 downto 0) := "1010110010";
	signal towerypos : unsigned (9 downto 0 ) := "0011001000";
	signal birdpos : unsigned(9 downto 0);
	
begin
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
	port map(
		update => gameclk,
		gamestate => gameover,
		towerxpos => towerxpos,
		towerypos => towerypos
	);
	
	pattern_gen_1 : pattern_gen 
	port map(
		valid => valid,
		row => row,
		column => column,
		gamestate => gameover,
		birdpos => birdpos,
		towerxpos => towerxpos,
		towerypos => towerypos,
		rgb => rgb
	);
	
	nes_1 : nes
	port map (
		data => nes_data,
		NES_Latch => nes_latch,
		NES_Clock => nes_clk,
		output=>leds
	);
	
	gamestate_1 : gamestate
	port map (
		startbutton => leds(4),
		birdpos => birdpos,
		towerxpos => towerxpos,
		towerypos => towerypos,
		gameover => gameover
		);
		
	
end;