
--------------------------------------
-- 1-bit ADD with carry in/out gate --
--------------------------------------

-- Brique de base de l'additionneur ADD-n bits.
-- D'ou la necessite d'inclure la retenue précédente du bit de poids inferieur.

-- utilise 1 XOR3 pour le resultat et
-- un NAND3 + 3 NAND2 pour la retenue
-- donc 16 NANDS.
-- Temps latence de Q = Temps latence(XOR3) = 6 NANDS
-- Temps latence de la retenue = Temps latence(NAND3 + NAND1) = 3 + 1 = 4 NANDS
-- (Sur un additionneur 8 bits, c'est certainement la propagation de la retenue
-- qui va prendre le plus de temps; on s'attend donc à 7 * 4 + 6 = 34 NANDS de latence)

library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity ADD_GATE is
port(	A:			in std_logic;
			B:			in std_logic;
			C_IN:		in std_logic;  -- retenue précédente
			Q:			out std_logic;  -- Q = A XOR B XOR C_IN
			C_OUT:	out std_logic); -- C_OUT = nouvelle retenue = {A + B + C_IN >= 2}
end ADD_GATE;

architecture arch of ADD_GATE is

component XOR3_GATE
port(	A:	in std_logic;
	    B:	in std_logic;
	    C:	in std_logic;
      Q:	out std_logic);
end component;

component NAND_GATE
port(	A:	in std_logic;
	    B:	in std_logic;
      Q:	out std_logic);
end component;

component NAND3_GATE
port(	A:	in std_logic;
	    B:	in std_logic;
	    C:	in std_logic;
      Q:	out std_logic);
end component;

signal Q_NAND_AB: std_logic;
signal Q_NAND_AC_IN: std_logic;
signal Q_NAND_BC_IN: std_logic;

begin
    Xor31: XOR3_GATE port map (A, B, C_IN, Q);
    Nand11: NAND_GATE port map (A, B, Q_NAND_AB);
    Nand12: NAND_GATE port map (A, C_IN, Q_NAND_AC_IN);
    Nand13: NAND_GATE port map (B, C_IN, Q_NAND_BC_IN);
    Nand3: NAND3_GATE port map (Q_NAND_AB, Q_NAND_AC_IN, Q_NAND_BC_IN, C_OUT);
end arch;

