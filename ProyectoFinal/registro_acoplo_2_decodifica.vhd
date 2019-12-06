library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity registro_acoplo_2_decodifica is
	Port (
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		
        OpCode_in: in unsigned (15 downto 0);
		DirW_in : in unsigned (15 downto 0);
		Dato_op_1_in: in unsigned (7 downto 0);
		Dato_op_2_in: in unsigned (7 downto 0);
        
		EnaDeten : in STD_LOGIC;

        OpCode_out: out unsigned (15 downto 0);
		DirW_out : out unsigned (15 downto 0);
		Dato_op_1_out: out unsigned (7 downto 0);
		Dato_op_2_out: out unsigned (7 downto 0)

	);
end registro_acoplo_2_decodifica;

architecture Behavioral of registro_acoplo_2_decodifica is
    constant s16 : unsigned(15 downto 0) := X"0000";
    constant s8 : unsigned(7 downto 0) := X"00";
begin
	process (clk,reset,EnaDeten)
	begin
		if reset='0' then 
			OpCode_out <= s16;
			DirW_out <= s16;
			Dato_op_1_out <= s8;
			Dato_op_2_out <= s8;
		elsif rising_edge (clk) then
			if EnaDeten='1' then
				OpCode_out <= s16;
				DirW_out <= s16;
				Dato_op_1_out <= s8;
				Dato_op_2_out <= s8;
			else
				OpCode_out <= OpCode_in;
				DirW_out <= DirW_in;
				Dato_op_1_out <= Dato_op_1_in;
				Dato_op_2_out <= Dato_op_2_in;
			end if;
		end if;
	end process;
end Behavioral;