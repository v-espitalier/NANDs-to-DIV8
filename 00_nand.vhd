
-----------------------
-- 2-input NAND gate --
-----------------------

library ieee;
use ieee.std_logic_1164.all;

entity NAND_GATE is
port(	A:	in std_logic;
			B:	in std_logic;
			Q:	out std_logic
);
end NAND_GATE;

architecture arch of NAND_GATE is
begin
	Q <= not(A and B) after 1 ns;   -- Brique elementaire NAND :
-- On ne décrit pas précisément comment elle est calculée avec d'autres composants,
-- on fait confiance à l'implémentation hardware.
-- Le temps de réponse permet de se rendre compte du nombre de NAND successifs necessaires
-- pour faire des calculs complexes

-- process(A,B)
-- begin
--	Q <= not(A and B);   -- Brique elementaire NAND :
-- --  On ne décrit pas précisément comment elle est calculée avec d'autres composants,
-- -- on fait confiance à l'implémentation hardware.
-- end process;

end arch;

