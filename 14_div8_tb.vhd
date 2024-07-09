
-----------------------------------------
-- Test Bench du div 8 bits --
-----------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
 
entity DIV8_TB is
end DIV8_TB; 
 
architecture arch of DIV8_TB is 

component DIV8_GATE
port( A:      in std_logic_vector (7 downto 0);
      B:      in std_logic_vector (7 downto 0);
      Q:      inout std_logic_vector (7 downto 0);
      R:      out std_logic_vector (7 downto 0);
      O:      out std_logic); -- Overflow, si B = 0
end component;

signal A, B, Q, R:     std_logic_vector (7 downto 0);
signal O:							std_logic;

function isValid (A, B, Q, R	: std_logic_vector (7 downto 0);
														O : std_logic) return std_logic is
variable result : std_logic;

begin
	result := '1';
	-- implementer la verification ici
	-- (on fait la verification au niveau visuel avec gtkwave sinon)
	return result;
end;
	

begin 

    Div8: DIV8_GATE port map (A, B, Q, R, O); 

    process 

		variable tb_failed: integer := 0;

    begin
		
		A <= "00000000";
		B <= "00000000";
		wait for 500 ns;
		if (isValid(A, B, Q, R, O)/='1') then
			report "Regtest a échoué - test 1" severity error;
		    tb_failed := 1;
		end if;

		A <= "00001001";
		B <= "00000011";
		wait for 500 ns;
		if (isValid(A, B, Q, R, O)/='1') then
			report "Regtest a échoué - test 2" severity error;
		    tb_failed := 2;
		end if;

		A <= "00110011";
		B <= "00000100";
		wait for 500 ns;
		if (isValid(A, B, Q, R, O)/='1') then
			report "Regtest a échoué - test 3" severity error;
		    tb_failed := 3;
		end if;

		A <= "11001011";
		B <= "11101010";
		wait for 500 ns;
		if (isValid(A, B, Q, R, O)/='1') then
			report "Regtest a échoué - test 4" severity error;
		    tb_failed := 4;
		end if;

		A <= "11010101";
		B <= "00001001";
		wait for 500 ns;
		if (isValid(A, B, Q, R, O)/='1') then
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

