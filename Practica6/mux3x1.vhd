library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux3x1 is
	Port (
		Dir_0010_out: in unsigned(7 downto 0); -- Bus de datos de 8 bits 
		Dir_0011_out: in unsigned(7 downto 0); -- Bus de datos de 8 bits 
		Dir_0012_out: in unsigned(7 downto 0); -- Bus de datos de 8 bits 
		sel_1 : in std_logic;
		sel_2 : in std_logic;
		O_Dir: out unsigned(7 downto 0) -- Bus de datos de 8 bits 
	);
end mux3x1;

architecture Behavioral of mux3x1 is
begin
	process (sel_1, sel_2)
	variable v_CONCATENATE : std_logic_vector(1 downto 0);
	begin
		v_CONCATENATE := sel_1 & sel_2;
		case v_CONCATENATE is
      when "00" =>
        O_Dir <= Dir_0010_out;
      when "01" =>
        O_Dir <= Dir_0011_out;
      when "10" =>
        O_Dir <= Dir_0012_out;
      when others =>
        O_Dir <= Dir_0010_out;
		end case;
	end process;
end Behavioral;