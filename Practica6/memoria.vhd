library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity memoria is
Port (
	clk: in STD_LOGIC;
	reset: in STD_LOGIC;
	Dir_in: in unsigned(15 downto 0); -- Bis de direcciones de 16 bits
	nRW: in STD_LOGIC:= '1';
	Data_out: out unsigned(7 downto 0); -- Bus de datos de 8 bits
	Data_in: in unsigned(7 downto 0); -- Bus de datos de 8 bits
	Dir_0010_out: out unsigned(7 downto 0); -- Bus de datos de 8 bits 
	Dir_0011_out: out unsigned(7 downto 0); -- Bus de datos de 8 bits 
	Dir_0012_out: out unsigned(7 downto 0) -- Bus de datos de 8 bits 
);
end memoria;

architecture Behavioral of memoria is
-- Testing Signals
signal Dir_0010: unsigned (7 downto 0) := X"00";
signal Dir_0011: unsigned (7 downto 0) := X"00";
signal Dir_0012: unsigned (7 downto 0) := X"00";

-- Directions for interruptions Operations
signal Dir_0020: unsigned (7 downto 0) := X"06";
signal Dir_0030: unsigned (7 downto 0) := X"04";

-- Program Instructions
-- LDAA #$FF
signal Dir_0044: unsigned (7 downto 0) := X"86";
signal Dir_0045: unsigned (7 downto 0) := X"FF";
-- LDAB #$01
signal Dir_0046: unsigned (7 downto 0) := X"C6";
signal Dir_0047: unsigned (7 downto 0) := X"01";
-- LDX #$0010
signal Dir_0048: unsigned (7 downto 0) := X"CE";
signal Dir_0049: unsigned (7 downto 0) := X"00";
signal Dir_004A: unsigned (7 downto 0) := X"10";
-- ABA
signal Dir_004B: unsigned (7 downto 0) := X"1B";
-- BNE ET1
signal Dir_004C: unsigned (7 downto 0) := X"26";
signal Dir_004D: unsigned (7 downto 0) := X"04";
-- STAA 0,X
signal Dir_004E: unsigned (7 downto 0) := X"A7";
signal Dir_004F: unsigned (7 downto 0) := X"00";
-- BRA ET2
signal Dir_0050: unsigned (7 downto 0) := X"20";
signal Dir_0051: unsigned (7 downto 0) := X"02";
-- ET1: STAB 0,X
signal Dir_0052: unsigned (7 downto 0) := X"E7";
signal Dir_0053: unsigned (7 downto 0) := X"00";
-- ET2: LDAA #$07
signal Dir_0054: unsigned (7 downto 0) := X"86";
signal Dir_0055: unsigned (7 downto 0) := X"07";
-- LDAB #$02
signal Dir_0056: unsigned (7 downto 0) := X"C6";
signal Dir_0057: unsigned (7 downto 0) := X"02";
-- MUL
signal Dir_0058: unsigned (7 downto 0) := X"3D";
-- STAA 1,X
signal Dir_0059: unsigned (7 downto 0) := X"A7";
signal Dir_005A: unsigned (7 downto 0) := X"01";
-- STAB 2,X
signal Dir_005B: unsigned (7 downto 0) := X"E7";
signal Dir_005C: unsigned (7 downto 0) := X"02";
-- INCA
signal Dir_005D: unsigned (7 downto 0) := X"4C";
-- CLRB
signal Dir_005E: unsigned (7 downto 0) := X"5F";
-- FIN: BRA FIN
signal Dir_005F: unsigned (7 downto 0) := X"20";
signal Dir_0060: unsigned (7 downto 0) := X"FE";

-- DRIVER X
-- LDX #$0020
signal Dir_0070: unsigned (7 downto 0) := X"CE";
signal Dir_0071: unsigned (7 downto 0) := X"00";
signal Dir_0072: unsigned (7 downto 0) := X"20";
-- LDAA $0030
signal Dir_0073: unsigned (7 downto 0) := X"B6";
signal Dir_0074: unsigned (7 downto 0) := X"00";
signal Dir_0075: unsigned (7 downto 0) := X"30";
-- STAA 0,X
signal Dir_0076: unsigned (7 downto 0) := X"A7";
signal Dir_0077: unsigned (7 downto 0) := X"00";
-- RTI
signal Dir_0078: unsigned (7 downto 0) := X"3B";

