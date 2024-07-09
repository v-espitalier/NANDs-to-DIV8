
----------------------
-- 1-input NOT gate --
----------------------

-- Utilise 1 porte NAND
-- temps latence = 1 NAND

library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity NOT_GATE is
port(	A:	in std_logic;
			Q:	out std_logic);
end NOT_GATE;

architecture arch of NOT_GATE is

component NAND_GATE
port(	A:	in std_logic;
	    B:	in std_logic;
      Q:	out std_logic);
end component;

begin
    Nand1: NAND_GATE port map (A, A, Q);
end arch;

