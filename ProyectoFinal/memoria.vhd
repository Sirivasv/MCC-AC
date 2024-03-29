library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity memoria is
Port (
	Dir_in: in unsigned(15 downto 0); -- Bis de direcciones de 16 bits
	Data_out: out unsigned(63 downto 0) -- Bus de datos de 8 bits
);
end memoria;

architecture Behavioral of memoria is
-- Program Instructions

-- STARTING NOP 
signal Dir_0000: unsigned (63 downto 0) := X"0000000000000000";

-- Register $0 -- Resultado resta contador
-- swr $1, #$0007 -- (2n - 1) -- 7
signal Dir_0001: unsigned (63 downto 0) := X"0001000100070000";
-- swr $2, #$0000 -- 2i
signal Dir_0002: unsigned (63 downto 0) := X"0001000200000000";
-- swr $3, #$0001 -- 2i + 1
signal Dir_0003: unsigned (63 downto 0) := X"0001000300010000";
-- swr $4, #$0001 -- 2i + 1
signal Dir_0004: unsigned (63 downto 0) := X"0001000400010000";
-- swr $5, #$0003 -- minX
signal Dir_0005: unsigned (63 downto 0) := X"0001000500030000";
-- swr $6, #$0007 -- minY
signal Dir_0006: unsigned (63 downto 0) := X"0001000600070000";
-- swr $7, #$0003 -- maxX
signal Dir_0007: unsigned (63 downto 0) := X"0001000700030000";
-- swr $8, #$0007 -- maxY
signal Dir_0008: unsigned (63 downto 0) := X"0001000800070000";
-- sw $0, #$0003 -- X1
signal Dir_0009: unsigned (63 downto 0) := X"0002000000030000";
-- sw $1, #$0007 -- Y1
signal Dir_000A: unsigned (63 downto 0) := X"0002000100070000";
-- sw $2, #$0005 -- X2
signal Dir_000B: unsigned (63 downto 0) := X"0002000200050000";
-- sw $3, #$0004 -- Y2
signal Dir_000C: unsigned (63 downto 0) := X"0002000300040000";
-- sw $4, #$0006 -- X3
signal Dir_000D: unsigned (63 downto 0) := X"0002000400060000";
-- sw $5, #$0007 -- Y3
signal Dir_000E: unsigned (63 downto 0) := X"0002000500070000";
-- sw $6, #$0001 -- X4
signal Dir_000F: unsigned (63 downto 0) := X"0002000600010000";
-- sw $7, #$0005 -- Y4
signal Dir_0010: unsigned (63 downto 0) := X"0002000700050000";
-- checkVals:add $4, #0, $3 
signal Dir_0011: unsigned (63 downto 0) := X"0003000400000003";
-- str_if_neg_sub $5, 0($2), $5 
signal Dir_0012: unsigned (63 downto 0) := X"0004000500020005";
-- str_if_neg_sub $7, $7, 0($2)
signal Dir_0013: unsigned (63 downto 0) := X"0005000700070002";
-- add $2, #2, $2
signal Dir_0014: unsigned (63 downto 0) := X"0003000200020002";
-- str_if_neg_sub $6, 0($3), $6
signal Dir_0015: unsigned (63 downto 0) := X"0004000600030006";
-- str_if_neg_sub $8, $8, 0($3)
signal Dir_0016: unsigned (63 downto 0) := X"0005000800080003";
-- add $3, #2, $3
signal Dir_0017: unsigned (63 downto 0) := X"0003000300020003";
-- sub $0, $1, $4
signal Dir_0018: unsigned (63 downto 0) := X"0006000000010004";
-- BEQ FIN
signal Dir_0019: unsigned (63 downto 0) := X"0007001B00000000";
-- BRA checkVals
signal Dir_001A: unsigned (63 downto 0) := X"0008001100000000";
-- FIN: BRA FIN
signal Dir_001B: unsigned (63 downto 0) := X"0008001B00000000";

begin
process(Dir_in)
    begin
        case Dir_in is
    
            when X"0000" => 
                Data_out <= Dir_0000;
            when X"0001" => 
                Data_out <= Dir_0001;
            when X"0002" => 
                Data_out <= Dir_0002;
            when X"0003" => 
                Data_out <= Dir_0003;
            when X"0004" => 
                Data_out <= Dir_0004;
            when X"0005" => 
                Data_out <= Dir_0005;
            when X"0006" => 
                Data_out <= Dir_0006;
            when X"0007" => 
                Data_out <= Dir_0007;
            when X"0008" => 
                Data_out <= Dir_0008;
            when X"0009" => 
                Data_out <= Dir_0009;
            when X"000A" => 
                Data_out <= Dir_000A;
            when X"000B" => 
                Data_out <= Dir_000B;
            when X"000C" => 
                Data_out <= Dir_000C;
            when X"000D" => 
                Data_out <= Dir_000D;
            when X"000E" => 
                Data_out <= Dir_000E;
            when X"000F" => 
                Data_out <= Dir_000F;
            when X"0010" => 
                Data_out <= Dir_0010;
            when X"0011" => 
                Data_out <= Dir_0011;
            when X"0012" => 
                Data_out <= Dir_0012;
            when X"0013" => 
                Data_out <= Dir_0013;
            when X"0014" => 
                Data_out <= Dir_0014;
            when X"0015" => 
                Data_out <= Dir_0015;
            when X"0016" => 
                Data_out <= Dir_0016;
            when X"0017" => 
                Data_out <= Dir_0017;
            when X"0018" => 
                Data_out <= Dir_0018;
            when X"0019" => 
                Data_out <= Dir_0019;
            when X"001A" => 
                Data_out <= Dir_001A;
				when X"001B" => 
                Data_out <= Dir_001B;
				when others =>
					Data_out <= X"0000000000000000";

        end case;
    end process;
end Behavioral;