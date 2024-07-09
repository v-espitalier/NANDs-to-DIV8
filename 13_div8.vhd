
--------------------------------------
-- 8-bit DIV gate --
--------------------------------------
 
-- Utilise 8 BLOCDIV (SUB8 + MUX8) + 8 OR et NOT tous en cascade ( + des SHL qui ne coutent rien)
-- Donc 8 * 179 + 8 * 32 + 8 * 4 = 1720 NANDS.

-- A = Q * B + R, tel que R >= 0, R < B

-- Temps latence max ( 8 SUB8 et 8 MUX8 en cascade) = 8 * 40 + 8 * 4 = 352 NANDS de latence max

library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity DIV8_GATE is
port(	A:			in std_logic_vector (7 downto 0);
			B:			in std_logic_vector (7 downto 0);
			Q:			inout std_logic_vector (7 downto 0);
			R:			out std_logic_vector (7 downto 0);
			O:			out std_logic); -- Overflow, si B = 0
end DIV8_GATE;

architecture arch of DIV8_GATE is

component SHL8_GATE
port( A:      in std_logic_vector (7 downto 0);
      C_IN:   in std_logic;  -- Future valeur de Q(0)
      Q:      out std_logic_vector (7 downto 0);
      C_OUT:  out std_logic); -- Ancienne valeur de A(7)
end component;

component NOT_GATE
port( A:  in std_logic;
      Q:  out std_logic);
end component;

component OR_GATE
port( A:  in std_logic;
      B:  in std_logic;
      Q:  out std_logic);
end component;

component DIV8BLOCK_GATE
port( A:      in std_logic_vector (7 downto 0);
      B:      in std_logic_vector (7 downto 0);
      CTR:    in std_logic;
      Q:      inout std_logic;
      R:      out std_logic_vector (7 downto 0));
end component;

-- SHL successifs de B
signal B2l, B4l, B8l, B16l, B32l, B64l, B128l: std_logic_vector (7 downto 0);
signal Bo: std_logic_vector (7 downto 0);  -- Overflow SHL de B
signal Bo_prop: std_logic_vector (7 downto 0);  -- Propagation Overflow
signal CTR: std_logic_vector (7 downto 0); -- = NOT (Bo_prop)  => B n'a pas overflow

-- Restes partiels
signal R7, R6, R5, R4, R3, R2, R1: std_logic_vector (7 downto 0);


signal carry: std_logic_vector (7 downto 0);
signal dummy1, dummy2: std_logic_vector (15 downto 0);

signal OFB: std_logic_vector (7 downto 0);

begin

	-- Cablages ..
	Shl1: SHL8_GATE port map (B, '0', B2l, Bo(0));
	Bo_prop(0) <= Bo(0);
	Shl2: SHL8_GATE port map (B2l, '0', B4l, Bo(1));
	Shl3: SHL8_GATE port map (B4l, '0', B8l, Bo(2));
	Shl4: SHL8_GATE port map (B8l, '0', B16l, Bo(3));
	Shl5: SHL8_GATE port map (B16l, '0', B32l, Bo(4));
	Shl6: SHL8_GATE port map (B32l, '0', B64l, Bo(5));
	Shl7: SHL8_GATE port map (B64l, '0', B128l, Bo(6));

	-- Propagation Overflow
	Or1:  OR_GATE port map (Bo(1), Bo_prop(0), Bo_prop(1));
	Or2:  OR_GATE port map (Bo(2), Bo_prop(1), Bo_prop(2));
	Or3:  OR_GATE port map (Bo(3), Bo_prop(2), Bo_prop(3));
	Or4:  OR_GATE port map (Bo(4), Bo_prop(3), Bo_prop(4));
	Or5:  OR_GATE port map (Bo(5), Bo_prop(4), Bo_prop(5));
	Or6:  OR_GATE port map (Bo(6), Bo_prop(5), Bo_prop(6));

	-- Calcul des bits de controle de non-overfow
	Not1: NOT_GATE port map (Bo_prop(0), CTR(0));
	Not2: NOT_GATE port map (Bo_prop(1), CTR(1));
	Not3: NOT_GATE port map (Bo_prop(2), CTR(2));
	Not4: NOT_GATE port map (Bo_prop(3), CTR(3));
	Not5: NOT_GATE port map (Bo_prop(4), CTR(4));
	Not6: NOT_GATE port map (Bo_prop(5), CTR(5));
	Not7: NOT_GATE port map (Bo_prop(6), CTR(6));
	Not8: NOT_GATE port map (Bo_prop(7), CTR(7));

	-- Calcul de la division : Soustraction avec reste partiel - 1 / 8
	DivBlock1: DIV8BLOCK_GATE port map (A, B128l, CTR(6), Q(7), R7);

	-- Calcul de la division : Soustraction avec reste partiel - 2 / 8
	DivBlock2: DIV8BLOCK_GATE port map (R7, B64l, CTR(5), Q(6), R6);
	
	-- Calcul de la division : Soustraction avec reste partiel - 3 / 8
	DivBlock3: DIV8BLOCK_GATE port map (R6, B32l, CTR(4), Q(5), R5);

	-- Calcul de la division : Soustraction avec reste partiel - 4 / 8
	DivBlock4: DIV8BLOCK_GATE port map (R5, B16l, CTR(3), Q(4), R4);


	-- Calcul de la division : Soustraction avec reste partiel - 5 / 8
	DivBlock5: DIV8BLOCK_GATE port map (R4, B8l, CTR(2), Q(3), R3);

	-- Calcul de la division : Soustraction avec reste partiel - 6 / 8
	DivBlock6: DIV8BLOCK_GATE port map (R3, B4l, CTR(1), Q(2), R2);

	-- Calcul de la division : Soustraction avec reste partiel - 7 / 8
	DivBlock7: DIV8BLOCK_GATE port map (R2, B2l, CTR(0), Q(1), R1);

	-- Calcul de la division : Soustraction avec reste partiel - 8 / 8
	DivBlock8: DIV8BLOCK_GATE port map (R1, B, '1', Q(0), R);

	-- Calcul (independent) du flag de division par zero
	-- Utilise certainement trop de NANDS, et le temps de latence
  -- pourraient etre optimises, mais le calcul de la division
  -- au dessus prend de toute facon beaucoup plus de temps
  -- et les calculs sont faits en parrallele.
	Or21: OR_GATE port map (B(0), B(1), OFB(0));
	Or22: OR_GATE port map (B(2), B(3), OFB(1));
	Or23: OR_GATE port map (B(4), B(5), OFB(2));
	Or24: OR_GATE port map (B(6), B(7), OFB(3));
	Or25: OR_GATE port map (OFB(0), OFB(1), OFB(4));
	Or26: OR_GATE port map (B(2), B(3), OFB(5));
	Or27: OR_GATE port map (OFB(4), OFB(5), OFB(6));
	Not10: NOT_GATE port map (OFB(6), O);

end arch;

