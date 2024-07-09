
----------------------
-- 2-input XOR gate --
----------------------

-- utilise 2 NOTs pour calculer le complement des entrees
-- puis 3 NANDS pour implementer la logique donc 5 NANDS en tout
-- Temps latence = 3 NANDS
-- XOR(a,b) = NAND(NAND(a,-b), NAND(-a,b))

-- On aurait pu faire une implementation claire avec des portes AND et OR,
-- mais cette porte de base risque d'etre utilisée fréquemment,
-- donc on préfère optimiser son implémentation, quitte à l'obscurcir,
-- pour minimiser son temps de latence.
-- (Implémentation avec des AND et OR de (a.-b + -a.b) a un temps de latence de 5 NANDS,
-- car on NOTerait 2 fois d'affilé les sorties des AND, et l'entrée du OR principal)

library ieee;

use ieee.std_logic_1164.all;
use work.all;

entity XOR_GATE is
port(	A:	in std_logic;
			B:	in std_logic;
			Q:	out std_logic);
end XOR_GATE;

architecture arch of XOR_GATE is

component NAND_GATE
port(	A:	in std_logic;
	    B:	in std_logic;
      Q:	out std_logic);
end component;

component NOT_GATE
port(	A:	in std_logic;
      Q:	out std_logic);
end component;

signal nA: std_logic;
signal nB: std_logic;
signal nQ1: std_logic;
signal nQ2: std_logic;

begin
    Not1: NOT_GATE port map (A, nA);
    Not2: NOT_GATE port map (B, nB);
    Nand1: NAND_GATE port map (A, nB, nQ1);
    Nand2: NAND_GATE port map (nA, B, nQ2);
    Nand3: NAND_GATE port map (nQ1, nQ2, Q);
end arch;

