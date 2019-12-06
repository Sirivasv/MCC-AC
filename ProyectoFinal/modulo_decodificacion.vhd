library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity modulo_decodificacion is
	Port (
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		Instr: in unsigned(63 downto 0);
		PC: in unsigned(15 downto 0);
		EnaW: in std_logic;
      DatoW: in unsigned(7 downto 0);
		RegWSel: in unsigned(15 downto 0);
      OpCode_out: out unsigned(15 downto 0);
      DirW_out: out unsigned(15 downto 0);
		Dato_op_1: out unsigned(7 downto 0);
		Dato_op_2: out unsigned(7 downto 0);
		Op_Sel_out_1: out unsigned(1 downto 0);
      Op_Sel_out_2: out unsigned(1 downto 0);
		Dir_Mem_op_1: out unsigned(15 downto 0);
		Dir_Mem_op_2: out unsigned(15 downto 0);
		-- DEBUG OUTPUTS
		Debug_Reg_0004: out unsigned(7 downto 0);
		Debug_Reg_0005: out unsigned(7 downto 0);
		Debug_Reg_0006: out unsigned(7 downto 0);
		Debug_Reg_0007: out unsigned(7 downto 0)
        -- Op_Sel_out1 and Op_Sel_out2 TABLE
        -- 00 Dato_op_1
        -- 01 Dato_op_2
        -- 10 DATA IN Dir_Mem_op_1
        -- 11 DATA IN Dir_Mem_op_2
	);
end modulo_decodificacion;

architecture Behavioral of modulo_decodificacion is
	-- Data Registers
	signal Reg_0000: unsigned (7 downto 0) := X"00";
	signal Reg_0001: unsigned (7 downto 0) := X"00";
	signal Reg_0002: unsigned (7 downto 0) := X"00";
	signal Reg_0003: unsigned (7 downto 0) := X"00";
	signal Reg_0004: unsigned (7 downto 0) := X"00";
	signal Reg_0005: unsigned (7 downto 0) := X"00";
	signal Reg_0006: unsigned (7 downto 0) := X"00";
	signal Reg_0007: unsigned (7 downto 0) := X"00";

