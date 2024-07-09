
--------------------------------------
-- 8-bit MULT gate --
--------------------------------------

-- Utilise 14 controlled add + 8 AND2 ( + des SHL qui ne coutent rien)
-- Donc 14 * 144 + 8 * 2 = 2032 NANDS.

-- (D * 256 + Q) = (A * B)

-- Temps latence max ( 8 Controlled Add en cascade + 1 AND) = 8 * 36 + 1 * 2 = 290 NANDS de latence

library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity MULT8_GATE is
port(	A:			in std_logic_vector (7 downto 0);
			B:			in std_logic_vector (7 downto 0);
			Q:			out std_logic_vector (7 downto 0);
			D:			out std_logic_vector (7 downto 0));
end MULT8_GATE;

architecture arch of MULT8_GATE is

component CADD8_GATE
port( A:      in std_logic_vector (7 downto 0);
      B:      in std_logic_vector (7 downto 0);
      CTR:    in std_logic;  -- Control bit
      C_IN:   in std_logic;  -- retenue précédente
      Q:      out std_logic_vector (7 downto 0);
      C_OUT:  out std_logic); -- C_OUT = nouvelle retenue
end component;

component SHL8_GATE
port( A:      in std_logic_vector (7 downto 0);
      C_IN:   in std_logic;  -- Future valeur de Q(0)
      Q:      out std_logic_vector (7 downto 0);
      C_OUT:  out std_logic); -- Ancienne valeur de A(7)
end component;

component AND_GATE
port( A:      in std_logic;
      B:      in std_logic;
      Q:      out std_logic);
end component;


-- SHL successifs de B
signal B2h, B2l, B4h, B4l, B8h, B8l, B16h, B16l: std_logic_vector (7 downto 0);
signal B32h, B32l, B64h, B64l, B128h, B128l: std_logic_vector (7 downto 0);

signal Q0: std_logic_vector (7 downto 0);
signal D0: std_logic_vector (7 downto 0);
signal Q1: std_logic_vector (7 downto 0);
signal D1: std_logic_vector (7 downto 0);
signal Q2: std_logic_vector (7 downto 0);
signal D2: std_logic_vector (7 downto 0);
signal Q3: std_logic_vector (7 downto 0);
signal D3: std_logic_vector (7 downto 0);

signal Q4: std_logic_vector (7 downto 0);
signal D4: std_logic_vector (7 downto 0);
signal Q5: std_logic_vector (7 downto 0);
signal D5: std_logic_vector (7 downto 0);
signal Q6: std_logic_vector (7 downto 0);
signal D6: std_logic_vector (7 downto 0);

signal carry: std_logic_vector (7 downto 0);
signal dummy1, dummy2: std_logic_vector (15 downto 0);

begin

	-- Cablages ..
	Shl1l: SHL8_GATE port map (B, '0', B2l, B2h(0));
	B2h(1) <= '0'; B2h(2) <= '0'; B2h(3) <= '0'; B2h(4) <= '0'; B2h(5) <= '0'; B2h(6) <= '0'; B2h(7) <= '0';

	Shl2h: SHL8_GATE port map (B2h, B2l(7), B4h, dummy1(0));
	Shl2l: SHL8_GATE port map (B2l, '0', B4l, dummy1(1));

	Shl3h: SHL8_GATE port map (B4h, B4l(7), B8h, dummy1(2));
	Shl3l: SHL8_GATE port map (B4l, '0', B8l, dummy1(3));
	
	Shl4h: SHL8_GATE port map (B8h, B8l(7), B16h, dummy1(4));
	Shl4l: SHL8_GATE port map (B8l, '0', B16l, dummy1(5));

	Shl5h: SHL8_GATE port map (B16h, B16l(7), B32h, dummy1(6));
	Shl5l: SHL8_GATE port map (B16l, '0', B32l, dummy1(7));

	Shl6h: SHL8_GATE port map (B32h, B32l(7), B64h, dummy1(8));
	Shl6l: SHL8_GATE port map (B32l, '0', B64l, dummy1(9));

	Shl7h: SHL8_GATE port map (B64h, B64l(7), B128h, dummy1(10));
	Shl7l: SHL8_GATE port map (B64l, '0', B128l, dummy1(11));

	-- Addition 1 / 8
	-- Copie manuelle conditionelle
  -- Evite une addition pour rien
	And1: AND_GATE port map (A(0), B(0), Q0(0));
	And2: AND_GATE port map (A(0), B(1), Q0(1));
	And3: AND_GATE port map (A(0), B(2), Q0(2));
	And4: AND_GATE port map (A(0), B(3), Q0(3));
	And5: AND_GATE port map (A(0), B(4), Q0(4));
	And6: AND_GATE port map (A(0), B(5), Q0(5));
	And7: AND_GATE port map (A(0), B(6), Q0(6));
	And8: AND_GATE port map (A(0), B(7), Q0(7));
	D0 <= "00000000";

	-- Addition 2 / 8
	Cadd1l: CADD8_GATE port map (Q0, B2l, A(1), '0', Q1, carry(0));
	Cadd1h: CADD8_GATE port map (D0, B2h, A(1), carry(0), D1, dummy2(0));

	-- Addition 3 / 8
	Cadd2l: CADD8_GATE port map (Q1, B4l, A(2), '0', Q2, carry(1));
	Cadd2h: CADD8_GATE port map (D1, B4h, A(2), carry(1), D2, dummy2(1));

	-- Addition 4 / 8
	Cadd3l: CADD8_GATE port map (Q2, B8l, A(3), '0', Q3, carry(2));
	Cadd3h: CADD8_GATE port map (D2, B8h, A(3), carry(2), D3, dummy2(2));

	-- Addition 5 / 8
	Cadd4l: CADD8_GATE port map (Q3, B16l, A(4), '0', Q4, carry(3));
	Cadd4h: CADD8_GATE port map (D3, B16h, A(4), carry(3), D4, dummy2(3));

	-- Addition 6 / 8
	Cadd5l: CADD8_GATE port map (Q4, B32l, A(5), '0', Q5, carry(4));
	Cadd5h: CADD8_GATE port map (D4, B32h, A(5), carry(4), D5, dummy2(4));

	-- Addition 7 / 8
	Cadd6l: CADD8_GATE port map (Q5, B64l, A(6), '0', Q6, carry(5));
	Cadd6h: CADD8_GATE port map (D5, B64h, A(6), carry(5), D6, dummy2(5));

	-- Addition 8 / 8
	Cadd7l: CADD8_GATE port map (Q6, B128l, A(7), '0', Q, carry(6));
	Cadd7h: CADD8_GATE port map (D6, B128h, A(7), carry(6), D, dummy2(6));

end arch;

