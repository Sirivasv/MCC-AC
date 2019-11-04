library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity micro68HC11 is
Port (
	clk: in STD_LOGIC;
	reset: in STD_LOGIC;
	nIRQ: in STD_LOGIC;
	nXIRQ: in STD_LOGIC;
	Data_in: in unsigned(7 downto 0);
	Data_out: out unsigned(7 downto 0); -- Bus de datos de 8 bits
	Dir: out unsigned(15 downto 0); -- Bis de direcciones de 16 bits
	nRW: out STD_LOGIC:= '1'; -- Señal para escribir en memoria
	PC_low_out: out unsigned(7 downto 0);
	e_presente_out: out unsigned(7 downto 0);
	A_out: out unsigned (7 downto 0);
	B_out: out unsigned (7 downto 0);
	X_low_out: out unsigned(7 downto 0);
	X_high_out: out unsigned(7 downto 0);
	Y_low_out: out unsigned(7 downto 0);
	flags: out STD_LOGIC_VECTOR(7 downto 0) -- S X H I N Z V C
);
end micro68HC11;

architecture Behavioral of micro68HC11 is
signal e_presente: unsigned(11 downto 0) := X"000";
signal e_siguiente: unsigned(11 downto 0);
signal PC: unsigned (15 downto 0):= X"0044";
signal estados: STD_LOGIC_VECTOR (7 downto 0):= X"FF";
signal A: unsigned (7 downto 0);
signal B: unsigned (7 downto 0);
signal Q: unsigned (7 downto 0);
signal Yupa: unsigned (7 downto 0);
signal XH: unsigned (7 downto 0);
signal XL: unsigned (7 downto 0);
signal YH: unsigned (7 downto 0);
signal YL: unsigned (7 downto 0);
signal AuxH: unsigned (7 downto 0);
signal AuxL: unsigned (7 downto 0);
signal Aux: unsigned (15 downto 0);
signal PCH: unsigned (7 downto 0) := X"00";
signal PCL: unsigned (7 downto 0) := X"44";
signal SPH: unsigned (7 downto 0) := X"FF"; -- Definir en qué lugar poner el stack...
signal SPL: unsigned (7 downto 0) := X"FF"; -- de qué tamaño es la memoria y ponerlo
 -- en la última dirección
signal microI: unsigned (11 downto 0) := X"333" ; -- Direccion del driver de I := X""
signal microX: unsigned (11 downto 0) := X"444" ; -- Direccion del driver de I := X""
signal IntRI: unsigned (15 downto 0) := X"0069";
signal IntRX: unsigned (15 downto 0) := X"0060";
signal IRQ: STD_LOGIC := '0';
signal XIRQ: STD_LOGIC := '0';
signal startMUL: STD_LOGIC := '0';
constant ZERO : unsigned (7 downto 0) := "00000000" ;
signal D: unsigned (15 downto 0);
signal varRW: STD_LOGIC := '1';
signal indY: STD_LOGIC := '0';
signal temp:  unsigned(8 downto 0);
signal tempA:  unsigned(8 downto 0);
signal tempMUL: unsigned(15 downto 0);
begin
process(clk, reset,e_presente,e_siguiente)
begin
if (reset = '0') then
	e_siguiente <= X"000";
	PC <= X"0044";
	IRQ <= '0';
	XIRQ <= '0';
	indY <= '0';
else
	if (rising_edge(clk)) then
		case e_presente is
		-- FETCH
			when X"000" =>
				Dir <= PC;
				e_siguiente <= X"001";
			when X"001" =>
				PC <= PC + 1;
				e_siguiente <= e_presente + 1;
			when X"002" =>
				e_siguiente <= (Data_in & ZERO(3 downto 0));
				
---------------------------------------------------------------------------------------------------------------------
			when X"860" => -- LDAA IMM
				Dir <= PC;
				e_siguiente <= e_presente + 1;
			when X"861" => -- LDAA
				PC <= PC + 1;
				e_siguiente <= e_presente + 1;
			when X"862" => -- LDAA
				A <= Data_in;
				-- Actualiza N
				estados(3) <= Data_in(7);
				-- Actualiza Z
				if(Data_in = ZERO) then
					estados(2) <= '1';
				else
					estados(2) <= '0';
				end if;
				-- Actualiza V
				estados(1) <= '0';
				if (XIRQ = '1') then
					e_siguiente <= microX;
				else
					if (IRQ = '1') then
						e_siguiente <= microI;
					else
						Dir <= PC;
						e_siguiente <= X"001";
					end if;
				end if;
