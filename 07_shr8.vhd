
--------------------------------------
-- 8-bit SHR with carry in/out gate --
--------------------------------------

-- Utilise 0 NANDS : Seulement de la connectique.
-- Temps latence de 0 NANDS.

library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity SHR8_GATE is
port(	A:			in std_logic_vector (7 downto 0);
			C_IN:		in std_logic;  -- Future valeur de Q(0)
			Q:			out std_logic_vector (7 downto 0);
			C_OUT:	out std_logic); -- Ancienne valeur de A(7)
end SHR8_GATE;

architecture arch of SHR8_GATE is

begin
		C_OUT <= A(0);
		Q(0) <= A(1);
		Q(1) <= A(2);
		Q(2) <= A(3);
		Q(3) <= A(4);
		Q(4) <= A(5);
		Q(5) <= A(6);
		Q(6) <= A(7);
		Q(7) <= C_IN;
end arch;

