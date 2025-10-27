library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity Funcmi is
	port (
		clk          : in std_logic;
		dma          : in std_logic;
		ext_adr      : in std_logic_vector(15 downto 0);
		ext_in       : out std_logic_vector(15 downto 0);
		ext_out      : in std_logic_vector(15 downto 0);
		ext_rdwr     : in std_logic;
		idle         : out std_logic;
		inpr         : in std_logic_vector(15 downto 0);
		m            : in std_logic;
		outr         : out std_logic_vector(15 downto 0);
		rst          : in std_logic;
		s            : in std_logic
	);
end Funcmi;

architecture ARC_Funcmi of Funcmi is

	type FSMStates is (
		a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, 
		a16, a17, a18, a19, a20, a21, a22, a23, a24, a25, a26, a27, a28, a29
	);
	type bor_type is array (integer range 0 to 15) of std_logic_vector(15 downto 0);
	type m0_type is array (integer range 0 to 65535) of std_logic_vector(7 downto 0);
	type m1_type is array (integer range 0 to 65535) of std_logic_vector(15 downto 0);

	signal bac : std_logic_vector(3 downto 0);
	signal bor : bor_type;
	signal br : std_logic_vector(15 downto 0);
	signal currentState : FSMStates;
	signal ir1 : std_logic_vector(15 downto 0);
	signal ir2 : std_logic_vector(15 downto 0);
	signal m0 : m0_type;
	signal m1 : m1_type;
	signal mac : std_logic_vector(15 downto 0);
	signal pc : std_logic_vector(15 downto 0);
	signal ralu : std_logic_vector(15 downto 0);
	signal zf : std_logic;

