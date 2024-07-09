
--------------------------------------
-- 8-bit SHL with carry in/out gate --
--------------------------------------

-- Utilise 0 NANDS : Seulement de la connectique.
-- Temps latence de 0 NANDS.

library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity SHL8_GATE is
port(	A:			in std_logic_vector (7 downto 0);
			C_IN:		in std_logic;  -- Future valeur de Q(0)
			Q:			out std_logic_vector (7 downto 0);
			C_OUT:	out std_logic); -- Ancienne valeur de A(7)
end SHL8_GATE;

architecture arch of SHL8_GATE is

begin
		Q(0) <= C_IN;
		Q(1) <= A(0);
		Q(2) <= A(1);
		Q(3) <= A(2);
		Q(4) <= A(3);
		Q(5) <= A(4);
		Q(6) <= A(5);
		Q(7) <= A(6);
		C_OUT <= A(7);
end arch;