---------------------------------------------------------------------------------------------------------------------
			when X"C60" => -- LDAB
				Dir <= PC;
				e_siguiente <= e_presente + 1;
			when X"C61" => -- LDAB
				PC <= PC + 1;
				e_siguiente <= e_presente + 1;
			when X"C62" => -- LDAB
				B <= Data_in;
				-- Actualiza N
				estados(3) <= Data_in(7);
				-- Actualiza Z
				if(Data_in = ZERO) then
					estados(2) <= '1';
				else
					estados(2) <= '0';
				end if;
				-- Actualiza V
				estados(1) <= '0';
				if (XIRQ = '1') then
					e_siguiente <= microX;
				else
					if (IRQ = '1') then
						e_siguiente <= microI;
					else
						Dir <= PC;
						e_siguiente <= X"001";
					end if;
				end if;
------------------------------------------------------------------------------------
			-- LDX IMM
			when X"CE0" => -- LDX
				Dir <= PC;
				PC <= PC + 1;
				e_siguiente <= e_presente + 1;
			when X"CE1" => -- LDX
				Dir <= PC;
				e_siguiente <= e_presente + 1;
			when X"CE2" => -- LDX
				XH <= Data_in;
				PC <= PC + 1;
				e_siguiente <= e_presente + 1;
			when X"CE3" =>
				XL <= Data_in;
				-- Actualiza N
				estados(3) <= XH(7);
				-- Actualiza Z
				if ((Data_in = ZERO) and (XH = ZERO)) then
					estados(2) <= '1';
				else
					estados(2) <= '0';
				end if;
				-- Actualiza V
				estados(1) <= '0';
				if (XIRQ = '1') then
					e_siguiente <= microX;
				else
					if (IRQ = '1') then
						e_siguiente <= microI;
					else
						Dir <= PC;
						e_siguiente <= X"001";
					end if;
				end if;
-------------------------------------------------------------------------
			-- ABA
			when X"1B0" =>
				temp <= '0' & A + B;
				A <= A+B;
				e_siguiente <= e_siguiente + 1;
			when X"1B1" =>
				-- Actualiza C
				estados(0) <= temp(8);
				-- Actualiza N
				estados(3) <= A(7);
				-- Actualiza Z
				if (A = ZERO) then
					estados(2) <= '1';
				else
					estados(2) <= '0';
				end if;
				-- Actualiza V
				estados(1) <= '0';
				if (XIRQ = '1') then
					e_siguiente <= microX;
				else
					if (IRQ = '1') then
						e_siguiente <= microI;
					else
						Dir <= PC;
						e_siguiente <= X"001";
					end if;
				end if;
---------------------------------------------------------------------------------------------------------------------
			-- Código de la instruccion de acceso relativo BNE
			when X"260" =>
				Dir <= PC;
				e_siguiente <= e_presente + 1;
			when X"261" =>
				PC <= PC + 1;
				e_siguiente <= e_presente + 1;
			when X"262" =>
				if(estados(2)='0') then
					if (Data_in(7) = '1') then
						PC <= PC - unsigned(not(Data_in-1));
					else
						PC <= PC + Data_in;
					end if;
				end if;
				e_siguiente <= e_presente + 1;
			when X"263" =>
				if (XIRQ = '1') then
					e_siguiente <= microX;
				else
					if (IRQ = '1') then
						e_siguiente <= microI;
					else
						Dir <= PC;
						e_siguiente <= X"001";
					end if;
				end if;
---------------------------------------------------------------------------------------------------------------------
			-- STAA I,X
			when X"A70" => -- STAA
				Dir <= PC;
				e_siguiente <= e_presente + 1;
			when X"A71" => -- STAA
				PC <= PC + 1;
				e_siguiente <= e_presente + 1;
			when X"A72" => -- STAA
				Dir <= (XH & XL) + (ZERO & Data_in);
				e_siguiente <= e_presente + 1;
			when X"A73" => -- STAA
				Data_out <= A;
				nRW <= '0';
				e_siguiente <= e_presente + 1;
			when X"A74" => -- STAA
				nRW <= '1'
				-- Actualiza N
				estados(3) <= A(7);
				-- Actualiza Z
				if(A = ZERO) then
					estados(2) <= '1';
				else
					estados(2) <= '0';
				end if;
				-- Actualiza V
				estados(1) <= '0';
				if (XIRQ = '1') then
					e_siguiente <= microX;
				else
					if (IRQ = '1') then
						e_siguiente <= microI;
					else
						Dir <= PC;
						e_siguiente <= X"001";
					end if;
				end if;
