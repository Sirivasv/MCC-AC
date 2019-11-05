library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux3x1 is
	Port (
		Dir_0010_out: in unsigned(7 downto 0); -- Bus de datos de 8 bits 
		Dir_0011_out: in unsigned(7 downto 0); -- Bus de datos de 8 bits 
		Dir_0012_out: in unsigned(7 downto 0); -- Bus de datos de 8 bits
		PC_Low_out: in unsigned(7 downto 0); -- Bus de datos de 8 bits
		X_High_out: in unsigned(7 downto 0); -- Bus de datos de 8 bits
		X_Low_out: in unsigned(7 downto 0); -- Bus de datos de 8 bits
		A_out: in unsigned(7 downto 0); -- Bus de datos de 8 bits
		B_out: in unsigned(7 downto 0); -- Bus de datos de 8 bits
		sel_1 : in std_logic;
		sel_2 : in std_logic;
		sel_3 : in std_logic;
		O_Dir: out unsigned(7 downto 0) -- Bus de datos de 8 bits 
	);
end mux3x1;

architecture Behavioral of mux3x1 is
begin
	process (sel_1, sel_2, sel_3)
	variable v_CONCATENATE : std_logic_vector(2 downto 0);
	begin
		v_CONCATENATE := sel_3 & sel_2 & sel_1;
		case v_CONCATENATE is
      when "000" =>
        O_Dir <= Dir_0010_out;
      when "001" =>
        O_Dir <= Dir_0011_out;
      when "010" =>
        O_Dir <= Dir_0012_out;
		when "011" =>
        O_Dir <= PC_Low_out;
		when "100" =>
        O_Dir <= X_High_out;
		when "101" =>
        O_Dir <= X_Low_out;
      when "110" =>
        O_Dir <= A_out;
		when "111" =>
        O_Dir <= B_out;
		when others =>
        O_Dir <= Dir_0010_out;
		end case;
	end process;
end Behavioral;