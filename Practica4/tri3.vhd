library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity tri3 is
port(
  IN_SIG : in std_logic_vector(3 downto 0);
  EN_SIG : in std_logic;
  OUT_SIG : out std_logic_vector(3 downto 0)
);
end tri3;

architecture Behavioral of tri3 is
begin
	OUT_SIG <= IN_SIG when EN_SIG = '1' else (others => 'Z');
end Behavioral;