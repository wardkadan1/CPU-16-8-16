library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memAlt65536x16 is
	generic
	(
		address_width	: integer := 16;
		data_width		: integer := 16
	);
	port
	(
		clock			: in  std_logic;
		address			: in  std_logic_vector(address_width - 1 downto 0);
		data			: in  std_logic_vector(data_width - 1 downto 0);
		wren			: in  std_logic;
		q				: out std_logic_vector(data_width - 1 downto 0)
	);
end memAlt65536x16;

architecture rtl of memAlt65536x16 is
	type memAlt65536x16 is array(0 to 2 ** address_width - 1) of std_logic_vector(data_width - 1 downto 0);

	signal memAlt65536x16_block : memAlt65536x16;
begin
	process (clock)
	begin
		if (clock'event and clock = '1') then
			if (wren = '1') then
			    memAlt65536x16_block(to_integer(unsigned(address))) <= data;
			end if;

			q <= memAlt65536x16_block(to_integer(unsigned(address)));
		end if;
	end process;
end rtl;
