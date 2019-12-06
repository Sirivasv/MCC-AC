library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity modulo_exec is
	Port (

		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		
        OpCode_in : in unsigned (15 downto 0);
		DirW_in : in unsigned (15 downto 0);
		Op_1_in : in unsigned (7 downto 0);
		Op_2_in : in unsigned (7 downto 0);
		
		OpCode_out : out unsigned (15 downto 0);
		DirW_out : out unsigned (15 downto 0);
		Resultado : out unsigned (15 downto 0);
		Flags : out std_logic_vector (7 downto 0)

	);
end modulo_exec;

architecture Behavioral of modulo_exec is
begin
	process (clk, reset)
	begin
		if reset='0' then 
		
			OpCode_out <= X"0000";
			DirW_out <= X"0000";
			Resultado <= X"0000";
			Flags <= X"00";

		elsif rising_edge (clk) then
			OpCode_out <= OpCode_in;
			DirW_out <= DirW_in;
			Resultado <= Op_1_in&Op_2_in;
			Flags <= X"00";
		end if;
	end process;
end Behavioral;