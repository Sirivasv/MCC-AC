library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity contador_programa is
	Port (
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		EnaWr : in std_logic;
		BranchDir : in std_logic_vector (15 downto 0);
		PC_out : out std_logic_vector (15 downto 0)
	);
end contador_programa;

architecture Behavioral of contador_programa is
	constant s0 : std_logic_vector(15 downto 0) := X"0000";
	signal PC : std_logic_vector(15 downto 0) := X"0000";
begin
	process (clk,reset,BranchDir,EnaWr)
	begin
		if reset='0' then 
			PC <= s0;
		elsif rising_edge (clk) then
			if EnaWr='1' then
				PC <= BranchDir;
			else
				PC <= PC + 1;
			end if;
			PC_out <= PC;
		end if;
	end process;
end Behavioral;