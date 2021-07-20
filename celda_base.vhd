library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity celda_base is
    Port ( info_in : in STD_LOGIC_VECTOR (1 downto 0);
               celda : in STD_LOGIC_VECTOR (1 downto 0);
               info_out : out STD_LOGIC_VECTOR (1 downto 0);
               salida : out STD_LOGIC);
end celda_base;

architecture Behavioral of celda_base is

begin
salida <= '1' when (info_in ="10" AND celda ="00") else 
		'0';
info_out <= "01" when (celda ="10") else 
		"10" when ((info_in ="01" OR info_in ="10") AND celda ="01") else 
		"00";
end Behavioral;