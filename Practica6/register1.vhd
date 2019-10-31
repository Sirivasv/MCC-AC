library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity register1 is
	Port (
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		load_signal : in std_logic;
		Dir_in: in unsigned(15 downto 0); -- Bus de direcciones de 16 bits
		Data_out: out unsigned(7 downto 0);
		D : in std_logic;
		Q : out std_logic;
		sal_d : out std_logic
	);
end register1;

architecture Behavioral of register1 is
	constant s0 :
	std_logic := '0';
begin
	process (clk,reset,load_signal)
	begin
		if reset='0' then 
			Q <= s0;
		elsif rising_edge (clk) then
			if load_signal='1' then
				Q <= D;
			end if;
			--Q <= D;
			--sal_d <= load_signal;
		end if;
	end process;
end Behavioral;