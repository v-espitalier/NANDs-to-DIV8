
--------------------------------------
-- 8-bit Controlled-ADD with carry in/out gate --
--------------------------------------

-- Utilise l'additionneur 8 bits + 8 AND en entree
-- Donc 8 * 16 + 8 * 2 = 144 NANDS.

-- (C_OUT * 256 + Q) = (A + B * CTR + C_IN)

-- Temps latence de Q8 = 34 (add8) + 2 (NAND*2) = 36 NANDS de latence
-- Temps latence de la retenue = 32 + 2 = 34 NANDS de latence

library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity CADD8_GATE is
port(	A:			in std_logic_vector (7 downto 0);
			B:			in std_logic_vector (7 downto 0);
			CTR:		in std_logic;  -- Control bit
			C_IN:		in std_logic;  -- retenue précédente
			Q:			out std_logic_vector (7 downto 0);
			C_OUT:	out std_logic); -- C_OUT = nouvelle retenue
end CADD8_GATE;

architecture arch of CADD8_GATE is

component ADD8_GATE
port( A:      in std_logic_vector (7 downto 0);
      B:      in std_logic_vector (7 downto 0);
      C_IN:   in std_logic;  -- retenue précédente
      Q:      out std_logic_vector (7 downto 0);
      C_OUT:  out std_logic); -- C_OUT = nouvelle retenue
end component;

component AND_GATE
port( A:      in std_logic;
      B:      in std_logic;
      Q:      out std_logic);
end component;

signal CTR_B:     std_logic_vector (7 downto 0);

begin
	And1: AND_GATE port map (CTR, B(0), CTR_B(0));
	And2: AND_GATE port map (CTR, B(1), CTR_B(1));
	And3: AND_GATE port map (CTR, B(2), CTR_B(2));
	And4: AND_GATE port map (CTR, B(3), CTR_B(3));
	And5: AND_GATE port map (CTR, B(4), CTR_B(4));
	And6: AND_GATE port map (CTR, B(5), CTR_B(5));
	And7: AND_GATE port map (CTR, B(6), CTR_B(6));
	And8: AND_GATE port map (CTR, B(7), CTR_B(7));

	Add8: ADD8_GATE port map (A, CTR_B, C_IN, Q, C_OUT);

end arch;

