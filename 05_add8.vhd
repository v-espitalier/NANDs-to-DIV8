
--------------------------------------
-- 8-bit ADD with carry in/out gate --
--------------------------------------

-- Utilise l'additionneur 1-bit en cascade
-- Donc 8 * 16 = 128 NANDS.

-- (C_OUT * 256 + Q) = (A + B + C_IN)

-- Temps latence de Q8 = 7 * Temps latence(Retenue(ADD1)) + 1 latence(Q(ADD1)) = 7 * 4 + 6 = 34 NANDS de latence
-- Temps latence de la retenue = 8 * Temps latence(Retenue(ADD1)) = 8 * 4 = 32 NANDS de latence

library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity ADD8_GATE is
port(	A:			in std_logic_vector (7 downto 0);
			B:			in std_logic_vector (7 downto 0);
			C_IN:		in std_logic;  -- retenue précédente
			Q:			out std_logic_vector (7 downto 0);
			C_OUT:	out std_logic); -- C_OUT = nouvelle retenue
end ADD8_GATE;

architecture arch of ADD8_GATE is

component ADD_GATE
port( A:      in std_logic;
      B:      in std_logic;
      C_IN:   in std_logic;  -- retenue précédente
      Q:      out std_logic;  -- Q = A XOR B XOR C_IN
      C_OUT:  out std_logic); -- C_OUT = nouvelle retenue = {A + B + C_IN >= 2}
end component; 

signal Q_ADD_C_OUT: std_logic_vector (6 downto 0); -- La derniere retenue est une output

begin
    Add1: ADD_GATE port map (A(0), B(0), C_IN,           Q(0), Q_ADD_C_OUT(0));
    Add2: ADD_GATE port map (A(1), B(1), Q_ADD_C_OUT(0), Q(1), Q_ADD_C_OUT(1));
    Add3: ADD_GATE port map (A(2), B(2), Q_ADD_C_OUT(1), Q(2), Q_ADD_C_OUT(2));
    Add4: ADD_GATE port map (A(3), B(3), Q_ADD_C_OUT(2), Q(3), Q_ADD_C_OUT(3));
    Add5: ADD_GATE port map (A(4), B(4), Q_ADD_C_OUT(3), Q(4), Q_ADD_C_OUT(4));
    Add6: ADD_GATE port map (A(5), B(5), Q_ADD_C_OUT(4), Q(5), Q_ADD_C_OUT(5));
    Add7: ADD_GATE port map (A(6), B(6), Q_ADD_C_OUT(5), Q(6), Q_ADD_C_OUT(6));
    Add8: ADD_GATE port map (A(7), B(7), Q_ADD_C_OUT(6), Q(7), C_OUT);
end arch;

