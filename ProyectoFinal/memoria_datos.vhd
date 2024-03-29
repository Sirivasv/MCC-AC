library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity memoria_datos is
Port (
	Dir_in_1: in unsigned(15 downto 0);
	Dir_in_2: in unsigned(15 downto 0);
	clk: in STD_LOGIC;
	reset: in STD_LOGIC;
	EnaW: in STD_LOGIC := '0';
	Data_in: in unsigned(7 downto 0);
	DirW: in unsigned(15 downto 0);
	Data_out_1: out unsigned(7 downto 0);
	Data_out_2: out unsigned(7 downto 0)
);
end memoria_datos;

architecture Behavioral of memoria_datos is

-- Memory Signals
signal Dir_0000: unsigned (7 downto 0) := X"00";
signal Dir_0001: unsigned (7 downto 0) := X"00";
signal Dir_0002: unsigned (7 downto 0) := X"00";
signal Dir_0003: unsigned (7 downto 0) := X"00";
signal Dir_0004: unsigned (7 downto 0) := X"00";
signal Dir_0005: unsigned (7 downto 0) := X"00";
signal Dir_0006: unsigned (7 downto 0) := X"00";
signal Dir_0007: unsigned (7 downto 0) := X"00";
signal Dir_0008: unsigned (7 downto 0) := X"00";

signal Dir_0009: unsigned (7 downto 0) := X"00";
signal Dir_000A: unsigned (7 downto 0) := X"00";
signal Dir_000B: unsigned (7 downto 0) := X"00";
signal Dir_000C: unsigned (7 downto 0) := X"00";
signal Dir_000D: unsigned (7 downto 0) := X"00";
signal Dir_000E: unsigned (7 downto 0) := X"00";
signal Dir_000F: unsigned (7 downto 0) := X"00";
signal Dir_0010: unsigned (7 downto 0) := X"00";


begin
process(clk, reset, EnaW, DirW, Dir_in_1, Dir_in_2)
begin
if (reset = '0') then

	-- Out Signals
	Data_out_1 <= X"00";
	Data_out_2 <= X"00";

	-- Memory Signals
	Dir_0000 <= X"00";
	Dir_0001 <= X"00";
	Dir_0002 <= X"00";
	Dir_0003 <= X"00";
	Dir_0004 <= X"00";
	Dir_0005 <= X"00";
	Dir_0006 <= X"00";
	Dir_0007 <= X"00";
	Dir_0008 <= X"00";
	
	Dir_0009 <= X"00";
	Dir_000A <= X"00";
	Dir_000B <= X"00";
	Dir_000C <= X"00";
	Dir_000D <= X"00";
	Dir_000E <= X"00";
	Dir_000F <= X"00";
	Dir_0010 <= X"00";

else
	if (rising_edge(clk)) then
		if (EnaW = '1') then
			case DirW is
			when X"0000" =>
				Dir_0000 <= Data_in;
			when X"0001" =>
				Dir_0001 <= Data_in;
			when X"0002" =>
				Dir_0002 <= Data_in;
			when X"0003" =>
				Dir_0003 <= Data_in;
			when X"0004" =>
				Dir_0004 <= Data_in;
			when X"0005" =>
				Dir_0005 <= Data_in;
			when X"0006" =>
				Dir_0006 <= Data_in;
			when X"0007" =>
				Dir_0007 <= Data_in;
			when X"0008" =>
				Dir_0008 <= Data_in;
			
			when X"0009" =>
				Dir_0009 <= Data_in;
			when X"000A" =>
				Dir_000A <= Data_in;
			when X"000B" =>
				Dir_000B <= Data_in;
			when X"000C" =>
				Dir_000C <= Data_in;
			when X"000D" =>
				Dir_000D <= Data_in;
			when X"000E" =>
				Dir_000E <= Data_in;
			when X"000F" =>
				Dir_000F <= Data_in;
			when X"0010" =>
				Dir_0010 <= Data_in;
			
			when others =>
				Dir_0008 <= Data_in;
			end case;
		end if;

		case Dir_in_1 is
		-- Memory Signals
		when X"0000" =>
			Data_out_1 <= Dir_0000;
		when X"0001" =>
			Data_out_1 <= Dir_0001;
		when X"0002" =>
			Data_out_1 <= Dir_0002;
		when X"0003" =>
			Data_out_1 <= Dir_0003;
		when X"0004" =>
			Data_out_1 <= Dir_0004;
		when X"0005" =>
			Data_out_1 <= Dir_0005;
		when X"0006" =>
			Data_out_1 <= Dir_0006;
		when X"0007" =>
			Data_out_1 <= Dir_0007;
		when X"0008" =>
			Data_out_1 <= Dir_0008;
			
		when X"0009" =>
			Data_out_1 <= Dir_0009;
		when X"000A" =>
			Data_out_1 <= Dir_000A;
		when X"000B" =>
			Data_out_1 <= Dir_000B;
		when X"000C" =>
			Data_out_1 <= Dir_000C;
		when X"000D" =>
			Data_out_1 <= Dir_000D;
		when X"000E" =>
			Data_out_1 <= Dir_000E;
		when X"000F" =>
			Data_out_1 <= Dir_000F;
		when X"0010" =>
			Data_out_1 <= Dir_0010;
			
		when others =>
			Data_out_1 <= X"00";
		end case;

		case Dir_in_2 is
		-- Memory Signals
		when X"0000" =>
			Data_out_2 <= Dir_0000;
		when X"0001" =>
			Data_out_2 <= Dir_0001;
		when X"0002" =>
			Data_out_2 <= Dir_0002;
		when X"0003" =>
			Data_out_2 <= Dir_0003;
		when X"0004" =>
			Data_out_2 <= Dir_0004;
		when X"0005" =>
			Data_out_2 <= Dir_0005;
		when X"0006" =>
			Data_out_2 <= Dir_0006;
		when X"0007" =>
			Data_out_2 <= Dir_0007;
		when X"0008" =>
			Data_out_2 <= Dir_0008;
			
		when X"0009" =>
			Data_out_2 <= Dir_0009;
		when X"000A" =>
			Data_out_2 <= Dir_000A;
		when X"000B" =>
			Data_out_2 <= Dir_000B;
		when X"000C" =>
			Data_out_2 <= Dir_000C;
		when X"000D" =>
			Data_out_2 <= Dir_000D;
		when X"000E" =>
			Data_out_2 <= Dir_000E;
		when X"000F" =>
			Data_out_2 <= Dir_000F;
		when X"0010" =>
			Data_out_2 <= Dir_0010;
			
		when others =>
			Data_out_2 <= X"00";
		end case;
		
	end if;
end if;


end process;
end Behavioral;