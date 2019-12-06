library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity registro_intermedio_decode is
	Port (
		clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        OpCode_in : in unsigned(15 downto 0);
		DirW_in : in unsigned(15 downto 0);
		Dato_op_1_in: in unsigned(7 downto 0);
		Dato_op_2_in: in unsigned(7 downto 0);
		Op_sel_1_in: in unsigned(1 downto 0);
		Op_sel_2_in: in unsigned(1 downto 0);
		
		OpCode_out : out unsigned(15 downto 0);
		DirW_out : out unsigned(15 downto 0);
		Dato_op_1_out: out unsigned(7 downto 0);
		Dato_op_2_out: out unsigned(7 downto 0);
		Op_sel_1_out: out unsigned(1 downto 0);
		Op_sel_2_out: out unsigned(1 downto 0)
	);
end registro_intermedio_decode;

architecture Behavioral of registro_intermedio_decode is
begin
	process (clk, reset)
	begin
		if reset='0' then 
			OpCode_out <= X"0000";
			DirW_out <= X"0000";
			Dato_op_1_out <= X"00";
			Dato_op_2_out <= X"00";
			Op_sel_1_out <= "00";
			Op_sel_2_out <= "00";
		elsif rising_edge (clk) then
			OpCode_out <= OpCode_in;
			DirW_out <= DirW_in;
			Dato_op_1_out <= Dato_op_1_in;
			Dato_op_2_out <= Dato_op_2_in;
			Op_sel_1_out <= Op_sel_1_in;
			Op_sel_2_out <= Op_sel_2_in;
		end if;
	end process;
end Behavioral;