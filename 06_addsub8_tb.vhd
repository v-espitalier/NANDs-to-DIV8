
------------------------------------------------------------
-- Test Bench de l'additionneur et du soustracteur 8 bits --
------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
 
entity ADDSUB8_TB is
end ADDSUB8_TB; 
 
architecture arch of ADDSUB8_TB is 

component ADD8_GATE
port( A:      in std_logic_vector (7 downto 0);
      B:      in std_logic_vector (7 downto 0);
      C_IN:   in std_logic;  -- retenue précédente
      Q:      out std_logic_vector (7 downto 0);
      C_OUT:  out std_logic); -- C_OUT = nouvelle retenue
end component;

component SUB8_GATE
port( A:      in std_logic_vector (7 downto 0);
      B:      in std_logic_vector (7 downto 0);
      C_IN:   in std_logic;  -- retenue précédente
      Q:      out std_logic_vector (7 downto 0);
      C_OUT:  out std_logic); -- C_OUT = nouvelle retenue
end component;

signal A, B, Q_ADD, Q_SUB:     std_logic_vector (7 downto 0);
signal C_IN, C_OUT, C_OUT2: std_logic;


function isValid (A, B : std_logic_vector (7 downto 0);
									C_IN : std_logic;
									Q, Q2    : std_logic_vector (7 downto 0);
									C_OUT, C_OUT2 : std_logic) return std_logic is

variable result : std_logic;

begin
	result := '1';

	-- implementer la verification ici
	-- (on fait la verification au niveau visuel avec gtkwave sinon)

	return result;
end;
	

begin 

    Add8: ADD8_GATE port map (A, B, C_IN, Q_ADD, C_OUT); 
    Sub8: SUB8_GATE port map (Q_ADD, A, '0', Q_SUB, C_OUT2); 

    process 

		variable tb_failed: integer := 0;

    begin
		
		A <= "00000000";
		B <= "00000000";
		C_IN <= '0';
		wait for 100 ns;
		if (isValid(A, B, C_IN, Q_ADD, Q_SUB, C_OUT, C_OUT2)/='1') then
			report "Regtest a échoué - test 1" severity error;
		    tb_failed := 1;
		end if;

		A <= "00010111";
		B <= "00100011";
		C_IN <= '0';
		wait for 100 ns;
		if (isValid(A, B, C_IN, Q_ADD, Q_SUB, C_OUT, C_OUT2)/='1') then
			report "Regtest a échoué - test 2" severity error;
		    tb_failed := 2;
		end if;
		
		A <= "00110110";
		B <= "00010011";
		C_IN <= '0';
		wait for 100 ns;
		if (isValid(A, B, C_IN, Q_ADD, Q_SUB, C_OUT, C_OUT2)/='1') then
			report "Regtest a échoué - test 3" severity error;
		    tb_failed := 3;
		end if;

		A <= "10011010";
		B <= "01010011";
		C_IN <= '0';
		wait for 100 ns;
		if (isValid(A, B, C_IN, Q_ADD, Q_SUB, C_OUT, C_OUT2)/='1') then
			report "Regtest a échoué - test 4" severity error;
		    tb_failed := 4;
		end if;

		-- test de vitesse de propagation de la retenue
		A <= "00000000";
		B <= "00000000";
		C_IN <= '0';
		wait for 100 ns;
		if (isValid(A, B, C_IN, Q_ADD, Q_SUB, C_OUT, C_OUT2)/='1') then
			report "Regtest a échoué - test 5" severity error;
		    tb_failed := 5;
		end if;

		A <= "11111111";
		B <= "00000001";
		C_IN <= '0';
		wait for 100 ns;
		if (isValid(A, B, C_IN, Q_ADD, Q_SUB, C_OUT, C_OUT2)/='1') then
			report "Regtest a échoué - test 6" severity error;
		    tb_failed := 6;
		end if;

		A <= "11111111";
		B <= "00000000";
		C_IN <= '0';
		wait for 100 ns;
		if (isValid(A, B, C_IN, Q_ADD, Q_SUB, C_OUT, C_OUT2)/='1') then
			report "Regtest a échoué - test 7" severity error;
		    tb_failed := 7;
		end if;

		if (tb_failed=0) then
		  assert false report "Testbench OK" 
			severity note;
		else
			assert true
			report "Testbench a échoué"
			severity error;
		end if;

		wait;
		
	end process; 

end arch; 

