
---------------
-- 8-bit MUX --
---------------

-- Q = A if C = 0; Q = B si C = 1.
-- Autrement dit : Q = A.not(C) + B.C   (vectoriel)

-- Utilise 8 portes MUX-1-bit en parrallele
-- Donc 8 * 4 = 32 NANDS.

-- Temps latence = Temps latence (1-bit MUX) = 3 NANDS.

-- Rq : Le MUX 8 bits va complementer 8 fois C. Ca fait 7 portes NAND qui auraient pu etre
-- economisées. En fait, cela ne change rien au niveau performance, ces NANDS sont en parrallele
-- On perdrait toutefois un peu en lisibilité si on minimisait le nombre de NANDS, d'ou le choix actuel.

library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity MUX8_GATE is
port(	A:			in std_logic_vector (7 downto 0);
			B:			in std_logic_vector (7 downto 0);
			C:			in std_logic; 
			Q:			out std_logic_vector (7 downto 0));
end MUX8_GATE;

architecture arch of MUX8_GATE is

component MUX_GATE
port( A:      in std_logic;
      B:      in std_logic;
      C:			in std_logic;
      Q:      out std_logic);
end component; 

begin
		Mux1: MUX_GATE port map (A(0), B(0), C, Q(0));
		Mux2: MUX_GATE port map (A(1), B(1), C, Q(1));
		Mux3: MUX_GATE port map (A(2), B(2), C, Q(2));
		Mux4: MUX_GATE port map (A(3), B(3), C, Q(3));
		Mux5: MUX_GATE port map (A(4), B(4), C, Q(4));
		Mux6: MUX_GATE port map (A(5), B(5), C, Q(5));
		Mux7: MUX_GATE port map (A(6), B(6), C, Q(6));
		Mux8: MUX_GATE port map (A(7), B(7), C, Q(7));
end arch;