begin
	process (clk,reset,EnaW, RegWSel, Instr)
    variable OpCode : unsigned(15 downto 0);
    variable DirW : unsigned(15 downto 0);
    variable RegOp1 : unsigned(15 downto 0);
    variable RegDatoOp1 : unsigned(7 downto 0);
    variable RegOp2 : unsigned(15 downto 0);
    variable RegDatoOp2 : unsigned(7 downto 0);
    variable MemOp1 : unsigned(15 downto 0);
    variable MemOp2 : unsigned(15 downto 0);
    variable DatoOp1 : unsigned(15 downto 0);
    variable DatoOp2 : unsigned(15 downto 0);
    begin
		if reset='0' then 
            Reg_0000 <= X"00";
            Reg_0001 <= X"00";
            Reg_0002 <= X"00";
            Reg_0003 <= X"00";
            Reg_0004 <= X"00";
            Reg_0005 <= X"00";
            Reg_0006 <= X"00";
            Reg_0007 <= X"00";
		elsif rising_edge (clk) then
			if EnaW='1' then
				case RegWSel is
                    when X"0000" =>
                         Reg_0000 <= DatoW;
                    when X"0001" =>
                         Reg_0001 <= DatoW;
                    when X"0002" =>
                         Reg_0002 <= DatoW;
                    when X"0003" =>
                         Reg_0003 <= DatoW;
                    when X"0004" =>
                         Reg_0004 <= DatoW;
                    when X"0005" =>
                         Reg_0005 <= DatoW;
                    when X"0006" =>
                         Reg_0006 <= DatoW;
                    when X"0007" =>
                         Reg_0007 <= DatoW;
                end case;
			end if;
		
            
				  OpCode := Instr(63 downto 48);
				  DirW := Instr(47 downto 32);
				  RegOp1 := Instr(31 downto 16);
				  RegOp2 := Instr(15 downto 0);
				  MemOp1 := Instr(31 downto 16);
				  MemOp2 := Instr(15 downto 0);
				  DatoOp1 := Instr(31 downto 16);
				  DatoOp2 := Instr(15 downto 0);

				  -- Obtenemos los valores de los registros
				  -- Dato de registro 1
				  case RegOp1 is
						when X"0000" =>
							 RegDatoOp1 := Reg_0000;
						when X"0001" =>
							 RegDatoOp1 := Reg_0001;
						when X"0002" =>
							 RegDatoOp1 := Reg_0002;
						when X"0003" =>
							 RegDatoOp1 := Reg_0003;
						when X"0004" =>
							 RegDatoOp1 := Reg_0004;
						when X"0005" =>
							 RegDatoOp1 := Reg_0005;
						when X"0006" =>
							 RegDatoOp1 := Reg_0006;
						when X"0007" =>
							 RegDatoOp1 := Reg_0007;
				  end case;
				  -- Dato de registro 2
				  case RegOp2 is
						when X"0000" =>
							 RegDatoOp2 := Reg_0000;
						when X"0001" =>
							 RegDatoOp2 := Reg_0001;
						when X"0002" =>
							 RegDatoOp2 := Reg_0002;
						when X"0003" =>
							 RegDatoOp2 := Reg_0003;
						when X"0004" =>
							 RegDatoOp2 := Reg_0004;
						when X"0005" =>
							 RegDatoOp2 := Reg_0005;
						when X"0006" =>
							 RegDatoOp2 := Reg_0006;
						when X"0007" =>
							 RegDatoOp2 := Reg_0007;
				  end case;
				  
				  case OpCode is
				  
						-- NOP
						when X"0000" =>

							 OpCode_out <= OpCode;
							 Dato_op_1 <= X"00";
							 Dato_op_2 <= X"00";
							 Dir_Mem_op_1 <= X"0000";
							 Dir_Mem_op_2 <= X"0000";
							 Op_Sel_out_1 <= "00";
							 Op_Sel_out_2 <= "00"; 
							 DirW_out <= X"0000";
						
						-- STORE IN REGISTER
						-- swr <Register_To_Write>, <Value>
						-- Ejemplo: swr $5, #$0007
						-- 0001 0005 0007 0000
						when X"0001" =>

							 OpCode_out <= OpCode;
							 Dato_op_1 <= DatoOp1;
							 Dato_op_2 <= X"00";
							 Dir_Mem_op_1 <= X"0000";
							 Dir_Mem_op_2 <= X"0000";
							 Op_Sel_out_1 <= "00";
							 Op_Sel_out_2 <= "00";
							 DirW_out <= DirW;
						
						-- STORE IN MEMORY
						-- sw <Address_To_Write>, <Value>
						-- Ejemplo: sw $5, #$0003
						-- 0002 0005 0003 0000
						when X"0002" =>

							 OpCode_out <= OpCode;
							 Dato_op_1 <= DatoOp1;
							 Dato_op_2 <= X"00";
							 Dir_Mem_op_1 <= X"0000";
							 Dir_Mem_op_2 <= X"0000";
							 Op_Sel_out_1 <= "00";
							 Op_Sel_out_2 <= "00";
							 DirW_out <= DirW;

						-- ADD TO REGISTER
						-- add <Register_To_Write>, <Value>, <Register_Operand>
						-- Ejemplo: add $2, #1, $2
						-- 0003 0002 0001 0002
						when X"0003" =>

							 OpCode_out <= OpCode;
							 Dato_op_1 <= DatoOp1;
							 Dato_op_2 <= RegDatoOp2;
							 Dir_Mem_op_1 <= X"0000";
							 Dir_Mem_op_2 <= X"0000";
							 Op_Sel_out_1 <= "00";
							 Op_Sel_out_2 <= "01";
							 DirW_out <= DirW;

						-- STORE IF THE RESULT OF THE SUBSTRACION IS NEGATIVE
						-- str_if_neg_sub <Register_To_Write>, <Address_of_memory>, <Register_Operand>
						-- Ejemplo: str_if_neg_sub $5, 0($3), $5
						-- 0004 0005 0003 0005
						when X"0004" =>

							 OpCode_out <= OpCode;
							 Dato_op_1 <= X"0000";
							 Dato_op_2 <= RegDatoOp2;
							 Dir_Mem_op_1 <= MemOp1;
							 Dir_Mem_op_2 <= X"0000";
							 Op_Sel_out_1 <= "10";
							 Op_Sel_out_2 <= "01";
							 DirW_out <= DirW;
						
						-- STORE IF THE RESULT OF THE SUBSTRACION IS NEGATIVE
						-- str_if_neg_sub <Register_To_Write>, <Register_Operand>, <Address_of_memory>
						-- Ejemplo: str_if_neg_sub $6, $6, 0($2)
						-- 0005 0006 0006 0002
						when X"0005" =>

							 OpCode_out <= OpCode;
							 Dato_op_1 <= RegDatoOp1;
							 Dato_op_2 <= X"0000";
							 Dir_Mem_op_1 <= X"0000";
							 Dir_Mem_op_2 <= MemOp2;
							 Op_Sel_out_1 <= "00";
							 Op_Sel_out_2 <= "11";
							 DirW_out <= DirW;

						-- SUBSTRACT TWO REGISTERS
						-- sub <Register_To_Write>, <Register_Operand>, <Register_Operand>
						-- Ejemplo: sub $0, $1, $3
						-- 0006 0000 0001 0003
						when X"0006" =>

							 OpCode_out <= OpCode;
							 Dato_op_1 <= RegDatoOp1;
							 Dato_op_2 <= RegDatoOp2;
							 Dir_Mem_op_1 <= X"0000";
							 Dir_Mem_op_2 <= X"0000";
							 Op_Sel_out_1 <= "00";
							 Op_Sel_out_2 <= "01";
							 DirW_out <= DirW;
						
						-- BRANCH IF EQUAL, the zero flag is enable
						-- BEQ <TAG>
						-- Ejemplo: BEQ FINAL 
						-- 0007 001A 0000 0000
						-- The tag after compilation is the new value for the PC
						when X"0007" =>

							 OpCode_out <= OpCode;
							 Dato_op_1 <= X"0000";
							 Dato_op_2 <= X"0000";
							 Dir_Mem_op_1 <= X"0000";
							 Dir_Mem_op_2 <= X"0000";
							 Op_Sel_out_1 <= "00";
							 Op_Sel_out_2 <= "00";
							 DirW_out <= DirW;
						
						-- BRANCH
						-- BRA <TAG>
						-- Ejemplo: BRA CHECK 
						-- 0008 0011 0000 0000
						-- The tag after compilation is the new value for the PC
						when X"0008" =>

							 OpCode_out <= OpCode;
							 Dato_op_1 <= X"0000";
							 Dato_op_2 <= X"0000";
							 Dir_Mem_op_1 <= X"0000";
							 Dir_Mem_op_2 <= X"0000";
							 Op_Sel_out_1 <= "00";
							 Op_Sel_out_2 <= "00";
							 DirW_out <= DirW;
							 
				end case;
				Debug_Reg_0004 <= Reg_0004;
				Debug_Reg_0005 <= Reg_0005;
				Debug_Reg_0006 <= Reg_0006;
				Debug_Reg_0007 <= Reg_0007;
		end if;
	end process;
end Behavioral;