-- DRIVER Y
-- LDX #$0030
signal Dir_0079: unsigned (7 downto 0) := X"CE";
signal Dir_007A: unsigned (7 downto 0) := X"00";
signal Dir_007B: unsigned (7 downto 0) := X"30";
-- LDAB $0020
signal Dir_007C: unsigned (7 downto 0) := X"F6";
signal Dir_007D: unsigned (7 downto 0) := X"00";
signal Dir_007E: unsigned (7 downto 0) := X"20";
-- STAB 0,X
signal Dir_007F: unsigned (7 downto 0) := X"E7";
signal Dir_0080: unsigned (7 downto 0) := X"00";
-- RTI
signal Dir_0081: unsigned (7 downto 0) := X"3B";

-- PILA
signal Dir_FFD0: unsigned (7 downto 0) := X"00";
signal Dir_FFD1: unsigned (7 downto 0) := X"00";
signal Dir_FFD2: unsigned (7 downto 0) := X"00";
signal Dir_FFD3: unsigned (7 downto 0) := X"00";
signal Dir_FFD4: unsigned (7 downto 0) := X"00";
signal Dir_FFD5: unsigned (7 downto 0) := X"00";
signal Dir_FFD6: unsigned (7 downto 0) := X"00";
signal Dir_FFD7: unsigned (7 downto 0) := X"00";
signal Dir_FFD8: unsigned (7 downto 0) := X"00";
signal Dir_FFD9: unsigned (7 downto 0) := X"00";
signal Dir_FFDA: unsigned (7 downto 0) := X"00";
signal Dir_FFDB: unsigned (7 downto 0) := X"00";
signal Dir_FFDC: unsigned (7 downto 0) := X"00";
signal Dir_FFDD: unsigned (7 downto 0) := X"00";
signal Dir_FFDE: unsigned (7 downto 0) := X"00";
signal Dir_FFDF: unsigned (7 downto 0) := X"00";
signal Dir_FFF0: unsigned (7 downto 0) := X"00";
signal Dir_FFF1: unsigned (7 downto 0) := X"00";
signal Dir_FFF2: unsigned (7 downto 0) := X"00";
signal Dir_FFF3: unsigned (7 downto 0) := X"00";
signal Dir_FFF4: unsigned (7 downto 0) := X"00";
signal Dir_FFF5: unsigned (7 downto 0) := X"00";
signal Dir_FFF6: unsigned (7 downto 0) := X"00";
signal Dir_FFF7: unsigned (7 downto 0) := X"00";
signal Dir_FFF8: unsigned (7 downto 0) := X"00";
signal Dir_FFF9: unsigned (7 downto 0) := X"00";
signal Dir_FFFA: unsigned (7 downto 0) := X"00";
signal Dir_FFFB: unsigned (7 downto 0) := X"00";
signal Dir_FFFC: unsigned (7 downto 0) := X"00";
signal Dir_FFFD: unsigned (7 downto 0) := X"00";
signal Dir_FFFE: unsigned (7 downto 0) := X"00";
signal Dir_FFFF: unsigned (7 downto 0) := X"00";
begin
process(clk, reset,nRW, Dir_in)
begin
if (reset = '0') then
	Data_out <= X"00";
	-- Testing Signals
	Dir_0010 <= X"00";
	Dir_0011 <= X"00";
	Dir_0012 <= X"00";

	-- Directions for interruptions Operations
	Dir_0020 <= X"06";
	Dir_0030 <= X"04";

	-- Program Instructions
	-- LDAA #$FF
	Dir_0044 <= X"86";
	Dir_0045 <= X"FF";
	-- LDAB #$01
	Dir_0046 <= X"C6";
	Dir_0047 <= X"01";
	-- LDX #$0010
	Dir_0048 <= X"CE";
	Dir_0049 <= X"00";
	Dir_004A <= X"10";
	-- ABA
	Dir_004B <= X"1B";
	-- BNE ET1
	Dir_004C <= X"26";
	Dir_004D <= X"04";
	-- STAA 0,X
	Dir_004E <= X"A7";
	Dir_004F <= X"00";
	-- BRA ET2
	Dir_0050 <= X"20";
	Dir_0051 <= X"02";
	-- ET1: STAB 0,X
	Dir_0052 <= X"E7";
	Dir_0053 <= X"00";
	-- ET2: LDAA #$07
	Dir_0054 <= X"86";
	Dir_0055 <= X"07";
	-- LDAB #$02
	Dir_0056 <= X"C6";
	Dir_0057 <= X"02";
	-- MUL
	Dir_0058 <= X"3D";
	-- STAA 1,X
	Dir_0059 <= X"A7";
	Dir_005A <= X"01";
	-- STAB 2,X
	Dir_005B <= X"E7";
	Dir_005C <= X"02";
	-- INCA
	Dir_005D <= X"4C";
	-- CLRB
	Dir_005E <= X"5F";
	-- FIN: BRA FIN
	Dir_005F <= X"20";
	Dir_0060 <= X"FE";

	-- DRIVER X
	-- LDX #$0020
	Dir_0070 <= X"CE";
	Dir_0071 <= X"00";
	Dir_0072 <= X"20";
	-- LDAA $0030
	Dir_0073 <= X"B6";
	Dir_0074 <= X"00";
	Dir_0075 <= X"30";
	-- STAA 0,X
	Dir_0076 <= X"A7";
	Dir_0077 <= X"00";
	-- RTI
	Dir_0078 <= X"3B";

	-- DRIVER Y
	-- LDX #$0030
	Dir_0079 <= X"CE";
	Dir_007A <= X"00";
	Dir_007B <= X"30";
	-- LDAB $0020
	Dir_007C <= X"F6";
	Dir_007D <= X"00";
	Dir_007E <= X"20";
	-- STAB 0,X
	Dir_007F <= X"E7";
	Dir_0080 <= X"00";
	-- RTI
	Dir_0081 <= X"3B";

	-- PILA
	Dir_FFD0 <= X"00";
	Dir_FFD1 <= X"00";
	Dir_FFD2 <= X"00";
	Dir_FFD3 <= X"00";
	Dir_FFD4 <= X"00";
	Dir_FFD5 <= X"00";
	Dir_FFD6 <= X"00";
	Dir_FFD7 <= X"00";
	Dir_FFD8 <= X"00";
	Dir_FFD9 <= X"00";
	Dir_FFDA <= X"00";
	Dir_FFDB <= X"00";
	Dir_FFDC <= X"00";
	Dir_FFDD <= X"00";
	Dir_FFDE <= X"00";
	Dir_FFDF <= X"00";
	Dir_FFF0 <= X"00";
	Dir_FFF1 <= X"00";
	Dir_FFF2 <= X"00";
	Dir_FFF3 <= X"00";
	Dir_FFF4 <= X"00";
	Dir_FFF5 <= X"00";
	Dir_FFF6 <= X"00";
	Dir_FFF7 <= X"00";
	Dir_FFF8 <= X"00";
	Dir_FFF9 <= X"00";
	Dir_FFFA <= X"00";
	Dir_FFFB <= X"00";
	Dir_FFFC <= X"00";
	Dir_FFFD <= X"00";
	Dir_FFFE <= X"00";
	Dir_FFFF <= X"00";