-----------------------------------------------------------------------
			-- BRA
			when X"200" =>
				Dir <= PC;
				e_siguiente <= e_presente + 1;
			when X"201" =>
				PC <= PC + 1;
				e_siguiente <= e_presente + 1;
			when X"202" =>
				if (Data_in(7) = '1') then
					PC <= PC - unsigned(not(Data_in-1));
				else
					PC <= PC + Data_in;
				end if;
				e_siguiente <= e_presente + 1;
			when X"203" =>
				if (XIRQ = '1') then
					e_siguiente <= microX;
				else
					if (IRQ = '1') then
						e_siguiente <= microI;
					else
						Dir <= PC;
						e_siguiente <= X"001";
					end if;
				end if;
----------------------------------------------------
			-- STAB I,X
			when X"E70" => -- STAB
				Dir <= PC;
				e_siguiente <= e_presente + 1;
			when X"E71" => -- STAB
				PC <= PC + 1;
				e_siguiente <= e_presente + 1;
			when X"E72" => -- STAB
				Dir <= (XH & XL) + (ZERO & Data_in);
				e_siguiente <= e_presente + 1;
			when X"E73" => -- STAB
				Data_out <= B;
				nRW <= '0';
				e_siguiente <= e_presente + 1;
			when X"E74" => -- STAB
				nRW <= '1'
				-- Actualiza N
				estados(3) <= B(7);
				-- Actualiza Z
				if(B = ZERO) then
					estados(2) <= '1';
				else
					estados(2) <= '0';
				end if;
				-- Actualiza V
				estados(1) <= '0';
				if (XIRQ = '1') then
					e_siguiente <= microX;
				else
					if (IRQ = '1') then
						e_siguiente <= microI;
					else
						Dir <= PC;
						e_siguiente <= X"001";
					end if;
				end if;
----------------------------------------------------------------------------
			-- MUL
			when X"1B0" =>
				PC <= PC + 1;
				tempMUL <= unsigned(A) * unsigned(B);
				e_siguiente <= e_siguiente + 1;
			when X"1B1" =>
				A <= tempMUL(15 downto 8);
				B <= tempMUL(7 downto 0);
				if (XIRQ = '1') then
					e_siguiente <= microX;
				else
					if (IRQ = '1') then
						e_siguiente <= microI;
					else
						Dir <= PC;
						e_siguiente <= X"001";
					end if;
				end if;
---------------------------------------------------
			-- INTERRUPCIONES microX
			when X"333" =>
				Dir <= AP;
				nRW <= '0';
				e_siguiente <= e_siguiente + 1;
			when X"334" =>
				AP <= AP - 1;
				Data_out <= PC(7 downto 0);
				e_siguiente <= e_siguiente + 1;
			when X"335" =>
				Dir <= AP;
				e_siguiente <= e_siguiente + 1;
			when X"336" =>
				AP <= AP - 1;
				Data_out <= PC(15 downto 8);
				e_siguiente <= e_siguiente + 1;
			when X"337" =>
				Dir <= AP;
				PC <= IntRX;
				e_siguiente <= e_siguiente + 1;
			when X"338" =>
				AP <= AP - 1;
				Data_out <= YL;
				e_siguiente <= e_siguiente + 1;
			when X"339" =>
				Dir <= AP;
				e_siguiente <= e_siguiente + 1;
			when X"33A" =>
				AP <= AP - 1;
				Data_out <= YH;
				e_siguiente <= e_siguiente + 1;
			when X"33B" =>
				Dir <= AP;
				e_siguiente <= e_siguiente + 1;
			when X"33C" =>
				AP <= AP - 1;
				Data_out <= XL;
				e_siguiente <= e_siguiente + 1;
			when X"33D" =>
				Dir <= AP;
				e_siguiente <= e_siguiente + 1;
			when X"33E" =>
				AP <= AP - 1;
				Data_out <= XH;
				e_siguiente <= e_siguiente + 1;
			when X"33F" =>
				Dir <= AP;
				e_siguiente <= e_siguiente + 1;
			when X"340" =>
				AP <= AP - 1;
				Data_out <= A;
				e_siguiente <= e_siguiente + 1;
			when X"341" =>
				Dir <= AP;
				e_siguiente <= e_siguiente + 1;
			when X"342" =>
				AP <= AP - 1;
				Data_out <= B;
				e_siguiente <= e_siguiente + 1;
			when X"343" =>
				Dir <= AP;
				e_siguiente <= e_siguiente + 1;
			when X"344" =>
				AP <= AP - 1;
				Data_out <= estados;
				e_siguiente <= e_siguiente + 1;
			when X"345" =>
				nRW <= '1';
				Dir <= PC;
				e_siguiente <= X"001";
