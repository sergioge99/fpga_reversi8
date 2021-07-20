----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/19/2020 04:00:40 PM
-- Design Name: 
-- Module Name: test_microcelda - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_microcelda is
--  Port ( );
end test_microcelda;

architecture Behavioral of test_microcelda is
component celda_base is
    Port ( info_in : in STD_LOGIC_VECTOR (1 downto 0);
           celda : in STD_LOGIC_VECTOR (1 downto 0);
           info_out : out STD_LOGIC_VECTOR (1 downto 0);
           salida : out STD_LOGIC);
end component;
signal INFO_IN, celda, INFO_OUT : std_logic_vector (1 downto 0);
signal SALIDA : std_logic;
begin
celda_uut: celda_base port map (INFO_IN => INFO_IN, celda => celda, SALIDA => SALIDA, INFO_OUT => INFO_OUT);
process
begin
    INFO_IN <= "00";
    celda <= "00";
    wait for 10ns;
    assert(INFO_OUT="00") report "Fail 0/0a" severity error;
    assert(SALIDA='0') report "Fail 0/0b" severity error;
    
    INFO_IN <= "00";
    celda <= "01";
    wait for 10ns;
    assert(INFO_OUT="00") report "Fail 0/1a" severity error;
    assert(SALIDA='0') report "Fail 0/1b" severity error;
    
    INFO_IN <= "00";
    celda <= "10";
    wait for 10ns;
    assert(INFO_OUT="01") report "Fail 0/2a" severity error;
    assert(SALIDA='0') report "Fail 0/2b" severity error;
    
    INFO_IN <= "01";
    celda <= "00";
    wait for 10ns;
    assert(INFO_OUT="00") report "Fail 1/0a" severity error;
    assert(SALIDA='0') report "Fail 1/0b" severity error;
    
    INFO_IN <= "01";
    celda <= "01";
    wait for 10ns;
    assert(INFO_OUT="10") report "Fail 1/1a" severity error;
    assert(SALIDA='0') report "Fail 1/1b" severity error;
    
    INFO_IN <= "01";
    celda <= "10";
    wait for 10ns;
    assert(INFO_OUT="01") report "Fail 1/2a" severity error;
    assert(SALIDA='0') report "Fail 1/2b" severity error;
    
    INFO_IN <= "10";
    celda <= "00";
    wait for 10ns;
    assert(INFO_OUT="00") report "Fail 2/0a" severity error;
    assert(SALIDA='1') report "Fail 2/0b" severity error;
    
    INFO_IN <= "10";
    celda <= "01";
    wait for 10ns;
    assert(INFO_OUT="10") report "Fail 2/1a" severity error;
    assert(SALIDA='0') report "Fail 2/1b" severity error;
    
    INFO_IN <= "10";
    celda <= "10";
    wait for 10ns;
    assert(INFO_OUT="01") report "Fail 2/2a" severity error;
    assert(SALIDA='0') report "Fail 2/2b" severity error;
    
    assert(false) report "Fin" severity note;
    wait;
    
end process;
end Behavioral;
