-- Automatically generated using Goals v1.0.1.170
-----------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-----------------------------
entity reg_16bit_2en is
	port
		(
		clk            	: in std_logic;
		rst            	: in std_logic;
		din            	: in std_logic_vector (15 downto 0);
		en             	: in std_logic_vector (1 downto 0);
		dout           	: out std_logic_vector (15 downto 0)
		);
end reg_16bit_2en;
-----------------------------
architecture arc_reg_16bit_2en of reg_16bit_2en is

signal s1 : std_logic_vector(7 downto 0);
signal s2 : std_logic_vector(7 downto 0);

component reg_8bit is
	port (clk, rst, en : in std_logic;
		din : in std_logic_vector(7 downto 0);
		dout : out std_logic_vector(7 downto 0));
end component;

begin

u1 : reg_8bit port map(clk, rst, en(0), din(7 downto 0), dout(7 downto 0));
u2 : reg_8bit port map(clk, rst, en(1), din(15 downto 8), dout(15 downto 8));

end arc_reg_16bit_2en;
-----------------------------
