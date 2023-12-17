library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity digit is
        port (
				digit : in unsigned (4 downto 0);
                x : in unsigned(9 downto 0); -- 5bit for 32 pixel bird
                y : in unsigned(9 downto 0);
                rgb : out std_logic_vector(5 downto 0);
				clk : in std_logic
        );
end digit;

architecture synth of digit is
        signal smallx : unsigned(7 downto 0);
        signal smally : unsigned(7 downto 0);
begin
        smallx <= x(9 downto 2); -- divide to get image size (16x16)
        smally <= y(9 downto 2);

process(clk) begin
if rising_edge(clk) then
end if;
	-- NUMBER  0
	case digit is
	when 5d"0" => rgb <=
		"101010" when smallx = "0000000" and smally = "0000000" else
		"111111" when smallx = "0000001" and smally = "0000000" else
		"111111" when smallx = "0000010" and smally = "0000000" else
		"101010" when smallx = "0000011" and smally = "0000000" else
		"111111" when smallx = "0000000" and smally = "0000001" else
		"101010" when smallx = "0000001" and smally = "0000001" else
		"101010" when smallx = "0000010" and smally = "0000001" else
		"111111" when smallx = "0000011" and smally = "0000001" else
		"111111" when smallx = "0000000" and smally = "0000010" else
		"101010" when smallx = "0000001" and smally = "0000010" else
		"101010" when smallx = "0000010" and smally = "0000010" else
		"111111" when smallx = "0000011" and smally = "0000010" else
		"111111" when smallx = "0000000" and smally = "0000011" else
		"101010" when smallx = "0000001" and smally = "0000011" else
		"101010" when smallx = "0000010" and smally = "0000011" else
		"111111" when smallx = "0000011" and smally = "0000011" else
		"101010" when smallx = "0000000" and smally = "0000100" else
		"111111" when smallx = "0000001" and smally = "0000100" else
		"111111" when smallx = "0000010" and smally = "0000100" else
		"101010" when smallx = "0000011" and smally = "0000100" else
		"101010";
	-- NUMBER  1
	when 5d"1" => rgb <=
		"101010" when smallx = "0000000" and smally = "0000000" else
		"111111" when smallx = "0000001" and smally = "0000000" else
		"101010" when smallx = "0000010" and smally = "0000000" else
		"101010" when smallx = "0000011" and smally = "0000000" else
		"111111" when smallx = "0000000" and smally = "0000001" else
		"111111" when smallx = "0000001" and smally = "0000001" else
		"101010" when smallx = "0000010" and smally = "0000001" else
		"101010" when smallx = "0000011" and smally = "0000001" else
		"101010" when smallx = "0000000" and smally = "0000010" else
		"111111" when smallx = "0000001" and smally = "0000010" else
		"101010" when smallx = "0000010" and smally = "0000010" else
		"101010" when smallx = "0000011" and smally = "0000010" else
		"101010" when smallx = "0000000" and smally = "0000011" else
		"111111" when smallx = "0000001" and smally = "0000011" else
		"101010" when smallx = "0000010" and smally = "0000011" else
		"101010" when smallx = "0000011" and smally = "0000011" else
		"111111" when smallx = "0000000" and smally = "0000100" else
		"111111" when smallx = "0000001" and smally = "0000100" else
		"111111" when smallx = "0000010" and smally = "0000100" else
		"101010" when smallx = "0000011" and smally = "0000100" else
		"101010";
		-- NUMBER  2
	when 5d"2" => rgb <=
		"101010" when smallx = "0000000" and smally = "0000000" else
		"111111" when smallx = "0000001" and smally = "0000000" else
		"111111" when smallx = "0000010" and smally = "0000000" else
		"101010" when smallx = "0000011" and smally = "0000000" else
		"111111" when smallx = "0000000" and smally = "0000001" else
		"101010" when smallx = "0000001" and smally = "0000001" else
		"101010" when smallx = "0000010" and smally = "0000001" else
		"111111" when smallx = "0000011" and smally = "0000001" else
		"101010" when smallx = "0000000" and smally = "0000010" else
		"101010" when smallx = "0000001" and smally = "0000010" else
		"111111" when smallx = "0000010" and smally = "0000010" else
		"101010" when smallx = "0000011" and smally = "0000010" else
		"101010" when smallx = "0000000" and smally = "0000011" else
		"111111" when smallx = "0000001" and smally = "0000011" else
		"101010" when smallx = "0000010" and smally = "0000011" else
		"101010" when smallx = "0000011" and smally = "0000011" else
		"111111" when smallx = "0000000" and smally = "0000100" else
		"111111" when smallx = "0000001" and smally = "0000100" else
		"111111" when smallx = "0000010" and smally = "0000100" else
		"111111" when smallx = "0000011" and smally = "0000100" else
		"101010";
		-- NUMBER  3
	when 5d"3" => rgb <=
		"101010" when smallx = "0000000" and smally = "0000000" else
		"111111" when smallx = "0000001" and smally = "0000000" else
		"111111" when smallx = "0000010" and smally = "0000000" else
		"101010" when smallx = "0000011" and smally = "0000000" else
		"111111" when smallx = "0000000" and smally = "0000001" else
		"101010" when smallx = "0000001" and smally = "0000001" else
		"101010" when smallx = "0000010" and smally = "0000001" else
		"111111" when smallx = "0000011" and smally = "0000001" else
		"101010" when smallx = "0000000" and smally = "0000010" else
		"101010" when smallx = "0000001" and smally = "0000010" else
		"111111" when smallx = "0000010" and smally = "0000010" else
		"101010" when smallx = "0000011" and smally = "0000010" else
		"111111" when smallx = "0000000" and smally = "0000011" else
		"101010" when smallx = "0000001" and smally = "0000011" else
		"101010" when smallx = "0000010" and smally = "0000011" else
		"111111" when smallx = "0000011" and smally = "0000011" else
		"101010" when smallx = "0000000" and smally = "0000100" else
		"111111" when smallx = "0000001" and smally = "0000100" else
		"111111" when smallx = "0000010" and smally = "0000100" else
		"101010" when smallx = "0000011" and smally = "0000100" else
		"101010";
		-- NUMBER  4
	when 5d"4" => rgb <=
		"101010" when smallx = "0000000" and smally = "0000000" else
		"101010" when smallx = "0000001" and smally = "0000000" else
		"111111" when smallx = "0000010" and smally = "0000000" else
		"101010" when smallx = "0000011" and smally = "0000000" else
		"101010" when smallx = "0000000" and smally = "0000001" else
		"111111" when smallx = "0000001" and smally = "0000001" else
		"111111" when smallx = "0000010" and smally = "0000001" else
		"101010" when smallx = "0000011" and smally = "0000001" else
		"111111" when smallx = "0000000" and smally = "0000010" else
		"101010" when smallx = "0000001" and smally = "0000010" else
		"111111" when smallx = "0000010" and smally = "0000010" else
		"101010" when smallx = "0000011" and smally = "0000010" else
		"111111" when smallx = "0000000" and smally = "0000011" else
		"111111" when smallx = "0000001" and smally = "0000011" else
		"111111" when smallx = "0000010" and smally = "0000011" else
		"111111" when smallx = "0000011" and smally = "0000011" else
		"101010" when smallx = "0000000" and smally = "0000100" else
		"101010" when smallx = "0000001" and smally = "0000100" else
		"111111" when smallx = "0000010" and smally = "0000100" else
		"101010" when smallx = "0000011" and smally = "0000100" else
		"101010";
		-- NUMBER  5
	when 5d"5" => rgb <=
		"111111" when smallx = "0000000" and smally = "0000000" else
		"111111" when smallx = "0000001" and smally = "0000000" else
		"111111" when smallx = "0000010" and smally = "0000000" else
		"111111" when smallx = "0000011" and smally = "0000000" else
		"111111" when smallx = "0000000" and smally = "0000001" else
		"101010" when smallx = "0000001" and smally = "0000001" else
		"101010" when smallx = "0000010" and smally = "0000001" else
		"101010" when smallx = "0000011" and smally = "0000001" else
		"111111" when smallx = "0000000" and smally = "0000010" else
		"111111" when smallx = "0000001" and smally = "0000010" else
		"111111" when smallx = "0000010" and smally = "0000010" else
		"101010" when smallx = "0000011" and smally = "0000010" else
		"101010" when smallx = "0000000" and smally = "0000011" else
		"101010" when smallx = "0000001" and smally = "0000011" else
		"101010" when smallx = "0000010" and smally = "0000011" else
		"111111" when smallx = "0000011" and smally = "0000011" else
		"111111" when smallx = "0000000" and smally = "0000100" else
		"111111" when smallx = "0000001" and smally = "0000100" else
		"111111" when smallx = "0000010" and smally = "0000100" else
		"101010" when smallx = "0000011" and smally = "0000100" else
		"101010";
		-- NUMBER  6
	when 5d"6" => rgb <=
		"101010" when smallx = "0000000" and smally = "0000000" else
		"111111" when smallx = "0000001" and smally = "0000000" else
		"111111" when smallx = "0000010" and smally = "0000000" else
		"101010" when smallx = "0000011" and smally = "0000000" else
		"111111" when smallx = "0000000" and smally = "0000001" else
		"101010" when smallx = "0000001" and smally = "0000001" else
		"101010" when smallx = "0000010" and smally = "0000001" else
		"101010" when smallx = "0000011" and smally = "0000001" else
		"111111" when smallx = "0000000" and smally = "0000010" else
		"111111" when smallx = "0000001" and smally = "0000010" else
		"111111" when smallx = "0000010" and smally = "0000010" else
		"101010" when smallx = "0000011" and smally = "0000010" else
		"111111" when smallx = "0000000" and smally = "0000011" else
		"101010" when smallx = "0000001" and smally = "0000011" else
		"101010" when smallx = "0000010" and smally = "0000011" else
		"111111" when smallx = "0000011" and smally = "0000011" else
		"101010" when smallx = "0000000" and smally = "0000100" else
		"111111" when smallx = "0000001" and smally = "0000100" else
		"111111" when smallx = "0000010" and smally = "0000100" else
		"101010" when smallx = "0000011" and smally = "0000100" else
		"101010";
		-- NUMBER  7
	when 5d"7" => rgb <=
		"111111" when smallx = "0000000" and smally = "0000000" else
		"111111" when smallx = "0000001" and smally = "0000000" else
		"111111" when smallx = "0000010" and smally = "0000000" else
		"101010" when smallx = "0000011" and smally = "0000000" else
		"101010" when smallx = "0000000" and smally = "0000001" else
		"101010" when smallx = "0000001" and smally = "0000001" else
		"101010" when smallx = "0000010" and smally = "0000001" else
		"111111" when smallx = "0000011" and smally = "0000001" else
		"101010" when smallx = "0000000" and smally = "0000010" else
		"101010" when smallx = "0000001" and smally = "0000010" else
		"101010" when smallx = "0000010" and smally = "0000010" else
		"111111" when smallx = "0000011" and smally = "0000010" else
		"101010" when smallx = "0000000" and smally = "0000011" else
		"101010" when smallx = "0000001" and smally = "0000011" else
		"111111" when smallx = "0000010" and smally = "0000011" else
		"101010" when smallx = "0000011" and smally = "0000011" else
		"101010" when smallx = "0000000" and smally = "0000100" else
		"101010" when smallx = "0000001" and smally = "0000100" else
		"111111" when smallx = "0000010" and smally = "0000100" else
		"101010" when smallx = "0000011" and smally = "0000100" else
		"101010";
		-- NUMBER  8
	when 5d"8" => rgb <=
		"101010" when smallx = "0000000" and smally = "0000000" else
		"111111" when smallx = "0000001" and smally = "0000000" else
		"111111" when smallx = "0000010" and smally = "0000000" else
		"101010" when smallx = "0000011" and smally = "0000000" else
		"111111" when smallx = "0000000" and smally = "0000001" else
		"101010" when smallx = "0000001" and smally = "0000001" else
		"101010" when smallx = "0000010" and smally = "0000001" else
		"111111" when smallx = "0000011" and smally = "0000001" else
		"101010" when smallx = "0000000" and smally = "0000010" else
		"111111" when smallx = "0000001" and smally = "0000010" else
		"111111" when smallx = "0000010" and smally = "0000010" else
		"101010" when smallx = "0000011" and smally = "0000010" else
		"111111" when smallx = "0000000" and smally = "0000011" else
		"101010" when smallx = "0000001" and smally = "0000011" else
		"101010" when smallx = "0000010" and smally = "0000011" else
		"111111" when smallx = "0000011" and smally = "0000011" else
		"101010" when smallx = "0000000" and smally = "0000100" else
		"111111" when smallx = "0000001" and smally = "0000100" else
		"111111" when smallx = "0000010" and smally = "0000100" else
		"101010" when smallx = "0000011" and smally = "0000100" else
		"101010";
		-- NUMBER  9
	when 5d"9" => rgb <=
		"101010" when smallx = "0000000" and smally = "0000000" else
		"111111" when smallx = "0000001" and smally = "0000000" else
		"111111" when smallx = "0000010" and smally = "0000000" else
		"101010" when smallx = "0000011" and smally = "0000000" else
		"111111" when smallx = "0000000" and smally = "0000001" else
		"101010" when smallx = "0000001" and smally = "0000001" else
		"101010" when smallx = "0000010" and smally = "0000001" else
		"111111" when smallx = "0000011" and smally = "0000001" else
		"101010" when smallx = "0000000" and smally = "0000010" else
		"111111" when smallx = "0000001" and smally = "0000010" else
		"111111" when smallx = "0000010" and smally = "0000010" else
		"111111" when smallx = "0000011" and smally = "0000010" else
		"101010" when smallx = "0000000" and smally = "0000011" else
		"101010" when smallx = "0000001" and smally = "0000011" else
		"101010" when smallx = "0000010" and smally = "0000011" else
		"111111" when smallx = "0000011" and smally = "0000011" else
		"101010" when smallx = "0000000" and smally = "0000100" else
		"101010" when smallx = "0000001" and smally = "0000100" else
		"111111" when smallx = "0000010" and smally = "0000100" else
		"101010" when smallx = "0000011" and smally = "0000100" else
		"101010";
	when others => rgb <= "011011";
end case;
end process;
end;