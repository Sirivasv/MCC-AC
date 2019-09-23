library IEEE;
use IEEE.std_logic_1164.all;

use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity mux4 is
port(
  X   : in  STD_LOGIC;
  Y   : in  STD_LOGIC;
  INT : in  STD_LOGIC;
  sel : in  std_logic_vector(1 downto 0);
  b   : out STD_LOGIC
);
end mux4;

architecture Behavioral of mux4 is
	constant Qx : STD_LOGIC := '0';
begin
	with sel select b <= 
		Qx when "00",
		X when "01",
		Y when "10",
		INT when others;
end Behavioral;