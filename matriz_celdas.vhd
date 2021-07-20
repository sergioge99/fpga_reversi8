----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.02.2016 19:24:40
-- Design Name: 
-- Module Name: matriz_celdas - Behavioral
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

-- Este dise�o es para un tama�o fijo de 8x8 pero ser�a trivial hacerlo para un tama�o variable, 
-- bastar�a con definir dos par�metros gen�ricos que indicasen el tama�o de cada dimensi�n y usarlos en los generates
-- Notaci�n: los dos bits menos significativos del tablero son la casilla (0,0), los siguientes la (0,1)...
-- Igualmente el bit menos significativo de Mov_posibles es la salida de la casilla (0,0)...

entity matriz_celdas is
    Port (  tablero : in STD_LOGIC_VECTOR (127 downto 0);
            Mov_posibles: out STD_LOGIC_VECTOR (63 downto 0));
end matriz_celdas;

architecture Behavioral of matriz_celdas is
-- Os pongo las entradas de la macrocelda. Recibe informaci�n de las ocho entradas y 
-- a partir de cada entrada y la celda 8input) genera la salida contraria y los movimientos posibles
component macro_celda 
Port ( up_in : in STD_LOGIC_VECTOR (1 downto 0);
           down_in : in STD_LOGIC_VECTOR (1 downto 0);
           left_in : in STD_LOGIC_VECTOR (1 downto 0);
           right_in : in STD_LOGIC_VECTOR (1 downto 0);
           up_left_in : in STD_LOGIC_VECTOR (1 downto 0);
           up_right_in : in STD_LOGIC_VECTOR (1 downto 0);
           down_left_in : in STD_LOGIC_VECTOR (1 downto 0);
           down_right_in : in STD_LOGIC_VECTOR (1 downto 0);
           up_out : out STD_LOGIC_VECTOR (1 downto 0);
           down_out : out STD_LOGIC_VECTOR (1 downto 0);
           left_out : out STD_LOGIC_VECTOR (1 downto 0);
           right_out : out STD_LOGIC_VECTOR (1 downto 0);
           up_left_out : out STD_LOGIC_VECTOR (1 downto 0);
           up_right_out : out STD_LOGIC_VECTOR (1 downto 0);
           down_left_out : out STD_LOGIC_VECTOR (1 downto 0);
           down_right_out : out STD_LOGIC_VECTOR (1 downto 0);
           input : in STD_LOGIC_VECTOR (1 downto 0);
           output : out std_logic);
end component;

-- signal matrix es un tipo que nos permite definir las matrices de se�ales que van a conectar nuestra red.
-- Su tama�o es uno mayor que el n�mero de celdas porque tambi�n incluimos las entradas de las fronteras
-- Esas entradas ser�n siempre "00" 
type signal_matrix is array(0 to 8, 0 to 8) of STD_LOGIC_Vector(1 downto 0);
signal up_down, down_up, left_right, right_left, dl_ur, dr_ul, ul_dr, ur_dl:  signal_matrix;

begin
GEN_matrix_I: for I in 0 to 7 generate
    GEN_matrix_J: for J in 0 to 7 generate
-- Numero la casilla de arriba a la izquierda como la (0,0)        
-- Las casillas que est�n en las fronteras, es decir filas y columnas 0 y 7, deben recibir "00" en las entradas que est�n fuera del tablero
-- para ello los siguientes generates asignan "00" a los valores frontera 
-- Fila de arriba        
        row_0: if (I = 0) generate
          -- "00" en las entradas de arriba, esquina arriba/izq, y esquina arriba/derecha
                  up_down(I,J) <= "00";
                  ul_dr(I,J)<= "00";
                  ur_dl(I,J+1)<= "00";
        end generate row_0;  
-- Fila de arriba        
        row_7: if (I = 7) generate
         -- "00" en las entradas de abajo, esquina abajo/izq, y esquina abajo/derecha
                  down_up(I+1,J) <= "00";
                  dr_ul(I+1,J)<= "00";
                  dl_ur(I+1,J+1)<= "00";
        end generate row_7;          
-- columna de la izq
        column_0: if (J = 0) generate
          -- "00" en las entradas de izq, esquina arriba/izq, y esquina abajo/izq
                  left_right(I,J) <= "00";
                  ul_dr(I,J)<= "00";
                  dl_ur(I+1,J)<= "00";
        end generate column_0;    
-- columna de la derecha
        column_7: if (J = 7) generate
          -- "00" en las entradas de derecha, esquina abajo/derecha, y esquina arriba/derecha
                   right_left(I,J+1) <= "00";
                   dr_ul(I+1,J+1)<= "00";
                   ur_dl(I,J+1)<= "00";
        end generate column_7;
-- Aqu� se instancian las 64 celdas. He reordenado las se�ales para que se vea como entran y salen       
        cell: macro_celda port map (    
                   -- se�ales que van de arriba a abajo
                   up_in =>  up_down(I,J),
                   down_out => up_down(I+1,J),
                   -- se�ales que van de abajo a arriba
                   down_in => down_up(I+1,J),
                   up_out => down_up(I,J),
                   -- se�ales que van de izq a drch
                   left_in => left_right(I,J),
                   right_out => left_right(I,J+1),
                   -- se�ales que van de drch a izq
                   right_in => right_left(I,J+1),
                   left_out => right_left(I,J),
                   -- diagonal 1 
                   up_left_in => ul_dr(I,J),
                   down_right_out => ul_dr(I+1,J+1),
                   --diagonal 2
                   up_right_in => ur_dl(I,J+1),
                   down_left_out => ur_dl(I+1,J),
                   -- diagonal 3
                   down_left_in => dl_ur(I+1,J),
                   up_right_out  => dl_ur(I,J+1),
                   --diagonal 4
                   down_right_in => dr_ul(I+1,J+1),
                   up_left_out => dr_ul(I,J),
                   -- casilla
                   input => tablero(I*16 + J*2 + 1 downto I*16 + J*2 ),
                   --salida
                   output => Mov_posibles(I*8 + J));
                           
         end generate GEN_matrix_J;
 end generate GEN_matrix_I;

end Behavioral;
