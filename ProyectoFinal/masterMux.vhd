library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity masterMux is
	Port (

		Sel_Stage : in std_logic_vector (3 downto 0);
		Sel_Value : in std_logic_vector (3 downto 0);

		PC_S0 : in std_logic_vector (15 downto 0);
		Instr_S0 : in std_logic_vector (63 downto 0);

		PC_S1 : in std_logic_vector (15 downto 0);
		Instr_S1 : in std_logic_vector (63 downto 0);

		OpCode_S2 : in std_logic_vector (15 downto 0);
		DirW_S2 : in std_logic_vector (15 downto 0);
		Dato_op_1_S2 : in std_logic_vector (7 downto 0);
		Dato_op_2_S2 : in std_logic_vector (7 downto 0);
		Op_sel_1_S2 : in std_logic_vector (1 downto 0);
		Op_sel_2_S2 : in std_logic_vector (1 downto 0);
		Dir_mem_op_1_S2 : in std_logic_vector (15 downto 0);
		Dir_mem_op_2_S2 : in std_logic_vector (15 downto 0);
		Reg_0005_MinX_S2 : in std_logic_vector (7 downto 0);
		Reg_0006_MinY_S2 : in std_logic_vector (7 downto 0);
		Reg_0007_MaxX_S2 : in std_logic_vector (7 downto 0);
		Reg_0008_MaxY_S2 : in std_logic_vector (7 downto 0);

		OpCode_S3 : in std_logic_vector (15 downto 0);
		DirW_S3 : in std_logic_vector (15 downto 0);
		Dato_op_1_S3 : in std_logic_vector (7 downto 0);
		Dato_op_2_S3 : in std_logic_vector (7 downto 0);

		OpCode_S4 : in std_logic_vector (15 downto 0);
		DirW_S4 : in std_logic_vector (15 downto 0);
		Dato_op_1_S4 : in std_logic_vector (7 downto 0);
		Dato_op_2_S4 : in std_logic_vector (7 downto 0);

		OpCode_S5 : in std_logic_vector (15 downto 0);
		DirW_S5 : in std_logic_vector (15 downto 0);
		Resultado_S5 : in std_logic_vector (15 downto 0);
		Flags_S5 : in std_logic_vector (7 downto 0);

		OpCode_S6 : in std_logic_vector (15 downto 0);
		DirW_S6 : in std_logic_vector (15 downto 0);
		Resultado_S6 : in std_logic_vector (15 downto 0);
		Flags_S6 : in std_logic_vector (7 downto 0);
		
		PC_EnaW_S7 : in std_logic;
		Reg_EnaW_S7 : in std_logic;
		Mem_EnaW_S7 : in std_logic;
		DatoW_S7 : in std_logic_vector (7 downto 0);
		DirW_S7 : in std_logic_vector (15 downto 0);
		EnaDeten_S7 : in std_logic;
		
		SALIDA : out std_logic_vector (17 downto 0)

	);
end masterMux;

