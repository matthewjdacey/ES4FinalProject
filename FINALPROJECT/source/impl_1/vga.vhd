library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity vga is
    port(
      clk : in std_logic;
	  gameclk : out std_logic;
      HSYNC : out std_logic;
      VSYNC : out std_logic;
      valid : out std_logic;
      r : out unsigned(9 downto 0);
      c : out unsigned(9 downto 0)
      );
end vga;

architecture synth of vga is
	signal column : unsigned(9 downto 0) := "0000000000";
	signal row : unsigned(9 downto 0) := "0000000000";
	
begin

	r <= row;
	c <= column;
	
	process(clk) is begin
		if rising_edge(clk) then
			
			if (column < 480 and row < 640) then
				valid <= '1';
			else
				valid <= '0';
			end if;
			
			
			if (row > 659 and row < 756) then
				HSYNC <= '0';
			else
				HSYNC <= '1';
			end if;
			
			
			if (column > 490 and column < 493) then
				VSYNC <= '0';
				gameclk <= '0';
			else
				VSYNC <= '1';
				gameclk <= '1';
			end if;
			
			
			if (row = 799 and column = 524) then
				row <= "0000000000";
				column <= "0000000000";
			elsif (row = 799) then
				row <= "0000000000";
				column <= column + 1;
			else
				row <= row + 1;
			end if;
			
		end if;
	end process;
	
end;

