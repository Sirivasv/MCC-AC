library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity registro_acoplo_3_exec is
	Port (

		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		
      OpCode_in : in unsigned (15 downto 0);
		DirW_in : in unsigned (15 downto 0);
		Resultado_in : in unsigned (7 downto 0);
		Flags_in : in std_logic_vector (1 downto 0);
		EnaDeten : in STD_LOGIC;
		
		OpCode_out : out unsigned (15 downto 0);
		DirW_out : out unsigned (15 downto 0);
		Resultado_out : out unsigned (7 downto 0);
		Flags_out : out std_logic_vector (1 downto 0)

	);
end registro_acoplo_3_exec;

architecture Behavioral of registro_acoplo_3_exec is
begin
	process (clk, reset, EnaDeten)
	begin
		if reset='0' then 
		
			OpCode_out <= X"0000";
			DirW_out <= X"0000";
			Resultado_out <= X"0000";
			Flags_out <= "00";

		elsif rising_edge (clk) then

			if EnaDeten='1' then
				OpCode_out <= X"0000";
				DirW_out <= X"0000";
				Resultado_out <= X"0000";
				Flags_out <= "00";
			else
				OpCode_out <= OpCode_in;
				DirW_out <= DirW_in;
				Resultado_out <= Resultado_in;
				Flags_out <= Flags_in;
			end if;

		end if;
	end process;
end Behavioral;