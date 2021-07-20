----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.02.2016 14:33:12
-- Design Name: 
-- Module Name: sim_matrix - Behavioral
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

entity sim_matrix is
    Port ( salida : out STD_LOGIC_VECTOR (63 downto 0));
end sim_matrix;

architecture Behavioral of sim_matrix is
component matriz_celdas
    Port (  tablero : in STD_LOGIC_VECTOR (127 downto 0);
            Mov_posibles: out STD_LOGIC_VECTOR (63 downto 0));
end component;
signal board: STD_LOGIC_VECTOR (127 downto 0);
begin
matriz: matriz_celdas port map (board, salida);
process
begin
    --tablero vacio
    board <= (others => '0');
    wait for 1 ns;
   -- siguiendo este esquema pod�is poner las casillas que quer�is:
   -- primero se pone el tablero vacio 
    board <= (others => '0');
   -- despu�s colocas las casillas una a una
   -- en este ejemplo pongo una casilla negra en la posici�n (4,3)
    board(16*4 + 3*2 +1  downto 16*4 + 3*2) <= "10";
    -- en este una casilla blanca en la posici�n (4,2)
    board(16*4 + 2*2 +1  downto 16*4 + 2*2) <= "01";
    --finalmente pones un wait para que el resultado se vea
    assert(salida(8*4 + 1)='0') report "Fail 0" severity error;
    wait for 1 ns;
    assert(salida(8*4 + 1)='1') report "Fail 1" severity error;
    
    -- Negra Blanca Blanca Vacio (salta más de una ficha)
    board <= (others => '0');
    board(16*4 + 4*2 +1  downto 16*4 + 4*2) <= "10";--negra (4,4)
    board(16*4 + 3*2 +1  downto 16*4 + 3*2) <= "01";--blanca (4,3)
    board(16*4 + 2*2 +1  downto 16*4 + 2*2) <= "01";--blanca (4,2)
    wait for 1 ns;
    assert(salida(8*4 + 1)='1') report "Fail 2" severity error;
    
    -- Negra rodeada de 8 blancas (todas direcciones)
    board <= (others => '0');
    board(16*4 + 5*2 +1  downto 16*4 + 5*2) <= "10";--negra (4,5)
    board(16*4 + 4*2 +1  downto 16*4 + 4*2) <= "01";--blanca (4,4)
    board(16*4 + 6*2 +1  downto 16*4 + 6*2) <= "01";--blanca (4,6)
    board(16*3 + 4*2 +1  downto 16*3 + 4*2) <= "01";--blanca (3,4)
    board(16*3 + 5*2 +1  downto 16*3 + 5*2) <= "01";--blanca (3,5)
    board(16*3 + 6*2 +1  downto 16*3 + 6*2) <= "01";--blanca (3,6)
    board(16*5 + 4*2 +1  downto 16*5 + 4*2) <= "01";--blanca (5,4)
    board(16*5 + 5*2 +1  downto 16*5 + 5*2) <= "01";--blanca (5,5)
    board(16*5 + 6*2 +1  downto 16*5 + 6*2) <= "01";--blanca (5,6)
    wait for 1 ns;
    assert(salida(8*2 + 3)='1') report "Fail 3/1" severity error;
    assert(salida(8*2 + 5)='1') report "Fail 3/2" severity error;
    assert(salida(8*2 + 7)='1') report "Fail 3/3" severity error;
    assert(salida(8*4 + 3)='1') report "Fail 3/4" severity error;
    assert(salida(8*4 + 7)='1') report "Fail 3/5" severity error;
    assert(salida(8*6 + 3)='1') report "Fail 3/6" severity error;
    assert(salida(8*6 + 5)='1') report "Fail 3/7" severity error;
    assert(salida(8*6 + 7)='1') report "Fail 3/8" severity error;
    
    -- Fin
    assert(false) report "Fin" severity note;
    wait;
end process;

end Behavioral;
