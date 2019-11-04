library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity memoria is
Port (
	clk: in STD_LOGIC;
	reset: in STD_LOGIC;
	Dir_in: in unsigned(15 downto 0); -- Bis de direcciones de 16 bits
	AS: in STD_LOGIC;
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
signal Dir_0044: unsigned (7 downto 0) := X"86";
signal Dir_0045: unsigned (7 downto 0) := X"FF";
signal Dir_0046: unsigned (7 downto 0) := X"C6";
signal Dir_0047: unsigned (7 downto 0) := X"01";
signal Dir_0048: unsigned (7 downto 0) := X"CE";
signal Dir_0049: unsigned (7 downto 0) := X"00";
signal Dir_004A: unsigned (7 downto 0) := X"10";
signal Dir_004B: unsigned (7 downto 0) := X"1B";
signal Dir_004C: unsigned (7 downto 0) := X"26";
signal Dir_004D: unsigned (7 downto 0) := X"04";
signal Dir_004E: unsigned (7 downto 0) := X"A7";
signal Dir_004F: unsigned (7 downto 0) := X"00";
signal Dir_0050: unsigned (7 downto 0) := X"20";
signal Dir_0051: unsigned (7 downto 0) := X"02";
signal Dir_0052: unsigned (7 downto 0) := X"E7";
signal Dir_0053: unsigned (7 downto 0) := X"00";
signal Dir_0054: unsigned (7 downto 0) := X"86";
signal Dir_0055: unsigned (7 downto 0) := X"07";
signal Dir_0056: unsigned (7 downto 0) := X"C6";
signal Dir_0057: unsigned (7 downto 0) := X"02";
signal Dir_0058: unsigned (7 downto 0) := X"3D";
signal Dir_0059: unsigned (7 downto 0) := X"A7";
signal Dir_005A: unsigned (7 downto 0) := X"01";
signal Dir_005B: unsigned (7 downto 0) := X"E7";
signal Dir_005C: unsigned (7 downto 0) := X"02";
signal Dir_005D: unsigned (7 downto 0) := X"20";
signal Dir_005E: unsigned (7 downto 0) := X"FD";

-- DRIVER X
-- LDX #$0020
signal Dir_0060: unsigned (7 downto 0) := X"CE";
signal Dir_0061: unsigned (7 downto 0) := X"00";
signal Dir_0062: unsigned (7 downto 0) := X"20";
-- LDAA $0030
signal Dir_0063: unsigned (7 downto 0) := X"B6";
signal Dir_0064: unsigned (7 downto 0) := X"00";
signal Dir_0065: unsigned (7 downto 0) := X"30";
-- STAA 0,X
signal Dir_0066: unsigned (7 downto 0) := X"A7";
signal Dir_0067: unsigned (7 downto 0) := X"00";
-- RTI
signal Dir_0068: unsigned (7 downto 0) := X"3B";

-- DRIVER Y
-- LDX #$0030
signal Dir_0069: unsigned (7 downto 0) := X"CE";
signal Dir_006A: unsigned (7 downto 0) := X"00";
signal Dir_006B: unsigned (7 downto 0) := X"30";
-- LDAB $0020
signal Dir_006C: unsigned (7 downto 0) := X"F6";
signal Dir_006D: unsigned (7 downto 0) := X"00";
signal Dir_006E: unsigned (7 downto 0) := X"20";
-- STAB 0,X
signal Dir_006F: unsigned (7 downto 0) := X"E7";
signal Dir_0070: unsigned (7 downto 0) := X"00";
-- RTI
signal Dir_0071: unsigned (7 downto 0) := X"3B";

-- PILA
signal Dir_00D0: unsigned (7 downto 0) := X"00";
signal Dir_00D1: unsigned (7 downto 0) := X"00";
signal Dir_00D2: unsigned (7 downto 0) := X"00";
signal Dir_00D3: unsigned (7 downto 0) := X"00";
signal Dir_00D4: unsigned (7 downto 0) := X"00";
signal Dir_00D5: unsigned (7 downto 0) := X"00";
signal Dir_00D6: unsigned (7 downto 0) := X"00";
signal Dir_00D7: unsigned (7 downto 0) := X"00";
signal Dir_00D8: unsigned (7 downto 0) := X"00";
signal Dir_00D9: unsigned (7 downto 0) := X"00";
signal Dir_00DA: unsigned (7 downto 0) := X"00";
signal Dir_00DB: unsigned (7 downto 0) := X"00";
signal Dir_00DC: unsigned (7 downto 0) := X"00";
signal Dir_00DD: unsigned (7 downto 0) := X"00";
signal Dir_00DE: unsigned (7 downto 0) := X"00";
signal Dir_00DF: unsigned (7 downto 0) := X"00";
signal Dir_00F0: unsigned (7 downto 0) := X"00";
signal Dir_00F1: unsigned (7 downto 0) := X"00";
signal Dir_00F2: unsigned (7 downto 0) := X"00";
signal Dir_00F3: unsigned (7 downto 0) := X"00";
signal Dir_00F4: unsigned (7 downto 0) := X"00";
signal Dir_00F5: unsigned (7 downto 0) := X"00";
signal Dir_00F6: unsigned (7 downto 0) := X"00";
signal Dir_00F7: unsigned (7 downto 0) := X"00";
signal Dir_00F8: unsigned (7 downto 0) := X"00";
signal Dir_00F9: unsigned (7 downto 0) := X"00";
signal Dir_00FA: unsigned (7 downto 0) := X"00";
signal Dir_00FB: unsigned (7 downto 0) := X"00";
signal Dir_00FC: unsigned (7 downto 0) := X"00";
signal Dir_00FD: unsigned (7 downto 0) := X"00";
signal Dir_00FE: unsigned (7 downto 0) := X"00";
signal Dir_00FF: unsigned (7 downto 0) := X"00";
begin
process(clk, reset,AS, Dir_in)
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
	
	Dir_0044 <= X"86";
	Dir_0045 <= X"FF";
	
	Dir_0046 <= X"C6";
	Dir_0047 <= X"01";
	
	Dir_0048 <= X"CE";
	Dir_0049 <= X"00";
	Dir_004A <= X"10";
	
	Dir_004B <= X"1B";
	
	Dir_004C <= X"26";
	Dir_004D <= X"04";
	
	Dir_004E <= X"A7";
	Dir_004F <= X"00";
	
	Dir_0050 <= X"20";
	Dir_0051 <= X"02";
	Dir_0052 <= X"E7";
	Dir_0053 <= X"00";
	Dir_0054 <= X"86";
	Dir_0055 <= X"07";
	Dir_0056 <= X"C6";
	Dir_0057 <= X"02";
	Dir_0058 <= X"3D";
	Dir_0059 <= X"A7";
	Dir_005A <= X"01";
	Dir_005B <= X"E7";
	Dir_005C <= X"02";
	Dir_005D <= X"20";
	Dir_005E <= X"FD";

	-- DRIVER X
	-- LDX #$0020
	Dir_0060 <= X"CE";
	Dir_0061 <= X"00";
	Dir_0062 <= X"20";
	-- LDAA $0030
	Dir_0063 <= X"B6";
	Dir_0064 <= X"00";
	Dir_0065 <= X"30";
	-- STAA 0,X
	Dir_0066 <= X"A7";
	Dir_0067 <= X"00";
	-- RTI
	Dir_0068 <= X"3B";

	-- DRIVER Y
	-- LDX #$0030
	Dir_0069 <= X"CE";
	Dir_006A <= X"00";
	Dir_006B <= X"30";
	-- LDAB $0020
	Dir_006C <= X"F6";
	Dir_006D <= X"00";
	Dir_006E <= X"20";
	-- STAB 0,X
	Dir_006F <= X"E7";
	Dir_0070 <= X"00";
	-- RTI
	Dir_0071 <= X"3B";

	-- PILA
	Dir_00D0 <= X"00";
	Dir_00D1 <= X"00";
	Dir_00D2 <= X"00";
	Dir_00D3 <= X"00";
	Dir_00D4 <= X"00";
	Dir_00D5 <= X"00";
	Dir_00D6 <= X"00";
	Dir_00D7 <= X"00";
	Dir_00D8 <= X"00";
	Dir_00D9 <= X"00";
	Dir_00DA <= X"00";
	Dir_00DB <= X"00";
	Dir_00DC <= X"00";
	Dir_00DD <= X"00";
	Dir_00DE <= X"00";
	Dir_00DF <= X"00";
	Dir_00F0 <= X"00";
	Dir_00F1 <= X"00";
	Dir_00F2 <= X"00";
	Dir_00F3 <= X"00";
	Dir_00F4 <= X"00";
	Dir_00F5 <= X"00";
	Dir_00F6 <= X"00";
	Dir_00F7 <= X"00";
	Dir_00F8 <= X"00";
	Dir_00F9 <= X"00";
	Dir_00FA <= X"00";
	Dir_00FB <= X"00";
	Dir_00FC <= X"00";
	Dir_00FD <= X"00";
	Dir_00FE <= X"00";
	Dir_00FF <= X"00";
else
	if (rising_edge(clk)) then
		if (AS = '0') then
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
			
			-- BRA
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
			
			-- FIN: BRA FIN
			when X"005D" =>
				Data_out <= Dir_005D;
			when X"005E" =>
				Data_out <= Dir_005E;
			
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
			when X"0060" =>
				 Dir_0060 <= Data_in;
			when X"0061" =>
				 Dir_0061 <= Data_in;
			when X"0062" =>
				 Dir_0062 <= Data_in;
			when X"0063" =>
				 Dir_0063 <= Data_in;
			when X"0064" =>
				 Dir_0064 <= Data_in;
			when X"0065" =>
				 Dir_0065 <= Data_in;
			when X"0066" =>
				 Dir_0066 <= Data_in;
			when X"0067" =>
				 Dir_0067 <= Data_in;
			when X"0068" =>
				 Dir_0068 <= Data_in;
			when X"0069" =>
				 Dir_0069 <= Data_in;
			when X"006A" =>
				 Dir_006A <= Data_in;
			when X"006B" =>
				 Dir_006B <= Data_in;
			when X"006C" =>
				 Dir_006C <= Data_in;
			when X"006D" =>
				 Dir_006D <= Data_in;
			when X"006E" =>
				 Dir_006E <= Data_in;
			when X"006F" =>
				 Dir_006F <= Data_in;
			when X"0070" =>
				 Dir_0070 <= Data_in;
			when X"0071" =>
				 Dir_0071 <= Data_in;
			when X"00D0" =>
				 Dir_00D0 <= Data_in;
			when X"00D1" =>
				 Dir_00D1 <= Data_in;
			when X"00D2" =>
				 Dir_00D2 <= Data_in;
			when X"00D3" =>
				 Dir_00D3 <= Data_in;
			when X"00D4" =>
				 Dir_00D4 <= Data_in;
			when X"00D5" =>
				 Dir_00D5 <= Data_in;
			when X"00D6" =>
				 Dir_00D6 <= Data_in;
			when X"00D7" =>
				 Dir_00D7 <= Data_in;
			when X"00D8" =>
				 Dir_00D8 <= Data_in;
			when X"00D9" =>
				 Dir_00D9 <= Data_in;
			when X"00DA" =>
				 Dir_00DA <= Data_in;
			when X"00DB" =>
				 Dir_00DB <= Data_in;
			when X"00DC" =>
				 Dir_00DC <= Data_in;
			when X"00DD" =>
				 Dir_00DD <= Data_in;
			when X"00DE" =>
				 Dir_00DE <= Data_in;
			when X"00DF" =>
				 Dir_00DF <= Data_in;
			when X"00F0" =>
				 Dir_00F0 <= Data_in;
			when X"00F1" =>
				 Dir_00F1 <= Data_in;
			when X"00F2" =>
				 Dir_00F2 <= Data_in;
			when X"00F3" =>
				 Dir_00F3 <= Data_in;
			when X"00F4" =>
				 Dir_00F4 <= Data_in;
			when X"00F5" =>
				 Dir_00F5 <= Data_in;
			when X"00F6" =>
				 Dir_00F6 <= Data_in;
			when X"00F7" =>
				 Dir_00F7 <= Data_in;
			when X"00F8" =>
				 Dir_00F8 <= Data_in;
			when X"00F9" =>
				 Dir_00F9 <= Data_in;
			when X"00FA" =>
				 Dir_00FA <= Data_in;
			when X"00FB" =>
				 Dir_00FB <= Data_in;
			when X"00FC" =>
				 Dir_00FC <= Data_in;
			when X"00FD" =>
				 Dir_00FD <= Data_in;
			when X"00FE" =>
				 Dir_00FE <= Data_in;
			when X"00FF" =>
				 Dir_00FF <= Data_in;
			when others =>
				Dir_00FF <= Dir_00FF;
			end case;
		end if;
	end if;
end if;
-- TESTING SIGNALS
Dir_0010_out <= Dir_0010; 
Dir_0011_out <= Dir_0011;
Dir_0012_out <= Dir_0012;


end process;
end Behavioral;