-- Automatically generated using Goals v1.0.1.170
-----------------------------
library IEEE;
use IEEE.std_logic_1164.all;
-----------------------------
entity mux_6x8 is
	port
		(
		din0           	: in std_logic_vector (7 downto 0);
		din1           	: in std_logic_vector (7 downto 0);
		din2           	: in std_logic_vector (7 downto 0);
		din3           	: in std_logic_vector (7 downto 0);
		din4           	: in std_logic_vector (7 downto 0);
		din5           	: in std_logic_vector (7 downto 0);
		ctr_mux        	: in std_logic_vector (2 downto 0);
		dout           	: out std_logic_vector (7 downto 0)
		);
end mux_6x8;
-----------------------------
architecture arc_mux_6x8 of mux_6x8 is
begin
	process (din0, din1, din2, din3, din4, din5, ctr_mux)
		begin
			case ctr_mux is
				when "000" => dout <= din0;
				when "001" => dout <= din1;
				when "010" => dout <= din2;
				when "011" => dout <= din3;
				when "100" => dout <= din4;
				when "101" => dout <= din5;
				when others => dout <= (others => '0');
			end case;
	end process;
end arc_mux_6x8;
-----------------------------
configuration cfg_mux_6x8 of mux_6x8 is
	for arc_mux_6x8
	end for;
end cfg_mux_6x8;
-----------------------------
