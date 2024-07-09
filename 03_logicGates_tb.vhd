
--------------------------------------------------------------------
-- Test Bench des portes logiques de base : NAND, NOT, AND, OR, XOR.
-------------------------------------------------------------------- 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
 
entity LOGIC_GATES_TB is
end LOGIC_GATES_TB; 

 
architecture arch of LOGIC_GATES_TB is 

component NAND_GATE
port( A:  in std_logic;
      B:  in std_logic;
      Q:  out std_logic
);    
end component;

component NOT_GATE
port( A:  in std_logic;
      Q:  out std_logic
);    
end component;

component AND_GATE
port( A:  in std_logic;
      B:  in std_logic;
      Q:  out std_logic
);    
end component;

component OR_GATE
port( A:  in std_logic;
      B:  in std_logic;
      Q:  out std_logic
);    
end component;

component XOR_GATE
port( A:  in std_logic;
      B:  in std_logic;
      Q:  out std_logic
);    
end component;


signal A, B, Q_NAND, Q_NOT_A, Q_AND, Q_OR, Q_XOR: std_logic;

function isValid (A, B, Q_NAND, Q_NOT_A, Q_AND, Q_OR, Q_XOR : std_logic) return std_logic is
	variable result : std_logic;
begin
	result := '1';
	if (Q_NAND/=not(A and B)) then result := '0'; end if;
	if (Q_NOT_A/=not(A)) then result := '0'; end if;
	if (Q_AND/=(A and B)) then result := '0'; end if;
	if (Q_OR/=(A or B)) then result := '0'; end if;
	if (Q_XOR/=(A xor B)) then result := '0'; end if;
	return result;
end;
	

begin 

    Nand1: NAND_GATE port map (A, B, Q_NAND); 
    Not1: NOT_GATE port map (A, Q_NOT_A); 
    And1: AND_GATE port map (A, B, Q_AND); 
    Or1: OR_GATE port map (A, B, Q_OR); 
    Xor1: XOR_GATE port map (A, B, Q_XOR); 

    process 

		variable tb_failed: integer := 0;

    begin
		
		A <= '0';
		B <= '0';
		wait for 10 ns;
		if (isValid(A, B, Q_NAND, Q_NOT_A, Q_AND, Q_OR, Q_XOR)/='1') then
			report "Regtest a échoué - test 1" severity error;
		    tb_failed := 1;
		end if;
		
		A <= '1';
		B <= '0';
		wait for 10 ns;
		if (isValid(A, B, Q_NAND, Q_NOT_A, Q_AND, Q_OR, Q_XOR)/='1') then
			report "Regtest a échoué - test 1" severity error;
		    tb_failed := 1;
		end if;
		
		A <= '1';
		B <= '1';
		wait for 10 ns;
		if (isValid(A, B, Q_NAND, Q_NOT_A, Q_AND, Q_OR, Q_XOR)/='1') then
			report "Regtest a échoué - test 1" severity error;
		    tb_failed := 1;
		end if;
		
		A <= '0';
		B <= '1';
		wait for 10 ns;
		if (isValid(A, B, Q_NAND, Q_NOT_A, Q_AND, Q_OR, Q_XOR)/='1') then
			report "Regtest a échoué - test 1" severity error;
		    tb_failed := 1;
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