architecture Behavioral of masterMux is
begin
	process (Sel_Stage, Sel_Value)
	begin


		case Sel_Stage is

			-- STAGE 0
			when "0000" =>
				
				case Sel_Value is
					-- PC_S0
					when "0000" =>
						SALIDA <= "00"&PC_S0;
					-- Instr_P0_S0
					when "0001" =>
						SALIDA <= "00"&Instr_S0(63 downto 48);
					-- Instr_P1_S0
					when "0010" =>
						SALIDA <= "00"&Instr_S0(47 downto 32);
					-- Instr_P2_S0
					when "0011" =>
						SALIDA <= "00"&Instr_S0(31 downto 16);
					-- Instr_P3_S0
					when "0100" =>
						SALIDA <= "00"&Instr_S0(15 downto 0);
					when others =>
						SALIDA <= "00"&X"0000";
				end case;
			
			-- STAGE 1
			when "0001" =>
				
				case Sel_Value is
					-- PC_S1
					when "0000" =>
						SALIDA <= "00"&PC_S1;
					-- Instr_P0_S1
					when "0001" =>
						SALIDA <= "00"&Instr_S1(63 downto 48);
					-- Instr_P1_S1
					when "0010" =>
						SALIDA <= "00"&Instr_S1(47 downto 32);
					-- Instr_P2_S1
					when "0011" =>
						SALIDA <= "00"&Instr_S1(31 downto 16);
					-- Instr_P3_S1
					when "0100" =>
						SALIDA <= "00"&Instr_S1(15 downto 0);
					when others =>
						SALIDA <= "00"&X"0000";
				end case;

			-- STAGE 2
			when "0010" =>
				
				case Sel_Value is
					-- OpCode_S2
					when "0000" =>
						SALIDA <= "00"&OpCode_S2;
					-- DirW_S2
					when "0001" =>
						SALIDA <= "00"&DirW_S2;
					-- Dato_op_1_S2
					when "0010" =>
						SALIDA <= "00"&X"00"&Dato_op_1_S2;
					-- Dato_op_2_S2
					when "0011" =>
						SALIDA <= "00"&X"00"&Dato_op_2_S2;
					-- Op_sel_1_S2
					when "0100" =>
						SALIDA <= X"0000"&Op_sel_1_S2;
					-- Op_sel_2_S2
					when "0101" =>
						SALIDA <= X"0000"&Op_sel_2_S2;
					-- Dir_mem_op_1_S2
					when "0110" =>
						SALIDA <= "00"&Dir_mem_op_1_S2;
					-- Dir_mem_op_2_S2
					when "0111" =>
						SALIDA <= "00"&Dir_mem_op_2_S2;
					-- Reg_0004_MinX_S2
					when "1000" =>
						SALIDA <= "00"&X"00"&Reg_0005_MinX_S2;
					-- Reg_0005_MinY_S2
					when "1001" =>
						SALIDA <= "00"&X"00"&Reg_0006_MinY_S2;
					-- Reg_0006_MaxX_S2
					when "1010" =>
						SALIDA <= "00"&X"00"&Reg_0007_MaxX_S2;
					-- Reg_0007_MaxY_S2
					when "1011" =>
						SALIDA <= "00"&X"00"&Reg_0008_MaxY_S2;
					when others =>
						SALIDA <= "00"&X"0000";
				end case;
			
			-- STAGE 3
			when "0011" =>

				case Sel_Value is
					-- OpCode_S3
					when "0000" =>
						SALIDA <= "00"&OpCode_S3;
					-- DirW_S3
					when "0001" =>
						SALIDA <= "00"&DirW_S3;
					-- Dato_op_1_S3
					when "0010" =>
						SALIDA <= "00"&X"00"&Dato_op_1_S3;
					-- Dato_op_2_S3
					when "0011" =>
						SALIDA <= "00"&X"00"&Dato_op_2_S3;
					when others =>
						SALIDA <= "00"&X"0000";
				end case;
			
			-- STAGE 4
			when "0100" =>

				case Sel_Value is
					-- OpCode_S4
					when "0000" =>
						SALIDA <= "00"&OpCode_S4;
					-- DirW_S4
					when "0001" =>
						SALIDA <= "00"&DirW_S4;
					-- Dato_op_1_S4
					when "0010" =>
						SALIDA <= "00"&X"00"&Dato_op_1_S4;
					-- Dato_op_2_S4
					when "0011" =>
						SALIDA <= "00"&X"00"&Dato_op_2_S4;
					when others =>
						SALIDA <= "00"&X"0000";
				end case;

			-- STAGE 5
			when "0101" =>

				case Sel_Value is
					-- OpCode_S5
					when "0000" =>
						SALIDA <= "00"&OpCode_S5;
					-- DirW_S5
					when "0001" =>
						SALIDA <= "00"&DirW_S5;
					-- Resultado_S5
					when "0010" =>
						SALIDA <= "00"&Resultado_S5;
					-- Flags_S5
					when "0011" =>
						SALIDA <= "00"&X"00"&Flags_S5;
					when others =>
						SALIDA <= "00"&X"0000";
				end case;

			-- STAGE 6
			when "0110" =>

				case Sel_Value is
					-- OpCode_S6
					when "0000" =>
						SALIDA <= "00"&OpCode_S6;
					-- DirW_S6
					when "0001" =>
						SALIDA <= "00"&DirW_S6;
					-- Resultado_S6
					when "0010" =>
						SALIDA <= "00"&Resultado_S6;
					-- Flags_S6
					when "0011" =>
						SALIDA <= "00"&X"00"&Flags_S6;
					when others =>
						SALIDA <= "00"&X"0000";
				end case;
			
			-- STAGE 7
			when "0111" =>

				case Sel_Value is
					-- PC_EnaW_S7
					when "0000" =>
						SALIDA <= "0"&X"0000"&PC_EnaW_S7;
					-- Reg_EnaW_S7
					when "0001" =>
						SALIDA <= "0"&X"0000"&Reg_EnaW_S7;
					-- Mem_EnaW_S7
					when "0010" =>
						SALIDA <= "0"&X"0000"&Mem_EnaW_S7;
					-- DatoW_S7
					when "0011" =>
						SALIDA <= "00"&X"00"&DatoW_S7;
					-- DirW_S7
					when "0100" =>
						SALIDA <= "00"&DirW_S7;
					-- EnaDeten_S7
					when "0101" =>
						SALIDA <= "0"&X"0000"&EnaDeten_S7;
					when others =>
						SALIDA <= "00"&X"0000";
				end case;
				
			when others =>
				SALIDA <= "00"&X"0000";
		end case;

	end process;
end Behavioral;