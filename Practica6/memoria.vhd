library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity memoria is
Port (
	clk: in STD_LOGIC;
	reset: in STD_LOGIC;
	Dir_in: in unsigned(15 downto 0); -- Bis de direcciones de 16 bits
	Data_out: out unsigned(7 downto 0); -- Bus de datos de 8 bits
	Dir_10: out unsigned(7 downto 0); -- Bus de datos de 8 bits 
	Dir_11: out unsigned(7 downto 0); -- Bus de datos de 8 bits 
	Dir_12: out unsigned(7 downto 0) -- Bus de datos de 8 bits 
);
end memoria;

architecture Behavioral of memoria is
signal e_presente: unsigned(11 downto 0) := X"000";
begin
process(clk, reset,e_presente)
begin
if (reset = '0') then
	Data_out <= X"00";
else
	if (rising_edge(clk)) then
		case Dir_in is
			when X"0014" =>
				Data_out <= X"86";
			when X"0015" =>
				Data_out <= X"FF";
			when others =>
				Data_out <= X"00";
			end case;
		end if;
	end if;
end process;
end Behavioral;