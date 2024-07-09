
----------------------------
-- 1-bit Multiplexor gate --
----------------------------

-- Brique de base du MUX-8 bits.

-- Q = A if C = 0; Q = B si C = 1.
-- Autrement dit : Q = A.not(C) + B.C

-- utilise 4 NANDS (1 pour complementer C, 2 intermediaires, 1 final)
-- Temps latence = 3 NANDS

library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity MUX_GATE is
port(	A:			in std_logic;
			B:			in std_logic;
			C:			in std_logic;
			Q:			out std_logic);	--   = A if C = 0;  = B si C = 1.
end MUX_GATE;

architecture arch of MUX_GATE is

component NOT_GATE
port(	A:	in std_logic;
      Q:	out std_logic);
end component;

component NAND_GATE
port(	A:	in std_logic;
	    B:	in std_logic;
      Q:	out std_logic);
end component;

signal Q_NOT_C: std_logic;
signal Q_NAND1: std_logic;
signal Q_NAND2: std_logic;

begin
    Not1: NOT_GATE port map (C, Q_NOT_C);

    Nand1: NAND_GATE port map (A, Q_NOT_C, Q_NAND1);
    Nand2: NAND_GATE port map (B, C, Q_NAND2);

    Nand3: NAND_GATE port map (Q_NAND1, Q_NAND2, Q);
end arch;

