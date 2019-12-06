library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity WB_Logic is
	Port (
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		
      OpCode_in: in unsigned (15 downto 0);
		DirW_in : in unsigned (15 downto 0);
		Resultado: in unsigned (15 downto 0);
		Flags_in: in std_logic_vector (1 downto 0);
		
		
		PC_EnaW: out std_logic;
		Reg_EnaW: out std_logic;
		Mem_EnaW: out std_logic;
		
		DatoW: out unsigned(7 downto 0);
		DirW_out : out unsigned (15 downto 0);
		EnaDeten: out std_logic

	);
end WB_Logic;

architecture Behavioral of WB_Logic is
    constant s16 : unsigned(15 downto 0) := X"0000";
	constant s8 : unsigned(7 downto 0) := X"00";
	-- signal estados: STD_LOGIC_VECTOR (7 downto 0):= X"00";
	signal estados: STD_LOGIC_VECTOR (1 downto 0):= "00";
begin
	process (clk,reset)
	begin
		if reset='0' then 
			EnaDeten <= '0';
			PC_EnaW <= '0';
			Reg_EnaW <= '0';
			Mem_EnaW <= '0';
			estados <= "00";
			DatoW <= s8;
			DirW_out <= s16;
		elsif rising_edge (clk) then
			case OpCode_in is
				  
				-- NOP
				when X"0000" =>

					EnaDeten <= '0';
					PC_EnaW <= '0';
					Reg_EnaW <= '0';
					Mem_EnaW <= '0';
					DatoW <= s8;
					DirW_out <= s16;
				
				-- STORE IN REGISTER
				-- swr <Register_To_Write>, <Value>
				-- Ejemplo: swr $5, #$0007
				-- 0001 0005 0007 0000
				when X"0001" =>

					EnaDeten <= '0';
					PC_EnaW <= '0';
					Reg_EnaW <= '1';
					Mem_EnaW <= '0';
					DatoW <= Resultado(7 downto 0);
					DirW_out <= DirW_in;
				
				-- STORE IN MEMORY
				-- sw <Address_To_Write>, <Value>
				-- Ejemplo: sw $5, #$0003
				-- 0002 0005 0003 0000
				when X"0002" =>

					EnaDeten <= '0';
					PC_EnaW <= '0';
					Reg_EnaW <= '0';
					Mem_EnaW <= '1';
					DatoW <= Resultado(7 downto 0);
					DirW_out <= DirW_in;

				-- ADD TO REGISTER
				-- add <Register_To_Write>, <Value>, <Register_Operand>
				-- Ejemplo: add $2, #1, $2
				-- 0003 0002 0001 0002
				when X"0003" =>

					EnaDeten <= '0';
					PC_EnaW <= '0';
					Reg_EnaW <= '1';
					Mem_EnaW <= '0';
					DatoW <= Resultado(7 downto 0);
					DirW_out <= DirW_in;

				-- STORE IF THE RESULT OF THE SUBSTRACION IS NEGATIVE
				-- str_if_neg_sub <Register_To_Write>, <Address_of_memory>, <Register_Operand>
				-- Ejemplo: str_if_neg_sub $5, 0($3), $5
				-- 0004 0005 0003 0005
				when X"0004" =>

					EnaDeten <= '0';
					PC_EnaW <= '0';
					if (Flags_in(1) = '1') then
						Reg_EnaW <= '1';
					else
						Reg_EnaW <= '0';
					end if; 
					Mem_EnaW <= '0';
					DatoW <= Resultado(7 downto 0);
					DirW_out <= DirW_in;
				
				-- STORE IF THE RESULT OF THE SUBSTRACION IS NEGATIVE
				-- str_if_neg_sub <Register_To_Write>, <Register_Operand>, <Address_of_memory>
				-- Ejemplo: str_if_neg_sub $6, $6, 0($2)
				-- 0005 0006 0006 0002
				when X"0005" =>

					EnaDeten <= '0';
					PC_EnaW <= '0';
					if (Flags_in(1) = '1') then
						Reg_EnaW <= '1';
					else
						Reg_EnaW <= '0';
					end if; 
					Mem_EnaW <= '0';
					DatoW <= Resultado(7 downto 0);
					DirW_out <= DirW_in;

				-- SUBSTRACT TWO REGISTERS
				-- sub <Register_To_Write>, <Register_Operand>, <Register_Operand>
				-- Ejemplo: sub $0, $1, $3
				-- 0006 0000 0001 0003
				when X"0006" =>

					EnaDeten <= '0';
					PC_EnaW <= '0';
					Reg_EnaW <= '1';
					Mem_EnaW <= '0';
					DatoW <= Resultado(7 downto 0);
					DirW_out <= DirW_in;
				
				-- BRANCH IF EQUAL, the zero flag is enable
				-- BEQ <TAG>
				-- Ejemplo: BEQ FINAL 
				-- 0007 001A 0000 0000
				-- The tag after compilation is the new value for the PC
				when X"0007" =>

					Reg_EnaW <= '0';
					Mem_EnaW <= '0';
					DatoW <= Resultado(7 downto 0);
					DirW_out <= DirW_in;
					if (Flags_in(0) = '1') then
						EnaDeten <= '1';
						PC_EnaW <= '1';
					else
						EnaDeten <= '0';
						PC_EnaW <= '0';
					
					end if;
					
				
				-- BRANCH
				-- BRA <TAG>
				-- Ejemplo: BRA CHECK 
				-- 0008 0011 0000 0000
				-- The tag after compilation is the new value for the PC
				when X"0008" =>

					Reg_EnaW <= '0';
					Mem_EnaW <= '0';
					DatoW <= Resultado(7 downto 0);
					DirW_out <= DirW_in;
					EnaDeten <= '1';
					PC_EnaW <= '1';
					 
			end case;
			estados <= Flags_in;
		end if;
	end process;
end Behavioral;