else
	if (rising_edge(clk)) then
		if (nRW = '1') then
			case Dir_in is
			-- LDAA #$FF
			when X"0044" =>
				Data_out <= Dir_0044;
			when X"0045" =>
				Data_out <= Dir_0045;
			
			-- LDAB #$01
			when X"0046" =>
				Data_out <= Dir_0046;
			when X"0047" =>
				Data_out <= Dir_0047;
			
			-- LDX #$0010
			when X"0048" =>
				Data_out <= Dir_0048;
			when X"0049" =>
				Data_out <= Dir_0049;
			when X"004A" =>
				Data_out <= Dir_004A;
			
			-- ABA
			when X"004B" =>
				Data_out <= Dir_004B;
			
			-- BNE ET1
			when X"004C" =>
				Data_out <= Dir_004C;
			when X"004D" =>
				Data_out <= Dir_004D;
			
			-- STAA 0,X
			when X"004E" =>
				Data_out <= Dir_004E;
			when X"004F" =>
				Data_out <= Dir_004F;
			
			-- BRA ET2
			when X"0050" =>
				Data_out <= Dir_0050;
			when X"0051" =>
				Data_out <= Dir_0051;
			
			-- ET1: STAB 0,X
			when X"0052" =>
				Data_out <= Dir_0052;
			when X"0053" =>
				Data_out <= Dir_0053;
			
			-- ET2: LDAA #$07
			when X"0054" =>
				Data_out <= Dir_0054;
			when X"0055" =>
				Data_out <= Dir_0055;
			
			-- LDAB #$02
			when X"0056" =>
				Data_out <= Dir_0056;
			when X"0057" =>
				Data_out <= Dir_0057;
				
			-- MUL
			when X"0058" =>
				Data_out <= Dir_0058;
			
			-- STAA 1,X
			when X"0059" =>
				Data_out <= Dir_0059;
			when X"005A" =>
				Data_out <= Dir_005A;
			
			-- STAB 2,X
			when X"005B" =>
				Data_out <= Dir_005B;
			when X"005C" =>
				Data_out <= Dir_005C;
			
			-- INCA
			when X"005D" =>
				Data_out <= Dir_005D;
			-- CLRB
			when X"005E" =>
				Data_out <= Dir_005E;
			
			-- FIN: BRA FIN
			when X"005F" =>
				Data_out <= Dir_005F;
			when X"0060" =>
				Data_out <= Dir_0060;
			
			-- DRIVER X
			-- LDX #$0020
			when X"0070" =>
			 Data_out <= Dir_0070;
			when X"0071" =>
			 Data_out <= Dir_0071;
			when X"0072" =>
			 Data_out <= Dir_0072;
			-- LDAA $0030
			when X"0073" =>
			 Data_out <= Dir_0073;
			when X"0074" =>
			 Data_out <= Dir_0074;
			when X"0075" =>
			 Data_out <= Dir_0075;
			-- STAA 0,X
			when X"0076" =>
			 Data_out <= Dir_0076;
			when X"0077" =>
			 Data_out <= Dir_0077;
			-- RTI
			when X"0078" =>
			 Data_out <= Dir_0078;

			-- DRIVER Y
			-- LDX #$0030
			when X"0079" =>
			 Data_out <= Dir_0079;
			when X"007A" =>
			 Data_out <= Dir_007A;
			when X"007B" =>
			 Data_out <= Dir_007B;
			-- LDAB $0020
			when X"007C" =>
			 Data_out <= Dir_007C;
			when X"007D" =>
			 Data_out <= Dir_007D;
			when X"007E" =>
			 Data_out <= Dir_007E;
			-- STAB 0,X
			when X"007F" =>
			 Data_out <= Dir_007F;
			when X"0080" =>
			 Data_out <= Dir_0080;
			-- RTI
			when X"0081" =>
			 Data_out <= Dir_0081;
			
			-- PILA
			when X"FFD0" =>
				 Data_out <= Dir_FFD0;
			when X"FFD1" =>
				 Data_out <= Dir_FFD1;
			when X"FFD2" =>
				 Data_out <= Dir_FFD2;
			when X"FFD3" =>
				 Data_out <= Dir_FFD3;
			when X"FFD4" =>
				 Data_out <= Dir_FFD4;
			when X"FFD5" =>
				 Data_out <= Dir_FFD5;
			when X"FFD6" =>
				 Data_out <= Dir_FFD6;
			when X"FFD7" =>
				 Data_out <= Dir_FFD7;
			when X"FFD8" =>
				 Data_out <= Dir_FFD8;
			when X"FFD9" =>
				 Data_out <= Dir_FFD9;
			when X"FFDA" =>
				 Data_out <= Dir_FFDA;
			when X"FFDB" =>
				 Data_out <= Dir_FFDB;
			when X"FFDC" =>
				 Data_out <= Dir_FFDC;
			when X"FFDD" =>
				 Data_out <= Dir_FFDD;
			when X"FFDE" =>
				 Data_out <= Dir_FFDE;
			when X"FFDF" =>
				 Data_out <= Dir_FFDF;
			when X"FFF0" =>
				 Data_out <= Dir_FFF0;
			when X"FFF1" =>
				 Data_out <= Dir_FFF1;
			when X"FFF2" =>
				 Data_out <= Dir_FFF2;
			when X"FFF3" =>
				 Data_out <= Dir_FFF3;
			when X"FFF4" =>
				 Data_out <= Dir_FFF4;
			when X"FFF5" =>
				 Data_out <= Dir_FFF5;
			when X"FFF6" =>
				 Data_out <= Dir_FFF6;
			when X"FFF7" =>
				 Data_out <= Dir_FFF7;
			when X"FFF8" =>
				 Data_out <= Dir_FFF8;
			when X"FFF9" =>
				 Data_out <= Dir_FFF9;
			when X"FFFA" =>
				 Data_out <= Dir_FFFA;
			when X"FFFB" =>
				 Data_out <= Dir_FFFB;
			when X"FFFC" =>
				 Data_out <= Dir_FFFC;
			when X"FFFD" =>
				 Data_out <= Dir_FFFD;
			when X"FFFE" =>
				 Data_out <= Dir_FFFE;
			when X"FFFF" =>
				 Data_out <= Dir_FFFF;
			
			when others =>
				Data_out <= X"00";
			end case;
		else
			case Dir_in is
			when X"0010" =>
				 Dir_0010 <= Data_in;
			when X"0011" =>
				 Dir_0011 <= Data_in;
			when X"0012" =>
				 Dir_0012 <= Data_in;
			when X"0020" =>
				 Dir_0020 <= Data_in;
			when X"0030" =>
				 Dir_0030 <= Data_in;
			when X"0044" =>
				 Dir_0044 <= Data_in;
			when X"0045" =>
				 Dir_0045 <= Data_in;
			when X"0046" =>
				 Dir_0046 <= Data_in;
			when X"0047" =>
				 Dir_0047 <= Data_in;
			when X"0048" =>
				 Dir_0048 <= Data_in;
			when X"0049" =>
				 Dir_0049 <= Data_in;
			when X"004A" =>
				 Dir_004A <= Data_in;
			when X"004B" =>
				 Dir_004B <= Data_in;
			when X"004C" =>
				 Dir_004C <= Data_in;
			when X"004D" =>
				 Dir_004D <= Data_in;
			when X"004E" =>
				 Dir_004E <= Data_in;
			when X"004F" =>
				 Dir_004F <= Data_in;
			when X"0050" =>
				 Dir_0050 <= Data_in;
			when X"0051" =>
				 Dir_0051 <= Data_in;
			when X"0052" =>
				 Dir_0052 <= Data_in;
			when X"0053" =>
				 Dir_0053 <= Data_in;
			when X"0054" =>
				 Dir_0054 <= Data_in;
			when X"0055" =>
				 Dir_0055 <= Data_in;
			when X"0056" =>
				 Dir_0056 <= Data_in;
			when X"0057" =>
				 Dir_0057 <= Data_in;
			when X"0058" =>
				 Dir_0058 <= Data_in;
			when X"0059" =>
				 Dir_0059 <= Data_in;
			when X"005A" =>
				 Dir_005A <= Data_in;
			when X"005B" =>
				 Dir_005B <= Data_in;
			when X"005C" =>
				 Dir_005C <= Data_in;
			when X"005D" =>
				 Dir_005D <= Data_in;
			when X"005E" =>
				 Dir_005E <= Data_in;
			when X"005F" =>
				 Dir_005E <= Data_in;
			when X"0060" =>
				 Dir_0060 <= Data_in;
				 
			when X"0070" =>
				 Dir_0070 <= Data_in;
			when X"0071" =>
				 Dir_0071 <= Data_in;
			when X"0072" =>
				 Dir_0072 <= Data_in;
			when X"0073" =>
				 Dir_0073 <= Data_in;
			when X"0074" =>
				 Dir_0074 <= Data_in;
			when X"0075" =>
				 Dir_0075 <= Data_in;
			when X"0076" =>
				 Dir_0076 <= Data_in;
			when X"0077" =>
				 Dir_0077 <= Data_in;
			when X"0078" =>
				 Dir_0078 <= Data_in;
			when X"0079" =>
				 Dir_0079 <= Data_in;
			when X"007A" =>
				 Dir_007A <= Data_in;
			when X"007B" =>
				 Dir_007B <= Data_in;
			when X"007C" =>
				 Dir_007C <= Data_in;
			when X"007D" =>
				 Dir_007D <= Data_in;
			when X"007E" =>
				 Dir_007E <= Data_in;
			when X"007F" =>
				 Dir_007F <= Data_in;
			when X"0080" =>
				 Dir_0080 <= Data_in;
			when X"0081" =>
				 Dir_0081 <= Data_in;
				 
				 
			when X"FFD0" =>
				 Dir_FFD0 <= Data_in;
			when X"FFD1" =>
				 Dir_FFD1 <= Data_in;
			when X"FFD2" =>
				 Dir_FFD2 <= Data_in;
			when X"FFD3" =>
				 Dir_FFD3 <= Data_in;
			when X"FFD4" =>
				 Dir_FFD4 <= Data_in;
			when X"FFD5" =>
				 Dir_FFD5 <= Data_in;
			when X"FFD6" =>
				 Dir_FFD6 <= Data_in;
			when X"FFD7" =>
				 Dir_FFD7 <= Data_in;
			when X"FFD8" =>
				 Dir_FFD8 <= Data_in;
			when X"FFD9" =>
				 Dir_FFD9 <= Data_in;
			when X"FFDA" =>
				 Dir_FFDA <= Data_in;
			when X"FFDB" =>
				 Dir_FFDB <= Data_in;
			when X"FFDC" =>
				 Dir_FFDC <= Data_in;
			when X"FFDD" =>
				 Dir_FFDD <= Data_in;
			when X"FFDE" =>
				 Dir_FFDE <= Data_in;
			when X"FFDF" =>
				 Dir_FFDF <= Data_in;
			when X"FFF0" =>
				 Dir_FFF0 <= Data_in;
			when X"FFF1" =>
				 Dir_FFF1 <= Data_in;
			when X"FFF2" =>
				 Dir_FFF2 <= Data_in;
			when X"FFF3" =>
				 Dir_FFF3 <= Data_in;
			when X"FFF4" =>
				 Dir_FFF4 <= Data_in;
			when X"FFF5" =>
				 Dir_FFF5 <= Data_in;
			when X"FFF6" =>
				 Dir_FFF6 <= Data_in;
			when X"FFF7" =>
				 Dir_FFF7 <= Data_in;
			when X"FFF8" =>
				 Dir_FFF8 <= Data_in;
			when X"FFF9" =>
				 Dir_FFF9 <= Data_in;
			when X"FFFA" =>
				 Dir_FFFA <= Data_in;
			when X"FFFB" =>
				 Dir_FFFB <= Data_in;
			when X"FFFC" =>
				 Dir_FFFC <= Data_in;
			when X"FFFD" =>
				 Dir_FFFD <= Data_in;
			when X"FFFE" =>
				 Dir_FFFE <= Data_in;
			when X"FFFF" =>
				 Dir_FFFF <= Data_in;
			
			when others =>
				Dir_FFFF <= Dir_FFFF;
			end case;
		end if;
	end if;
end if;
-- TESTING SIGNALS
Dir_0010_out <= Dir_0010; 
Dir_0011_out <= Dir_0011;
Dir_0012_out <= Dir_0012;
-- Dir_0011_out <= Dir_FFFE;
-- Dir_0012_out <= Dir_FFFF;


end process;
end Behavioral;