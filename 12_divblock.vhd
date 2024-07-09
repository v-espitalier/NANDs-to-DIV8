
--------------------------
-- 8-bit block DIV gate --
--------------------------
 
-- Utilise 1 SUB8 + 1 MUX8 + 1 NOT + 1 AND tous en cascade
-- Donc 144 + 32 + 3 = 179 NANDS.

-- Q = AND(CTR, A >= B)
-- Si Q = 1, propage le resultat de la soustraction dans R, i.e. R = A - B.
-- Si Q = 0, R = A.

-- Temps latence max  = ( 1 SUB8 + 1 MUX8 + 3 NANDS en cascade) = 34 + 3 + 3 = 40 NANDS de latence max

library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity DIV8BLOCK_GATE is
port(	A:			in std_logic_vector (7 downto 0);
			B:			in std_logic_vector (7 downto 0);
			CTR:    in std_logic;
			Q:			inout std_logic;
			R:			out std_logic_vector (7 downto 0));
end DIV8BLOCK_GATE;

architecture arch of DIV8BLOCK_GATE is

component AND_GATE
port( A:  in std_logic;
      B:  in std_logic;
      Q:  out std_logic);
end component;

component NOT_GATE
port( A:  in std_logic;
      Q:  out std_logic);
end component;

component SUB8_GATE
port( A:      in std_logic_vector (7 downto 0);
      B:      in std_logic_vector (7 downto 0);
      C_IN:   in std_logic;  -- retenue précédente
      Q:      out std_logic_vector (7 downto 0);
      C_OUT:  out std_logic); -- C_OUT = nouvelle retenue
end component;

component MUX8_GATE
port( A:      in std_logic_vector (7 downto 0);
      B:      in std_logic_vector (7 downto 0);
      C:      in std_logic; 
      Q:      out std_logic_vector (7 downto 0));
end component;


signal R_temp: std_logic_vector (7 downto 0);
signal carry: std_logic;
signal not_carry: std_logic;

begin
-- entity DIV8BLOCK_GATE is
-- port(A:			in std_logic_vector (7 downto 0);
-- 	 		B:			in std_logic_vector (7 downto 0);
--			CTR:    in std_logic;
--			Q:			inout std_logic;
--			R:			out std_logic_vector (7 downto 0));
-- end DIV8BLOCK_GATE;
	Sub1: SUB8_GATE port map (A, B, '0', R_temp, carry);
	Not1:	NOT_GATE port map (carry, not_carry);
	And1: AND_GATE port map (CTR, not_carry, Q);
	Mux1: MUX8_GATE port map (A, R_temp, Q, R);

end arch;

