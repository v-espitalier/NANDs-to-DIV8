
-----------------------------------------
-- Test Bench du multiplicateur 8 bits --
-----------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
 
entity MULT8_TB is
end MULT8_TB; 
 
architecture arch of MULT8_TB is 

component MULT8_GATE
port( A:      in std_logic_vector (7 downto 0);
      B:      in std_logic_vector (7 downto 0);
      Q:      out std_logic_vector (7 downto 0);
      D:      out std_logic_vector (7 downto 0));
end component;

signal A, B, Q, D:     std_logic_vector (7 downto 0);

function isValid (A, B, Q, D : std_logic_vector (7 downto 0)) return std_logic is

variable result : std_logic;

begin
	result := '1';
	-- implementer la verification ici
	-- (on fait la verification au niveau visuel avec gtkwave sinon)
	return result;
end;
	

begin 

    Mult8: MULT8_GATE port map (A, B, Q, D); 

    process 

		variable tb_failed: integer := 0;

    begin
		
		A <= "00000000";
		B <= "00000000";
		wait for 500 ns;
		if (isValid(A, B, Q, D)/='1') then
			report "Regtest a échoué - test 1" severity error;
		    tb_failed := 1;
		end if;

		A <= "00101001";
		B <= "10011011";
		wait for 500 ns;
		if (isValid(A, B, Q, D)/='1') then
			report "Regtest a échoué - test 2" severity error;
		    tb_failed := 2;
		end if;

		A <= "11000101";
		B <= "10101010";
		wait for 500 ns;
		if (isValid(A, B, Q, D)/='1') then
			report "Regtest a échoué - test 3" severity error;
		    tb_failed := 3;
		end if;

		A <= "01000001";
		B <= "00001010";
		wait for 500 ns;
		if (isValid(A, B, Q, D)/='1') then
			report "Regtest a échoué - test 4" severity error;
		    tb_failed := 4;
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

