library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity macro_celda is
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
end macro_celda;

architecture Behavioral of macro_celda is

component celda_base is
    Port ( info_in : in STD_LOGIC_VECTOR (1 downto 0);
               celda : in STD_LOGIC_VECTOR (1 downto 0);
               info_out : out STD_LOGIC_VECTOR (1 downto 0);
               salida : out STD_LOGIC);
end component;

signal a,b,c,d,e,f,g,h: STD_LOGIC;

begin      
        cel_up_down: celda_base port map(
        	info_in => up_in,
            celda => input,
        	info_out =>  down_out,
            salida => a);
        cel_down_up: celda_base port map(
        	info_in => down_in,
            celda => input,
        	info_out =>  up_out,
            salida => b);
        cel_left_right: celda_base port map(
        	info_in => left_in,
            celda => input,
        	info_out =>  right_out,
            salida => c);
        cel_right_left: celda_base port map(
        	info_in => right_in,
            celda => input,
        	info_out =>  left_out,
            salida => d);
        cel_diag1: celda_base port map(
        	info_in => up_left_in,
            celda => input,
        	info_out =>  down_right_out,
            salida => e);
        cel_diag2: celda_base port map(
        	info_in => down_right_in,
            celda => input,
        	info_out =>  up_left_out,
            salida => f);
        cel_diag3: celda_base port map(
        	info_in => up_right_in,
            celda => input,
        	info_out =>  down_left_out,
            salida => g);
        cel_diag4: celda_base port map(
        	info_in => down_left_in,
            celda => input,
        	info_out =>  up_right_out,
            salida => h);
        
        output <= a OR b OR c OR d OR e OR f OR g OR h;
        
end Behavioral;