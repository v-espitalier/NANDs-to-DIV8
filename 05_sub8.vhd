
--------------------------------------
-- 8-bit SUB with carry in/out gate --
--------------------------------------

-- Utilise le soustracteur 1-bit en cascade
-- Donc 8 * 18 = 144 NANDS.

-- Temps latence de Q8 = 7 * Temps latence(Retenue(SUB1)) + 1 latence(Q(SUB1)) = 7 * 4 + 6 = 34 NANDS de latence
-- Temps latence de la retenue = 8 * Temps latence(Retenue(SUB1)) = 8 * 4 = 32 NANDS de latence

library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity SUB8_GATE is
port(	A:			in std_logic_vector (7 downto 0);
			B:			in std_logic_vector (7 downto 0);
			C_IN:		in std_logic;  -- retenue précédente
			Q:			out std_logic_vector (7 downto 0);
			C_OUT:	out std_logic); -- C_OUT = nouvelle retenue
end SUB8_GATE;

architecture arch of SUB8_GATE is

component SUB_GATE
port( A:      in std_logic;
      B:      in std_logic;
      C_IN:   in std_logic;  -- retenue précédente
      Q:      out std_logic;  -- Q = A XOR B XOR C_IN
      C_OUT:  out std_logic); -- C_OUT = nouvelle retenue = {A + B + C_IN >= 2}
end component; 

signal Q_SUB_C_OUT: std_logic_vector (6 downto 0); -- La derniere retenue est une output

begin
    Sub1: SUB_GATE port map (A(0), B(0), C_IN,           Q(0), Q_SUB_C_OUT(0));
    Sub2: SUB_GATE port map (A(1), B(1), Q_SUB_C_OUT(0), Q(1), Q_SUB_C_OUT(1));
    Sub3: SUB_GATE port map (A(2), B(2), Q_SUB_C_OUT(1), Q(2), Q_SUB_C_OUT(2));
    Sub4: SUB_GATE port map (A(3), B(3), Q_SUB_C_OUT(2), Q(3), Q_SUB_C_OUT(3));
    Sub5: SUB_GATE port map (A(4), B(4), Q_SUB_C_OUT(3), Q(4), Q_SUB_C_OUT(4));
    Sub6: SUB_GATE port map (A(5), B(5), Q_SUB_C_OUT(4), Q(5), Q_SUB_C_OUT(5));
    Sub7: SUB_GATE port map (A(6), B(6), Q_SUB_C_OUT(5), Q(6), Q_SUB_C_OUT(6));
    Sub8: SUB_GATE port map (A(7), B(7), Q_SUB_C_OUT(6), Q(7), C_OUT);
end arch;