---------------------------------------------------
			-- INTERRUPCIONES microI
			when X"443" =>
				Dir <= AP;
				nRW <= '0';
				e_siguiente <= e_siguiente + 1;
			when X"444" =>
				AP <= AP - 1;
				Data_out <= PC(7 downto 0);
				e_siguiente <= e_siguiente + 1;
			when X"445" =>
				Dir <= AP;
				e_siguiente <= e_siguiente + 1;
			when X"446" =>
				AP <= AP - 1;
				Data_out <= PC(15 downto 8);
				e_siguiente <= e_siguiente + 1;
			when X"447" =>
				Dir <= AP;
				PC <= IntRI;
				e_siguiente <= e_siguiente + 1;
			when X"448" =>
				AP <= AP - 1;
				Data_out <= YL;
				e_siguiente <= e_siguiente + 1;
			when X"449" =>
				Dir <= AP;
				e_siguiente <= e_siguiente + 1;
			when X"44A" =>
				AP <= AP - 1;
				Data_out <= YH;
				e_siguiente <= e_siguiente + 1;
			when X"44B" =>
				Dir <= AP;
				e_siguiente <= e_siguiente + 1;
			when X"44C" =>
				AP <= AP - 1;
				Data_out <= XL;
				e_siguiente <= e_siguiente + 1;
			when X"44D" =>
				Dir <= AP;
				e_siguiente <= e_siguiente + 1;
			when X"44E" =>
				AP <= AP - 1;
				Data_out <= XH;
				e_siguiente <= e_siguiente + 1;
			when X"44F" =>
				Dir <= AP;
				e_siguiente <= e_siguiente + 1;
			when X"450" =>
				AP <= AP - 1;
				Data_out <= A;
				e_siguiente <= e_siguiente + 1;
			when X"451" =>
				Dir <= AP;
				e_siguiente <= e_siguiente + 1;
			when X"452" =>
				AP <= AP - 1;
				Data_out <= B;
				e_siguiente <= e_siguiente + 1;
			when X"453" =>
				Dir <= AP;
				e_siguiente <= e_siguiente + 1;
			when X"454" =>
				AP <= AP - 1;
				Data_out <= estados;
				e_siguiente <= e_siguiente + 1;
			when X"455" =>
				nRW <= '1';
				Dir <= PC;
				e_siguiente <= X"001";
---------------------------------------------------
			-- INTERRUPCIONES RTI
			when X"3B0" =>
				AP <= AP + 1;
				e_siguiente <= e_siguiente + 1;
			when X"3B1" =>
				Dir <= AP;
				e_siguiente <= e_siguiente + 1;
			when X"3B2" =>
				AP <= AP + 1;
				estados <= Data_in;
				e_siguiente <= e_siguiente + 1;
			when X"3B3" =>
				Dir <= AP;
				e_siguiente <= e_siguiente + 1;
			when X"3B4" =>
				AP <= AP + 1;
				estados <= Data_in;
				e_siguiente <= e_siguiente + 1;
			when X"3B5" =>
				e_siguiente <= X"001";
---------------------------------------------------------------------------------------------------------------------
			when others =>
				e_siguiente <= X"000";
				PC <= X"0000";
			end case;
		end if;
	end if;
	e_presente <= e_siguiente;
	-- debug vals
	A_out<=A;
	B_out<=B;
	e_presente_out<=e_presente(11 downto 4);
	PC_low_out <= PC(7 downto 0);
	X_low_out <= XL;
	X_high_out <= XH;
	Y_low_out <= YL;
	flags <= estados;
end process;
end Behavioral;