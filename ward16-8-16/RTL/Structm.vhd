library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.components.all;

entity Structm is
	port (
		bor_en         : out std_logic;
		br_en_0        : out std_logic;
		br_en_1        : out std_logic;
		clk            : in std_logic;
		comp4_1_dout   : in std_logic;
		ctr_mux0       : out std_logic;
		ctr_mux1_0     : out std_logic;
		ctr_mux1_1     : out std_logic;
		ctr_mux1_2     : out std_logic;
		ctr_mux2_0     : out std_logic;
		ctr_mux2_1     : out std_logic;
		ctr_mux2_2     : out std_logic;
		ctr_mux3       : out std_logic;
		ctr_mux4_0     : out std_logic;
		ctr_mux4_1     : out std_logic;
		ctr_mux4_2     : out std_logic;
		dma            : in std_logic;
		ext_rdwr       : in std_logic;
		idle           : out std_logic;
		ir1_11         : in std_logic;
		ir1_12         : in std_logic;
		ir1_14         : in std_logic;
		ir1_15         : in std_logic;
		ir1_8          : in std_logic;
		ir1_en_0       : out std_logic;
		ir1_en_1       : out std_logic;
		ir2_en_0       : out std_logic;
		ir2_en_1       : out std_logic;
		m              : in std_logic;
		m0_wren        : out std_logic;
		m1_wren        : out std_logic;
		mac_count      : out std_logic;
		mac_en         : out std_logic;
		pc_count       : out std_logic;
		pc_en          : out std_logic;
		ralu_en        : out std_logic;
		rst            : in std_logic;
		s              : in std_logic;
		tempreg16_1_en : out std_logic;
		zf             : in std_logic;
		zf_en          : out std_logic
	);
end Structm;

architecture ARC_Structm of Structm is

	type FSMStates is (
		a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, 
		a16, a17, a18, a19, a20, a21, a22, a23, a24, a25, a26, a27, a28, a29, a30
	);

	signal currentState : FSMStates;

