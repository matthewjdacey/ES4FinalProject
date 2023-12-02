library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity gravity is
port(
	update: in std_logic;
	reset: in std_logic;
	jump: in std_logic;
	position: out unsigned(9 downto 0)
);
end;

architecture synth of gravity is

	signal velocity: signed(15 downto 0) := "0000000000000000";
	signal dt: unsigned(23 downto 0) := "000000000000000000000000";
	signal pos: unsigned(23 downto 0) := "000000000000000000000000";
	signal intposition : unsigned(9 downto 0);

begin
	process (update) begin
		if rising_edge(update) then
			if intposition > "0111100000" then
				pos <= "0000000000000000000000000";
				velocity <= "00000000000000000";
			elsif jump = '1' then
				velocity <= "1111110000000000";
			elsif velocity > "0000010000000000" then
				velocity <= "0000010000000000";
			else
				velocity <= velocity + "000000000100000";
			end if;
			
			dt <= "00000000" + unsigned(velocity) * "00010000";
			pos <= pos + dt;

		end if;
	end process;
	

	position <= intposition;
	intposition <= pos(21 downto 12);
end;
