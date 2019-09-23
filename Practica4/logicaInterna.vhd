library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity logicaInterna is
port(
  CC  : in  STD_LOGIC;
  II  : in  std_logic_vector(1 downto 0);
  PL_SIG  : out  STD_LOGIC;
  MAP_SIG  : out  STD_LOGIC;
  VECT_SIG  : out  STD_LOGIC;
  sel   : out STD_LOGIC
);
end logicaInterna;

architecture Behavioral of logicaInterna is
begin
	process(II, CC)
	begin
		if (II="00") then 
			sel <= '1';
			PL_SIG <= '1';
			MAP_SIG <= '1';
			VECT_SIG <= '1';
		elsif (II="01") then
			if (CC='0') then 
				sel <= '0';
				PL_SIG <= '0';
				MAP_SIG <= '1';
				VECT_SIG <= '1';
			else 
				sel <= '1';
				PL_SIG <= '1';
				MAP_SIG <= '1';
				VECT_SIG <= '1';
			end if;
		elsif (II="10") then
			sel <= '0';
			PL_SIG <= '1';
			MAP_SIG <= '0';
			VECT_SIG <= '1';
		elsif (II="11") then
			if (CC='0') then 
				sel <= '0';
				PL_SIG <= '1';
				MAP_SIG <= '1';
				VECT_SIG <= '0';
			else 
				sel <= '1';
				PL_SIG <= '1';
				MAP_SIG <= '1';
				VECT_SIG <= '1';
			end if;
		end if;
	end process;
end Behavioral;