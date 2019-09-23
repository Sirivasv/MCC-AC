library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity regmux is
port(
  LIG_REG  : in  std_logic_vector(3 downto 0);
  PL_SIG  : in  STD_LOGIC;
  TRAN_REG  : in  std_logic_vector(3 downto 0);
  MAP_SIG  : in  STD_LOGIC;
  INT_REG  : in  std_logic_vector(3 downto 0);
  VECT_SIG  : in  STD_LOGIC;
  D  : out  std_logic_vector(3 downto 0)
);
end regmux;

architecture Behavioral of regmux is
begin
	process(PL_SIG, MAP_SIG, VECT_SIG, LIG_REG, TRAN_REG, INT_REG)
	begin
		if (PL_SIG='0') then 
			D <= LIG_REG;
		elsif (MAP_SIG='0') then
			D <= TRAN_REG;
		elsif (VECT_SIG='0') then
			D <= INT_REG;
		else 
			D <= "0000";
		end if;
	end process;
end Behavioral;