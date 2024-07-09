
----------------------
-- 2-input AND gate --
----------------------

-- utilise 1 NAND + 1 NOT en sortie (fait a partir d'une NAND)
-- donc 2 NANDS. Temps latence = 2 NANDS

library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity AND_GATE is
port(	A:	in std_logic;
			B:	in std_logic;
			Q:	out std_logic);
end AND_GATE;

architecture arch of AND_GATE is

component NAND_GATE
port(	A:	in std_logic;
	    B:	in std_logic;
      Q:	out std_logic);
end component;

component NOT_GATE
port(	A:	in std_logic;
      Q:	out std_logic);
end component;

signal nQ: std_logic;

begin
    Nand1: NAND_GATE port map (A, B, nQ);
    Not1: NOT_GATE port map (nQ, Q);
end arch;

