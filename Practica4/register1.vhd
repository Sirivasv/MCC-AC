library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity register1 is
	Port (
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		D : in STD_LOGIC;
		Q : out STD_LOGIC
	);
end register1;

architecture Behavioral of register1 is
	constant s0 :
	STD_LOGIC := '0';
begin
	process (clk,reset)
	begin
		if reset='0' then 
			Q <=s0;
		elsif rising_edge (clk) then
			Q <= D;
		end if;
	end process;
end Behavioral;