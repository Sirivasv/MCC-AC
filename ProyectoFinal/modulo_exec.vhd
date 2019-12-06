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
	constant ZERO : unsigned (7 downto 0) := "00000000" ;
begin
	process (clk, reset)
	variable curr_result : unsigned(7 downto 0);
	begin
		if reset='0' then 
		
			OpCode_out <= X"0000";
			DirW_out <= X"0000";
			Resultado <= X"0000";
			Flags <= X"00";

		elsif rising_edge (clk) then

			case OpCode_in is
				  
				-- NOP
				when X"0000" =>
					Resultado <= X"0000";
					Flags <= X"00";
				
				-- STORE IN REGISTER
				-- swr <Register_To_Write>, <Value>
				-- Ejemplo: swr $5, #$0007
				-- 0001 0005 0007 0000
				when X"0001" =>
					curr_result := Op_1_in;
					Resultado <= X"00"&curr_result;
					if (curr_result = ZERO) then
						Flags(0) <= '1';
					else 
						Flags(0) <= '0';
					end if;
					Flags(1) <= curr_result(7);
				
				-- STORE IN MEMORY
				-- sw <Address_To_Write>, <Value>
				-- Ejemplo: sw $5, #$0003
				-- 0002 0005 0003 0000
				when X"0002" =>
					curr_result := Op_1_in;
					Resultado <= X"00"&curr_result;
					if (curr_result = ZERO) then
						Flags(0) <= '1';
					else 
						Flags(0) <= '0';
					end if;
					Flags(1) <= curr_result(7);

				-- ADD TO REGISTER
				-- add <Register_To_Write>, <Value>, <Register_Operand>
				-- Ejemplo: add $2, #1, $2
				-- 0003 0002 0001 0002
				when X"0003" =>
					curr_result := (Op_1_in+Op_2_in);
					Resultado <= X"00"&curr_result;
					if (curr_result = ZERO) then
						Flags(0) <= '1';
					else 
						Flags(0) <= '0';
					end if;
					Flags(1) <= curr_result(7);

				-- STORE IF THE RESULT OF THE SUBSTRACION IS NEGATIVE
				-- str_if_neg_sub <Register_To_Write>, <Address_of_memory>, <Register_Operand>
				-- Ejemplo: str_if_neg_sub $5, 0($3), $5
				-- 0004 0005 0003 0005
				when X"0004" =>
					curr_result := (Op_1_in-Op_2_in);
					Resultado <= X"00"&Op_1_in;
					if (curr_result = ZERO) then
						Flags(0) <= '1';
					else 
						Flags(0) <= '0';
					end if;
					Flags(1) <= curr_result(7);
				
				-- STORE IF THE RESULT OF THE SUBSTRACION IS NEGATIVE
				-- str_if_neg_sub <Register_To_Write>, <Register_Operand>, <Address_of_memory>
				-- Ejemplo: str_if_neg_sub $6, $6, 0($2)
				-- 0005 0006 0006 0002
				when X"0005" =>
					curr_result := (Op_1_in-Op_2_in);
					Resultado <= X"00"&Op_2_in;
					if (curr_result = ZERO) then
						Flags(0) <= '1';
					else 
						Flags(0) <= '0';
					end if;
					Flags(1) <= curr_result(7);

				-- SUBSTRACT TWO REGISTERS
				-- sub <Register_To_Write>, <Register_Operand>, <Register_Operand>
				-- Ejemplo: sub $0, $1, $3
				-- 0006 0000 0001 0003
				when X"0006" =>
					curr_result := (Op_1_in-Op_2_in);
					Resultado <= X"00"&curr_result;
					if (curr_result = ZERO) then
						Flags(0) <= '1';
					else
						Flags(0) <= '0';
					end if;
					Flags(1) <= curr_result(7);
				
				-- BRANCH IF EQUAL, the zero flag is enable
				-- BEQ <TAG>
				-- Ejemplo: BEQ FINAL 
				-- 0007 001A 0000 0000
				-- The tag after compilation is the new value for the PC
				when X"0007" =>
					Resultado <= X"0000";
					Flags <= X"00";
				
				-- BRANCH
				-- BRA <TAG>
				-- Ejemplo: BRA CHECK 
				-- 0008 0011 0000 0000
				-- The tag after compilation is the new value for the PC
				when X"0008" =>
					Resultado <= X"0000";
					Flags <= X"00";
				
				when others =>
					Resultado <= X"0000";
					Flags <= X"00";
					 
			end case;

			OpCode_out <= OpCode_in;
			DirW_out <= DirW_in;
			
		end if;
	end process;
end Behavioral;