begin

	process (clk , rst)

		variable alu_ctr : std_logic_vector(4 downto 0);
		variable alu_inp1 : std_logic_vector(15 downto 0);
		variable alu_inp2 : std_logic_vector(15 downto 0);
		variable alu_outp : std_logic_vector(15 downto 0);
		variable alu_z : std_logic;
		variable bor_adr : std_logic_vector(3 downto 0);
		variable m0_address : std_logic_vector(15 downto 0);
		variable m1_address : std_logic_vector(15 downto 0);

	procedure proc_Funcmi is 
	begin


	case currentState is
	when a1 =>
		if (s and dma and ext_rdwr and m) = '1' then
			m1_address := ext_adr;
			m1(to_integer(unsigned(m1_address))) <= br;
			currentState <= a1;
			idle <= '1';

		elsif (s and dma and ext_rdwr and not m) = '1' then
			mac <= ext_adr;
			br <= ext_out;
			currentState <= a2;

		elsif (s and dma and not ext_rdwr and m) = '1' then
			m1_address := ext_adr;
			currentState <= a3;

		elsif (s and dma and not ext_rdwr and not m) = '1' then
			mac <= ext_adr;
			currentState <= a4;

		elsif (s and not dma) = '1' then
			m0_address := pc;
			currentState <= a5;

		else
			currentState <= a1;
			idle <= '1';

		end if;

	when a2 =>
		
			m0_address := mac;
			m0(to_integer(unsigned(m0_address))) <= br(15 downto 8);
			currentState <= a6;

	when a3 =>
		
			m1_address := ext_adr;
			br <= m1(to_integer(unsigned(m1_address)));
			currentState <= a1;
			idle <= '1';

	when a4 =>
		
			m0_address := mac;
			currentState <= a7;

	when a5 =>
		
			ir1(15 downto 8) <= m0(to_integer(unsigned(m0_address)));
			currentState <= a8;

	when a6 =>
		
			mac <= std_logic_vector(unsigned(mac) + 1);
			currentState <= a9;

	when a7 =>
		
			m0_address := mac;
			br(15 downto 8) <= m0(to_integer(unsigned(m0_address)));
			currentState <= a10;

	when a8 =>
		
			pc <= std_logic_vector(unsigned(pc) + 1);
			currentState <= a11;

	when a9 =>
		
			m0_address := mac;
			m0(to_integer(unsigned(m0_address))) <= br(7 downto 0);
			currentState <= a1;
			idle <= '1';

	when a10 =>
		
			mac <= std_logic_vector(unsigned(mac) + 1);
			currentState <= a12;

	when a11 =>
		
			m0_address := pc;
			currentState <= a13;

	when a12 =>
		
			m0_address := mac;
			currentState <= a14;

	when a13 =>
		
			ir1(7 downto 0) <= m0(to_integer(unsigned(m0_address)));
			currentState <= a15;

	when a14 =>
		
			m0_address := mac;
			br(7 downto 0) <= m0(to_integer(unsigned(m0_address)));
			currentState <= a16;

	when a15 =>
		
			pc <= std_logic_vector(unsigned(pc) + 1);
			currentState <= a17;

	when a16 =>
		
			ext_in <= br;
			currentState <= a1;
			idle <= '1';

	when a17 =>
		if (ir1(15) and ir1(14) and ir1(11)) = '1' then
			bor_adr := ir1(7 downto 4);
			br <= bor(to_integer(unsigned(bor_adr)));
			currentState <= a18;

		elsif (ir1(15) and ir1(14) and not ir1(11)) = '1' then
			br <= inpr;
			currentState <= a19;

		elsif (ir1(15) and not ir1(14)) = '1' then
			m0_address := pc;
			currentState <= a20;

		elsif (not ir1(15) and ir1(14)) = '1' then
			m0_address := pc;
			currentState <= a20;

		else
			bor_adr := ir1(3 downto 0);
			ir2 <= bor(to_integer(unsigned(bor_adr)));
			currentState <= a21;

		end if;

	when a18 =>
		if (ir1(15)) = '1' then
			outr <= br;
			currentState <= a1;
			idle <= '1';

		else
			alu_inp1 := br;
			alu_inp2 := ir2;
			alu_ctr := ir1(15 downto 11);
			alu(alu_inp1, alu_inp2, alu_ctr, alu_outp, alu_z);
			ralu <= alu_outp;
			zf <= alu_z;
			currentState <= a22;

		end if;

	when a19 =>
		
			bor_adr := ir1(7 downto 4);
			bor(to_integer(unsigned(bor_adr))) <= br;
			currentState <= a1;
			idle <= '1';

	when a20 =>
		
			ir2(15 downto 8) <= m0(to_integer(unsigned(m0_address)));
			currentState <= a23;

	when a21 =>
		
			bor_adr := ir1(7 downto 4);
			br <= bor(to_integer(unsigned(bor_adr)));
			currentState <= a18;

	when a22 =>
		
			bor_adr := ir1(7 downto 4);
			bor(to_integer(unsigned(bor_adr))) <= ralu;
			currentState <= a1;
			idle <= '1';

	when a23 =>
		
			pc <= std_logic_vector(unsigned(pc) + 1);
			currentState <= a24;

	when a24 =>
		
			m0_address := pc;
			currentState <= a25;

	when a25 =>
		
			ir2(7 downto 0) <= m0(to_integer(unsigned(m0_address)));
			currentState <= a26;

	when a26 =>
		
			pc <= std_logic_vector(unsigned(pc) + 1);
			currentState <= a27;

	when a27 =>
		if (ir1(3 downto 0) = x"0" and (ir1(15) and ir1(8) and ir1(12)) = '1') then
			m1_address := ir2;
			currentState <= a28;

		elsif (not (ir1(3 downto 0) = x"0") and (ir1(15) and ir1(8) and ir1(12)) = '1') then
			bor_adr := ir1(3 downto 0);
			ir2 <= std_logic_vector(unsigned(ir2) + unsigned(bor(to_integer(unsigned(bor_adr)))));
			currentState <= a29;

		elsif (ir1(15) and ir1(8) and not ir1(12)) = '1' then
			bor_adr := ir1(7 downto 4);
			bor(to_integer(unsigned(bor_adr))) <= ir2;
			currentState <= a1;
			idle <= '1';

		elsif (ir1(3 downto 0) = x"0" and (ir1(15) and not ir1(8)) = '1') then
			m1_address := ir2;
			currentState <= a28;

		elsif (not (ir1(3 downto 0) = x"0") and (ir1(15) and not ir1(8)) = '1') then
			bor_adr := ir1(3 downto 0);
			ir2 <= std_logic_vector(unsigned(ir2) + unsigned(bor(to_integer(unsigned(bor_adr)))));
			currentState <= a29;

		elsif (not ir1(15) and zf and ir1(8)) = '1' then
			pc <= ir2;
			currentState <= a1;
			idle <= '1';

		elsif (ir1(3 downto 0) = x"0" and (not ir1(15) and zf and not ir1(8)) = '1') then
			m1_address := ir2;
			currentState <= a28;

		elsif (not (ir1(3 downto 0) = x"0") and (not ir1(15) and zf and not ir1(8)) = '1') then
			bor_adr := ir1(3 downto 0);
			ir2 <= std_logic_vector(unsigned(ir2) + unsigned(bor(to_integer(unsigned(bor_adr)))));
			currentState <= a29;

		elsif (not ir1(15) and not zf and ir1(11)) = '1' then
			currentState <= a1;
			idle <= '1';

		elsif (not ir1(15) and not zf and not ir1(11) and ir1(8)) = '1' then
			pc <= ir2;
			currentState <= a1;
			idle <= '1';

		elsif (ir1(3 downto 0) = x"0" and (not ir1(15) and not zf and not ir1(11) and not ir1(8)) = '1') then
			m1_address := ir2;
			currentState <= a28;

		else
			bor_adr := ir1(3 downto 0);
			ir2 <= std_logic_vector(unsigned(ir2) + unsigned(bor(to_integer(unsigned(bor_adr)))));
			currentState <= a29;

		end if;

	when a28 =>
		if (ir1(15) and ir1(12)) = '1' then
			bor_adr := ir1(7 downto 4);
			m1_address := ir2;
			m1(to_integer(unsigned(m1_address))) <= bor(to_integer(unsigned(bor_adr)));
			currentState <= a1;
			idle <= '1';

		elsif (ir1(15) and not ir1(12)) = '1' then
			bor_adr := ir1(7 downto 4);
			m1_address := ir2;
			bor(to_integer(unsigned(bor_adr))) <= m1(to_integer(unsigned(m1_address)));
			currentState <= a1;
			idle <= '1';

		else
			m1_address := ir2;
			pc <= m1(to_integer(unsigned(m1_address)));
			currentState <= a1;
			idle <= '1';

		end if;

	when a29 =>
		
			m1_address := ir2;
			currentState <= a28;

	end case;
	end proc_Funcmi;

	begin
		if (rst = '1') then
			bac <= (others => '0');
			br <= (others => '0');
			ext_in <= (others => '0');
			idle <= '0';
			ir1 <= (others => '0');
			ir2 <= (others => '0');
			mac <= (others => '0');
			outr <= (others => '0');
			pc <= (others => '0');
			ralu <= (others => '0');
			zf <= '0';

			currentState <= a1;
			idle <= '1';

		elsif (clk'event and clk = '1') then
			idle <= '0';
			proc_Funcmi;
		end if;
	end process;

end ARC_Funcmi;
