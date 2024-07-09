
--------------------------------------
-- 1-bit SUB with carry in/out gate --
--------------------------------------

-- Brique de base du soustracteur SUB-n bits.
-- D'ou la necessite d'inclure la retenue précédente du bit de poids inferieur.

-- On pourrait utiliser l'additionneur pour implementer le soustracteur
-- Mais le temps de latence risquerait d'etre plus elevé.

-- utilise 1 XOR3 pour le resultat et
-- 3 NAND2 + 1 NAND3 + 2 NOT pour la retenue
-- donc 18 NANDS.
-- Temps latence de Q = Temps latence(XOR3) = 6 NANDS
-- Temps latence de la retenue = Temps latence(NAND3 + NAND1) = 3 + 1 = 4 NANDS

library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity SUB_GATE is
port(	A:			in std_logic;
			B:			in std_logic;
			C_IN:		in std_logic;  -- retenue précédente
			Q:			out std_logic;  -- Q = A XOR B XOR C_IN
			C_OUT:	out std_logic); -- C_OUT = nouvelle retenue = {A < B + C_IN}
end SUB_GATE;

architecture arch of SUB_GATE is

component XOR3_GATE
port(	A:	in std_logic;
	    B:	in std_logic;
	    C:	in std_logic;
      Q:	out std_logic);
end component;

component NOT_GATE
port(	A:	in std_logic;
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


signal Q_NOT_A: std_logic;
signal Q_NOT_B: std_logic;
signal Q_NOT_C_IN: std_logic;

signal Q_NAND_TEMP1: std_logic;
signal Q_NAND_TEMP2: std_logic;
signal Q_NAND_TEMP3: std_logic;

begin
		-- Calcul output Q
		Xor31: XOR3_GATE port map (A, B, C_IN, Q);

		-- Calcul retenue C_OUT
    Nand31: NAND3_GATE port map (A, B, C_IN, Q_NAND_TEMP1);

    Not1:  NOT_GATE port map (A, Q_NOT_A);
    Not2:  NOT_GATE port map (B, Q_NOT_B);
    Not3:  NOT_GATE port map (C_IN, Q_NOT_C_IN);

    Nand11: NAND_GATE port map (Q_NOT_B, Q_NOT_C_IN, Q_NAND_TEMP2);
    Nand12: NAND_GATE port map (Q_NOT_A, Q_NAND_TEMP2, Q_NAND_TEMP3);
    Nand13: NAND_GATE port map (Q_NAND_TEMP1, Q_NAND_TEMP3, C_OUT);
end arch;

