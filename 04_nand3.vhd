
----------------------
-- 3-input NAND gate --
----------------------

-- utilise 1 AND + 1 NAND
-- donc 3 NANDS. Temps latence = 3 NANDS

-- Fait partie de la brique elementaire de l'additionneur

library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity NAND3_GATE is
port(	A:	in std_logic;
			B:	in std_logic;
			C:	in std_logic;
			Q:	out std_logic);
end NAND3_GATE;

architecture arch of NAND3_GATE is

component AND_GATE
port(	A:	in std_logic;
	    B:	in std_logic;
      Q:	out std_logic);
end component;

component NAND_GATE
port(	A:	in std_logic;
	    B:	in std_logic;
      Q:	out std_logic);
end component;

signal Q_AND_AB: std_logic;

begin
    And1: AND_GATE port map (A, B, Q_AND_AB);
    Nand1: NAND_GATE port map (Q_AND_AB, C, Q);
end arch;

