
----------------------
-- 2-input OR gate --
----------------------

-- Fait a partir d'une NAND avec 2 NOT en entrée
-- Utilise donc 3 NANDS, temps latence = 2 NANDS

library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity OR_GATE is
port(	A:	in std_logic;
			B:	in std_logic;
			Q:	out std_logic);
end OR_GATE;

architecture arch of OR_GATE is

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

begin
    Not1: NOT_GATE port map (A, nA);
    Not2: NOT_GATE port map (B, nB);
    Nand1: NAND_GATE port map (nA, nB, Q);
end arch;

