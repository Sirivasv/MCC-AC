library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux2x4 is
port(
  E_INC : in  std_logic_vector(3 downto 0);
  D     : in  std_logic_vector(3 downto 0);
  sel   : in  std_logic;
  b     : out std_logic_vector(3 downto 0)
);
end mux2x4;

architecture Behavioral of mux2x4 is
	
begin
	with sel select b <= 
		E_INC when '0',
		D when others;
end Behavioral;