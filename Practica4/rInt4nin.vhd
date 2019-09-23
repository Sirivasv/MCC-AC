library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity rInt4nin is
	Port (
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		Q : out std_logic_vector (3 downto 0)
	);
end rInt4nin;

architecture Behavioral of rInt4nin is
	constant s0 :
	std_logic_vector(3 downto 0) := B"0000";
begin
	process (clk,reset)
	begin
		if reset='0' then 
			Q <=s0;
		elsif rising_edge (clk) then
			Q <= B"1011";
		end if;
	end process;
end Behavioral;