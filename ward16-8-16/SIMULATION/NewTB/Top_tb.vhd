library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.components.all;

entity Top_tb is
end Top_tb;

architecture ARC_Top_tb of Top_tb is
	
	type test_array is array (natural range <>) of
		std_logic_vector (0 to 15);
	constant test_data: test_array := (

-- Load Address = x"0000"
-- Program Memory (M0) Word = 8

-- The Following Labels were defined:
-- AdrA = 0000
-- Bun_imd = 0034
-- Bun_long_direct_indexed = 004a
-- Bun_long_direct = 0060
-- Bcz_LD_Z0 = 0084
-- Bcz_LD_Z1 = 009c
-- Bcz_LD_Idx_Z0 = 00b8
-- Bcz_LD_Idx_Z1 = 00d4


-- (1) AdrA: x"0000"
-- 1 (4) lod r0, #x"0008" ; r0 := x"0008"
-- Program Counter = x"0000" (10001 101 0000 0000)
-- Addressing Mode is: Long Immediate
x"8d00",
x"0008",

-- 2 (5) out r0 ; r0 == x"0008";
-- Program Counter = x"0004" (11001 000 0000 0000)
-- Addressing Mode is: Short Direct
x"c800",

-- 3 (8) lod r4, #x"0008" ; r4 := x"0008"
-- Program Counter = x"0006" (10001 101 0100 0000)
-- Addressing Mode is: Long Immediate
x"8d40",
x"0008",

-- 4 (9) str r4, AdrA ; M1[x"0000"] := r4 = x"0008"
-- Program Counter = x"000a" (10011 100 0100 0000)
-- Addressing Mode is: Long Direct
x"9c40",
x"0000",

-- 5 (10) lod r8, AdrA ; r8 :=M1[x"0000"] = x"0008"
-- Program Counter = x"000e" (10001 100 1000 0000)
-- Addressing Mode is: Long Direct
x"8c80",
x"0000",

-- 6 (11) out r8 ; r8 == x"0008";
-- Program Counter = x"0012" (11001 000 1000 0000)
-- Addressing Mode is: Short Direct
x"c880",

-- 7 (14) lod r0, #x"EEEE" ;
-- Program Counter = x"0014" (10001 101 0000 0000)
-- Addressing Mode is: Long Immediate
x"8d00",
x"eeee",

-- 8 (15) lod r8, #x"1234" ;
-- Program Counter = x"0018" (10001 101 1000 0000)
-- Addressing Mode is: Long Immediate
x"8d80",
x"1234",

-- 9 (16) lod rC, #x"0004" ;
-- Program Counter = x"001c" (10001 101 1100 0000)
-- Addressing Mode is: Long Immediate
x"8dc0",
x"0004",

-- 10 (17) str r8, AdrA, rC ; M1[ AdrA + rC =x"0004" ]:= r8 , r8= x"1234" ,M1[x"0004"]=x"1234", AdrA=x"0000"
-- Program Counter = x"0020" (10011 100 1000 1100)
-- Addressing Mode is: Long Direct Index
x"9c8c",
x"0000",

-- 11 (18) lod r0, AdrA, rC ; r0 := M1[x"0004"] = x"1234"
-- Program Counter = x"0024" (10001 100 0000 1100)
-- Addressing Mode is: Long Direct Index
x"8c0c",
x"0000",

-- 12 (19) out r0 ; r0 == x"1234";
-- Program Counter = x"0028" (11001 000 0000 0000)
-- Addressing Mode is: Short Direct
x"c800",

-- 13 (22) lod rC, #x"0001" ;
-- Program Counter = x"002a" (10001 101 1100 0000)
-- Addressing Mode is: Long Immediate
x"8dc0",
x"0001",

-- 14 (23) bun #Bun_imd ;
-- Program Counter = x"002e" (01000 101 0000 0000)
-- Addressing Mode is: Long Immediate
x"4500",
x"0034",

-- 15 (24) sub rC,rC ; rC:= rC -rC =0, shouldn't be performed @test_skip@
-- Program Counter = x"0032" (00011 000 1100 1100)
-- Addressing Mode is: Short Direct
x"18cc",

-- (25) Bun_imd: 
-- 16 (26) inc rC ; rC:= rC + 1; rC should be x"0002" after execution of command
-- Program Counter = x"0034" (00101 000 1100 0000)
-- Addressing Mode is: Short Direct
x"28c0",

-- 17 (27) out rC ; rC==x"0002"
-- Program Counter = x"0036" (11001 000 1100 0000)
-- Addressing Mode is: Short Direct
x"c8c0",

-- 18 (30) lod r4, #x"0004" ;
-- Program Counter = x"0038" (10001 101 0100 0000)
-- Addressing Mode is: Long Immediate
x"8d40",
x"0004",

-- 19 (31) lod r8, #Bun_long_direct_indexed 
-- Program Counter = x"003c" (10001 101 1000 0000)
-- Addressing Mode is: Long Immediate
x"8d80",
x"004a",

-- 20 (32) str r8, AdrA, r4 ; M1[x"0004"] = M1[ AdrA + x"0004"]:= r8 , r8= #Bun_long_direct_indexed ,AdrA=x"0000" => M1[4]=#Bun_long_direct_indexed
-- Program Counter = x"0040" (10011 100 1000 0100)
-- Addressing Mode is: Long Direct Index
x"9c84",
x"0000",

-- 21 (33) bun AdrA, r4 
-- Program Counter = x"0044" (01000 100 0000 0100)
-- Addressing Mode is: Long Direct Index
x"4404",
x"0000",

-- 22 (34) sub rC,rC ; rC:= rC -rC =0, shouldn't be performed @test_skip@
-- Program Counter = x"0048" (00011 000 1100 1100)
-- Addressing Mode is: Short Direct
x"18cc",

-- (35) Bun_long_direct_indexed: 
-- 23 (36) inc rC ; rC:= rC + 1; rC should be x"0003" after execution of command
-- Program Counter = x"004a" (00101 000 1100 0000)
-- Addressing Mode is: Short Direct
x"28c0",

-- 24 (37) out rC ; rC==x"0003"
-- Program Counter = x"004c" (11001 000 1100 0000)
-- Addressing Mode is: Short Direct
x"c8c0",

-- 25 (40) lod rC, #x"0001" ;
-- Program Counter = x"004e" (10001 101 1100 0000)
-- Addressing Mode is: Long Immediate
x"8dc0",
x"0001",

-- 26 (41) lod r8, #Bun_long_direct 
-- Program Counter = x"0052" (10001 101 1000 0000)
-- Addressing Mode is: Long Immediate
x"8d80",
x"0060",

-- 27 (42) str r8, AdrA 
-- Program Counter = x"0056" (10011 100 1000 0000)
-- Addressing Mode is: Long Direct
x"9c80",
x"0000",

-- 28 (43) bun AdrA 
-- Program Counter = x"005a" (01000 100 0000 0000)
-- Addressing Mode is: Long Direct
x"4400",
x"0000",

-- 29 (44) sub rC, rC ; shouldn't be performed @test_skip@
-- Program Counter = x"005e" (00011 000 1100 1100)
-- Addressing Mode is: Short Direct
x"18cc",

-- (45) Bun_long_direct: 
-- 30 (46) inc rC 
-- Program Counter = x"0060" (00101 000 1100 0000)
-- Addressing Mode is: Short Direct
x"28c0",

-- 31 (47) out rC ; rC == x"0002";
-- Program Counter = x"0062" (11001 000 1100 0000)
-- Addressing Mode is: Short Direct
x"c8c0",

-- 32 (50) lod r0, #x"0005" 
-- Program Counter = x"0064" (10001 101 0000 0000)
-- Addressing Mode is: Long Immediate
x"8d00",
x"0005",

-- 33 (51) lod r1, #x"0003" 
-- Program Counter = x"0068" (10001 101 0001 0000)
-- Addressing Mode is: Long Immediate
x"8d10",
x"0003",

-- 34 (52) add r0, r1 
-- Program Counter = x"006c" (00001 000 0000 0001)
-- Addressing Mode is: Short Direct
x"0801",

-- 35 (53) out r0 ; r0 == x"0008";
-- Program Counter = x"006e" (11001 000 0000 0000)
-- Addressing Mode is: Short Direct
x"c800",

-- 36 (56) lod r1, #x"0000" 
-- Program Counter = x"0070" (10001 101 0001 0000)
-- Addressing Mode is: Long Immediate
x"8d10",
x"0000",

-- 37 (57) sub r1, r1 ; ZF=1
-- Program Counter = x"0074" (00011 000 0001 0001)
-- Addressing Mode is: Short Direct
x"1811",

-- 38 (58) lod r8, #Bcz_LD_Z0 
-- Program Counter = x"0076" (10001 101 1000 0000)
-- Addressing Mode is: Long Immediate
x"8d80",
x"0084",

-- 39 (59) str r8, AdrA 
-- Program Counter = x"007a" (10011 100 1000 0000)
-- Addressing Mode is: Long Direct
x"9c80",
x"0000",

-- 40 (60) bcz AdrA 
-- Program Counter = x"007e" (01001 100 0000 0000)
-- Addressing Mode is: Long Direct
x"4c00",
x"0000",

-- 41 (61) add r1, r1 ; shouldn't be performed @test_skip@
-- Program Counter = x"0082" (00001 000 0001 0001)
-- Addressing Mode is: Short Direct
x"0811",

-- (62) Bcz_LD_Z0: 
-- 42 (63) inc r1 
-- Program Counter = x"0084" (00101 000 0001 0000)
-- Addressing Mode is: Short Direct
x"2810",

-- 43 (64) out r1 ; r1 == x"0001";
-- Program Counter = x"0086" (11001 000 0001 0000)
-- Addressing Mode is: Short Direct
x"c810",

-- 44 (67) lod r1, #x"0001" 
-- Program Counter = x"0088" (10001 101 0001 0000)
-- Addressing Mode is: Long Immediate
x"8d10",
x"0001",

-- 45 (68) sub r1, r1 ; ZF=1
-- Program Counter = x"008c" (00011 000 0001 0001)
-- Addressing Mode is: Short Direct
x"1811",

-- 46 (69) lod r8, #Bcz_LD_Z1 
-- Program Counter = x"008e" (10001 101 1000 0000)
-- Addressing Mode is: Long Immediate
x"8d80",
x"009c",

-- 47 (70) str r8, AdrA 
-- Program Counter = x"0092" (10011 100 1000 0000)
-- Addressing Mode is: Long Direct
x"9c80",
x"0000",

-- 48 (71) bcz AdrA 
-- Program Counter = x"0096" (01001 100 0000 0000)
-- Addressing Mode is: Long Direct
x"4c00",
x"0000",

-- 49 (72) add r1, r1 ; shouldn't be performed @test_skip@
-- Program Counter = x"009a" (00001 000 0001 0001)
-- Addressing Mode is: Short Direct
x"0811",

-- (73) Bcz_LD_Z1: 
-- 50 (74) inc r1 
-- Program Counter = x"009c" (00101 000 0001 0000)
-- Addressing Mode is: Short Direct
x"2810",

-- 51 (75) out r1 ; r1 == x"0001";
-- Program Counter = x"009e" (11001 000 0001 0000)
-- Addressing Mode is: Short Direct
x"c810",

-- 52 (78) lod r1, #x"0000" 
-- Program Counter = x"00a0" (10001 101 0001 0000)
-- Addressing Mode is: Long Immediate
x"8d10",
x"0000",

-- 53 (79) sub r1, r1 ; ZF=1
-- Program Counter = x"00a4" (00011 000 0001 0001)
-- Addressing Mode is: Short Direct
x"1811",

-- 54 (80) lod r4, #x"0004" 
-- Program Counter = x"00a6" (10001 101 0100 0000)
-- Addressing Mode is: Long Immediate
x"8d40",
x"0004",

-- 55 (81) lod r8, #Bcz_LD_Idx_Z0 
-- Program Counter = x"00aa" (10001 101 1000 0000)
-- Addressing Mode is: Long Immediate
x"8d80",
x"00b8",

-- 56 (82) str r8, AdrA, r4 
-- Program Counter = x"00ae" (10011 100 1000 0100)
-- Addressing Mode is: Long Direct Index
x"9c84",
x"0000",

-- 57 (83) bcz AdrA, r4 
-- Program Counter = x"00b2" (01001 100 0000 0100)
-- Addressing Mode is: Long Direct Index
x"4c04",
x"0000",

-- 58 (84) add r1, r1 ; shouldn't be performed @test_skip@
-- Program Counter = x"00b6" (00001 000 0001 0001)
-- Addressing Mode is: Short Direct
x"0811",

-- (85) Bcz_LD_Idx_Z0: 
-- 59 (86) inc r1 
-- Program Counter = x"00b8" (00101 000 0001 0000)
-- Addressing Mode is: Short Direct
x"2810",

-- 60 (87) out r1 ; r1 == x"0001";
-- Program Counter = x"00ba" (11001 000 0001 0000)
-- Addressing Mode is: Short Direct
x"c810",

-- 61 (90) lod r1, #x"0001" 
-- Program Counter = x"00bc" (10001 101 0001 0000)
-- Addressing Mode is: Long Immediate
x"8d10",
x"0001",

-- 62 (91) sub r1, r1 ; ZF=1
-- Program Counter = x"00c0" (00011 000 0001 0001)
-- Addressing Mode is: Short Direct
x"1811",

-- 63 (92) lod r4, #x"0004" 
-- Program Counter = x"00c2" (10001 101 0100 0000)
-- Addressing Mode is: Long Immediate
x"8d40",
x"0004",

-- 64 (93) lod r8, #Bcz_LD_Idx_Z1 
-- Program Counter = x"00c6" (10001 101 1000 0000)
-- Addressing Mode is: Long Immediate
x"8d80",
x"00d4",

-- 65 (94) str r8, AdrA, r4 
-- Program Counter = x"00ca" (10011 100 1000 0100)
-- Addressing Mode is: Long Direct Index
x"9c84",
x"0000",

-- 66 (95) bcz AdrA, r4 
-- Program Counter = x"00ce" (01001 100 0000 0100)
-- Addressing Mode is: Long Direct Index
x"4c04",
x"0000",

-- 67 (96) add r1, r1 ; shouldn't be performed @test_skip@
-- Program Counter = x"00d2" (00001 000 0001 0001)
-- Addressing Mode is: Short Direct
x"0811",

-- (97) Bcz_LD_Idx_Z1: 
-- 68 (98) inc r1 
-- Program Counter = x"00d4" (00101 000 0001 0000)
-- Addressing Mode is: Short Direct
x"2810",

-- 69 (99) out r1 ; r1 == x"0001";
-- Program Counter = x"00d6" (11001 000 0001 0000)
-- Addressing Mode is: Short Direct
x"c810",

-- TestBench instruction table closing
x"0000" -- this is NOT a valid instruction

	
	);
	
	component Top is
    port 
    	(
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
end component; 
	
	signal clk          : std_logic;
	signal dma          : std_logic;
	signal ext_adr      : std_logic_vector(15 downto 0);
	signal ext_in       : std_logic_vector(15 downto 0);
	signal ext_out      : std_logic_vector(15 downto 0);
	signal ext_rdwr     : std_logic;
	signal idle         : std_logic;
	signal inpr         : std_logic_vector(15 downto 0);
	signal m            : std_logic;
	signal outr         : std_logic_vector(15 downto 0);
	signal rst          : std_logic;
	signal s            : std_logic;
	
    	
begin
	UUT : Top port map
		(
			clk       , 	 
			dma       ,  
			ext_adr   , 
			ext_in    , 	 
			ext_out   ,  
			ext_rdwr  , 	 
			idle      , 	 
			inpr      , 		 
			m         , 	 
			outr      ,
            rst       ,
			s        
        );
	
	test : process
	begin
		-- Reset the system
		rst       <= '1';
		S         <= '0';
		
--		data_in   <= x"0000";
		DMA       <= '0';
		
		wave_gen(clk);
		
		-- Load test program to M0 using DMA
		rst       <= '0';
		S         <= '1';
		
		DMA       <= '1';
		Ext_RdWr  <= '1';
		M         <= '0';
		
		for i in test_data'range loop
			Ext_Adr <= std_logic_vector(to_unsigned(i * 2, 16));
			Ext_out <= test_data(i);
			exec_inst(Idle, clk);
		end loop;
		
		DMA       <= '0';
        
		-- =====================
		-- Test lod immediate (line 3)
		-- =====================
		-- Execute test program
		for j in 1 to 2 loop
			exec_inst(Idle, clk);
		end loop;

		-- Output BoR into outr (execute out instructions)
		assert outr = x"0008"
			report "output outr is wrong! (Test lod immediate)"
			severity error;


		-- =====================
		-- Test lod /str long direct (line 7)
		-- =====================
		-- Execute test program
		for j in 1 to 4 loop
			exec_inst(Idle, clk);
		end loop;

		-- Output BoR into outr (execute out instructions)
		assert outr = x"0008"
			report "output outr is wrong! (Test lod /str long direct)"
			severity error;


		-- =====================
		-- Test lod/str long direct indexed (line 13)
		-- =====================
		-- Execute test program
		for j in 1 to 6 loop
			exec_inst(Idle, clk);
		end loop;

		-- Output BoR into outr (execute out instructions)
		assert outr = x"1234"
			report "output outr is wrong! (Test lod/str long direct indexed)"
			severity error;


		-- =====================
		-- Test bun immediate (line 21)
		-- =====================
		-- Execute test program
		for j in 1 to 4 loop
			exec_inst(Idle, clk);
		end loop;

		-- Output BoR into outr (execute out instructions)
		assert outr = x"0002"
			report "output outr is wrong! (Test bun immediate)"
			severity error;


		-- =====================
		-- Test bun long direct indexed (line 29)
		-- =====================
		-- Execute test program
		for j in 1 to 6 loop
			exec_inst(Idle, clk);
		end loop;

		-- Output BoR into outr (execute out instructions)
		assert outr = x"0003"
			report "output outr is wrong! (Test bun long direct indexed)"
			severity error;


		-- =====================
		-- Test bun long direct (line 39)
		-- =====================
		-- Execute test program
		for j in 1 to 6 loop
			exec_inst(Idle, clk);
		end loop;

		-- Output BoR into outr (execute out instructions)
		assert outr = x"0002"
			report "output outr is wrong! (Test bun long direct)"
			severity error;


		-- =====================
		-- Test add short direct (line 49)
		-- =====================
		-- Execute test program
		for j in 1 to 4 loop
			exec_inst(Idle, clk);
		end loop;

		-- Output BoR into outr (execute out instructions)
		assert outr = x"0008"
			report "output outr is wrong! (Test add short direct)"
			severity error;


		-- =====================
		-- Test bcz long direct - with zero 0 (line 55)
		-- =====================
		-- Execute test program
		for j in 1 to 7 loop
			exec_inst(Idle, clk);
		end loop;

		-- Output BoR into outr (execute out instructions)
		assert outr = x"0001"
			report "output outr is wrong! (Test bcz long direct - with zero 0)"
			severity error;


		-- =====================
		-- Test bcz long direct - with zero 1 (line 66)
		-- =====================
		-- Execute test program
		for j in 1 to 7 loop
			exec_inst(Idle, clk);
		end loop;

		-- Output BoR into outr (execute out instructions)
		assert outr = x"0001"
			report "output outr is wrong! (Test bcz long direct - with zero 1)"
			severity error;


		-- =====================
		-- Test bcz long direct indexed - with zero 0 (line 77)
		-- =====================
		-- Execute test program
		for j in 1 to 8 loop
			exec_inst(Idle, clk);
		end loop;

		-- Output BoR into outr (execute out instructions)
		assert outr = x"0001"
			report "output outr is wrong! (Test bcz long direct indexed - with zero 0)"
			severity error;


		-- =====================
		-- Test bcz long direct indexed - with zero 1 (line 89)
		-- =====================
		-- Execute test program
		for j in 1 to 8 loop
			exec_inst(Idle, clk);
		end loop;

		-- Output BoR into outr (execute out instructions)
		assert outr = x"0001"
			report "output outr is wrong! (Test bcz long direct indexed - with zero 1)"
			severity error;



		
		wait;
	end process test;
end ARC_Top_tb;

configuration CFG_Top_tb of Top_tb is
	for ARC_Top_tb
	end for;
end CFG_Top_tb;