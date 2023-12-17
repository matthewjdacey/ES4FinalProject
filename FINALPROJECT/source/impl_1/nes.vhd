library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity nes is
  port (
    data : in std_logic;
    NES_Latch   : out std_logic;
    NES_Clock   : out std_logic;
    output : out std_logic_vector(7 downto 0);
	clk : in std_logic
  );
end nes;

architecture synth of nes is
  signal counter : unsigned(25 downto 0) := (others => '0');
  signal NESclk  : std_logic;
  signal NEScount : unsigned(7 downto 0);
  signal shiftReg :  std_logic_vector(7 downto 0) := (others => '0');
  signal shiftReg2 : std_logic_vector(7 downto 0) := (others => '0');
	
	signal output_clk : std_logic;
	signal latch : std_logic;

begin

  process(clk)
  begin
    if rising_edge(clk) then
      counter <= counter + 1;
    end if;    
  end process;

  NEScount <= counter(16 downto 9);

  latch <= '1' when (NEScount = 0x"08") else '0';

  NESclk <= counter(8);
  output_clk <= NESclk when (NEScount < 0x"08") else '0';
  
  process(output_clk) 
  begin
  if rising_edge(output_clk) then
    shiftReg(7 downto 1) <= shiftReg(6 downto 0); 
	shiftReg(0) <= not data;
  end if;
  end process;
  
  shiftReg2 <= shiftReg when latch;
  output <= shiftReg2;
  NES_Clock <= output_clk;
  NES_Latch <= latch;
  
end;