begin

	process (clk , rst)


	procedure proc_Structm is 
	begin

	bor_en <= '0';
	br_en_0 <= '0';
	br_en_1 <= '0';
	ctr_mux0 <= '0';
	ctr_mux1_0 <= '0';
	ctr_mux1_1 <= '0';
	ctr_mux1_2 <= '0';
	ctr_mux2_0 <= '0';
	ctr_mux2_1 <= '0';
	ctr_mux2_2 <= '0';
	ctr_mux3 <= '0';
	ctr_mux4_0 <= '0';
	ctr_mux4_1 <= '0';
	ctr_mux4_2 <= '0';
	idle <= '0';
	ir1_en_0 <= '0';
	ir1_en_1 <= '0';
	ir2_en_0 <= '0';
	ir2_en_1 <= '0';
	m0_wren <= '0';
	m1_wren <= '0';
	mac_count <= '0';
	mac_en <= '0';
	pc_count <= '0';
	pc_en <= '0';
	ralu_en <= '0';
	tempreg16_1_en <= '0';
	zf_en <= '0';

	case currentState is
	when a1 =>
		if (s and dma and ext_rdwr and m) = '1' then
			ctr_mux4_2 <= '1';
			m1_wren <= '1';
			ctr_mux3 <= '1';
			currentState <= a1;
			idle <= '1';

		elsif (s and dma and ext_rdwr and not m) = '1' then
			br_en_1 <= '1';
			br_en_0 <= '1';
			ctr_mux1_2 <= '1';
			ctr_mux2_2 <= '1';
			mac_en <= '1';
			currentState <= a2;

		elsif (s and dma and not ext_rdwr and m) = '1' then
			ctr_mux3 <= '1';
			currentState <= a3;

		elsif (s and dma and not ext_rdwr and not m) = '1' then
			mac_en <= '1';
			currentState <= a4;

		elsif (s and not dma) = '1' then
			ctr_mux4_0 <= '1';
			currentState <= a5;

		else
			currentState <= a1;
			idle <= '1';

		end if;

	when a2 =>
		
			ctr_mux1_0 <= '1';
			ctr_mux1_2 <= '1';
			m0_wren <= '1';
			currentState <= a6;

	when a3 =>
		
			br_en_1 <= '1';
			br_en_0 <= '1';
			ctr_mux1_1 <= '1';
			ctr_mux2_1 <= '1';
			ctr_mux1_2 <= '1';
			ctr_mux2_0 <= '1';
			ctr_mux3 <= '1';
			currentState <= a1;
			idle <= '1';

	when a4 =>
		
			currentState <= a7;

	when a5 =>
		
			ir1_en_1 <= '1';
			currentState <= a8;

	when a6 =>
		
			mac_count <= '1';
			currentState <= a9;

	when a7 =>
		
			br_en_1 <= '1';
			ctr_mux1_0 <= '1';
			currentState <= a10;

	when a8 =>
		
			pc_count <= '1';
			currentState <= a11;

	when a9 =>
		
			ctr_mux1_1 <= '1';
			m0_wren <= '1';
			currentState <= a1;
			idle <= '1';

	when a10 =>
		
			mac_count <= '1';
			currentState <= a12;

	when a11 =>
		
			ctr_mux4_0 <= '1';
			currentState <= a13;

	when a12 =>
		
			currentState <= a14;

	when a13 =>
		
			ir1_en_0 <= '1';
			currentState <= a15;

	when a14 =>
		
			br_en_0 <= '1';
			ctr_mux2_0 <= '1';
			currentState <= a16;

	when a15 =>
		
			pc_count <= '1';
			currentState <= a17;

	when a16 =>
		
			currentState <= a1;
			idle <= '1';

	when a17 =>
		if (ir1_15 and ir1_14 and ir1_11) = '1' then
			br_en_1 <= '1';
			br_en_0 <= '1';
			currentState <= a18;

		elsif (ir1_15 and ir1_14 and not ir1_11) = '1' then
			br_en_1 <= '1';
			br_en_0 <= '1';
			ctr_mux1_1 <= '1';
			ctr_mux1_0 <= '1';
			ctr_mux2_1 <= '1';
			currentState <= a19;

		elsif (ir1_15 and not ir1_14) = '1' then
			ctr_mux4_0 <= '1';
			currentState <= a20;

		elsif (not ir1_15 and ir1_14) = '1' then
			ctr_mux4_0 <= '1';
			currentState <= a20;

		else
			ctr_mux0 <= '1';
			ir2_en_1 <= '1';
			ir2_en_0 <= '1';
			currentState <= a21;

		end if;

	when a18 =>
		if (ir1_15) = '1' then
			currentState <= a1;
			idle <= '1';

		else
			ralu_en <= '1';
			zf_en <= '1';
			currentState <= a22;

		end if;

	when a19 =>
		
			bor_en <= '1';
			ctr_mux4_2 <= '1';
			currentState <= a1;
			idle <= '1';

	when a20 =>
		
			ir2_en_1 <= '1';
			ctr_mux1_0 <= '1';
			currentState <= a23;

	when a21 =>
		
			br_en_1 <= '1';
			br_en_0 <= '1';
			currentState <= a18;

	when a22 =>
		
			bor_en <= '1';
			ctr_mux4_2 <= '1';
			ctr_mux4_1 <= '1';
			currentState <= a1;
			idle <= '1';

	when a23 =>
		
			pc_count <= '1';
			currentState <= a24;

	when a24 =>
		
			ctr_mux4_0 <= '1';
			currentState <= a25;

	when a25 =>
		
			ir2_en_0 <= '1';
			ctr_mux2_0 <= '1';
			currentState <= a26;

	when a26 =>
		
			pc_count <= '1';
			currentState <= a27;

	when a27 =>
		if (ir1_15 and ir1_8 and ir1_12 and comp4_1_dout) = '1' then
			currentState <= a28;

		elsif (ir1_15 and ir1_8 and ir1_12 and not comp4_1_dout) = '1' then
			ctr_mux0 <= '1';
			tempreg16_1_en <= '1';
			currentState <= a29;

		elsif (ir1_15 and ir1_8 and not ir1_12) = '1' then
			bor_en <= '1';
			ctr_mux4_1 <= '1';
			ctr_mux4_0 <= '1';
			currentState <= a1;
			idle <= '1';

		elsif (ir1_15 and not ir1_8 and comp4_1_dout) = '1' then
			currentState <= a28;

		elsif (ir1_15 and not ir1_8 and not comp4_1_dout) = '1' then
			ctr_mux0 <= '1';
			tempreg16_1_en <= '1';
			currentState <= a29;

		elsif (not ir1_15 and zf and ir1_8) = '1' then
			ctr_mux4_1 <= '1';
			pc_en <= '1';
			ctr_mux4_0 <= '1';
			currentState <= a1;
			idle <= '1';

		elsif (not ir1_15 and zf and not ir1_8 and comp4_1_dout) = '1' then
			currentState <= a28;

		elsif (not ir1_15 and zf and not ir1_8 and not comp4_1_dout) = '1' then
			ctr_mux0 <= '1';
			tempreg16_1_en <= '1';
			currentState <= a29;

		elsif (not ir1_15 and not zf and ir1_11) = '1' then
			currentState <= a1;
			idle <= '1';

		elsif (not ir1_15 and not zf and not ir1_11 and ir1_8) = '1' then
			ctr_mux4_1 <= '1';
			pc_en <= '1';
			ctr_mux4_0 <= '1';
			currentState <= a1;
			idle <= '1';

		elsif (not ir1_15 and not zf and not ir1_11 and not ir1_8 and comp4_1_dout) = '1' then
			currentState <= a28;

		else
			ctr_mux0 <= '1';
			tempreg16_1_en <= '1';
			currentState <= a29;

		end if;

	when a28 =>
		if (ir1_15 and ir1_12) = '1' then
			ctr_mux4_2 <= '1';
			ctr_mux4_0 <= '1';
			m1_wren <= '1';
			currentState <= a1;
			idle <= '1';

		elsif (ir1_15 and not ir1_12) = '1' then
			bor_en <= '1';
			ctr_mux4_1 <= '1';
			currentState <= a1;
			idle <= '1';

		else
			ctr_mux4_1 <= '1';
			pc_en <= '1';
			currentState <= a1;
			idle <= '1';

		end if;

	when a29 =>
		
			ir2_en_1 <= '1';
			ir2_en_0 <= '1';
			ctr_mux1_1 <= '1';
			ctr_mux1_0 <= '1';
			ctr_mux1_2 <= '1';
			ctr_mux2_0 <= '1';
			ctr_mux2_2 <= '1';
			currentState <= a30;

	when a30 =>
		
			currentState <= a28;

	end case;
	end proc_Structm;

	begin
		if (rst = '1') then
			bor_en <= '0';
			br_en_0 <= '0';
			br_en_1 <= '0';
			ctr_mux0 <= '0';
			ctr_mux1_0 <= '0';
			ctr_mux1_1 <= '0';
			ctr_mux1_2 <= '0';
			ctr_mux2_0 <= '0';
			ctr_mux2_1 <= '0';
			ctr_mux2_2 <= '0';
			ctr_mux3 <= '0';
			ctr_mux4_0 <= '0';
			ctr_mux4_1 <= '0';
			ctr_mux4_2 <= '0';
			idle <= '0';
			ir1_en_0 <= '0';
			ir1_en_1 <= '0';
			ir2_en_0 <= '0';
			ir2_en_1 <= '0';
			m0_wren <= '0';
			m1_wren <= '0';
			mac_count <= '0';
			mac_en <= '0';
			pc_count <= '0';
			pc_en <= '0';
			ralu_en <= '0';
			tempreg16_1_en <= '0';
			zf_en <= '0';

			currentState <= a1;
			idle <= '1';

		elsif (clk'event and clk = '0') then
			idle <= '0';
			proc_Structm;
		end if;
	end process;

end ARC_Structm;
