
----------------------
-- 3-input XOR gate --
----------------------

-- utilise 2 XOR 2-input en cascade donc
-- 10 NANDS.
-- Temps latence = 6 NANDS (probablement optimisable)

-- Utilise pour la brique elementaire de l'additionneur

library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity XOR3_GATE is
port(	A:	in std_logic;
			B:	in std_logic;
			C:	in std_logic;
			Q:	out std_logic);
end XOR3_GATE;

architecture arch of XOR3_GATE is

component XOR_GATE
port(	A:	in std_logic;
	    B:	in std_logic;
      Q:	out std_logic);
end component;

signal Q_XOR_AB: std_logic;

begin
    Xor1: XOR_GATE port map (A, B, Q_XOR_AB);
    Xor2: XOR_GATE port map (Q_XOR_AB, C, Q);
end arch;

