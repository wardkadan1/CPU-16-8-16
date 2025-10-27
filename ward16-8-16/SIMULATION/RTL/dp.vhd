-- Automatically generated using Goals v1.0.1.170
-----------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.components.all;
-----------------------------
entity dp is
	port
		(
		
		-- Inputs from control unit
		ralu_en          :  in    std_logic;	--(y1)
		zf_en            :  in    std_logic;	--(y2)
		ctr_mux0         :  in    std_logic;	--(y3)
		ir2_en_1         :  in    std_logic;	--(y4)
		ir2_en_0         :  in    std_logic;	--(y5)
		bor_en           :  in    std_logic;	--(y6)
		ctr_mux4_2       :  in    std_logic;	--(y7)
		ctr_mux4_1       :  in    std_logic;	--(y8)
		br_en_1          :  in    std_logic;	--(y9)
		br_en_0          :  in    std_logic;	--(y10)
		pc_en            :  in    std_logic;	--(y11)
		ctr_mux4_0       :  in    std_logic;	--(y12)
		ctr_mux1_1       :  in    std_logic;	--(y13)
		ctr_mux1_0       :  in    std_logic;	--(y14)
		ctr_mux2_1       :  in    std_logic;	--(y15)
		m1_wren          :  in    std_logic;	--(y16)
		ctr_mux1_2       :  in    std_logic;	--(y17)
		ctr_mux2_0       :  in    std_logic;	--(y18)
		ctr_mux3         :  in    std_logic;	--(y19)
		ctr_mux2_2       :  in    std_logic;	--(y20)
		mac_en           :  in    std_logic;	--(y21)
		ir1_en_0         :  in    std_logic;	--(y22)
		pc_count         :  in    std_logic;	--(y23)
		ir1_en_1         :  in    std_logic;	--(y24)
		mac_count        :  in    std_logic;	--(y25)
		m0_wren          :  in    std_logic;	--(y26)
		tempreg16_1_en   :  in    std_logic;	--(y27)
		
		-- Inputs from outside
		clk              :  in    std_logic;
		rst              :  in    std_logic;
		ext_adr          :  in    std_logic_vector(15 downto 0);
		ext_out          :  in    std_logic_vector(15 downto 0);
		inpr             :  in    std_logic_vector(15 downto 0);
		
		-- Outputs to control unit
		ir1_8            :  out   std_logic;  --(x3)
		zf               :  out   std_logic;  --(x4)
		ir1_15           :  out   std_logic;  --(x5)
		ir1_14           :  out   std_logic;  --(x6)
		ir1_12           :  out   std_logic;  --(x7)
		ir1_11           :  out   std_logic;  --(x8)
		comp4_1_dout     :  out   std_logic;  --(x11)
		
		-- Outputs to outside
		ext_in           :  out   std_logic_vector(15 downto 0);
		outr             :  out   std_logic_vector(15 downto 0)
		);

end dp;
-----------------------------------------------
architecture arc_dp of dp is
	signal mux3_dout          :  std_logic_vector (15 downto 0);
	signal mux4_dout          :  std_logic_vector (15 downto 0);
	signal mux0_dout          :  std_logic_vector (3 downto 0);
	signal mux1_dout          :  std_logic_vector (7 downto 0);
	signal mux2_dout          :  std_logic_vector (7 downto 0);
	signal alu_outp           :  std_logic_vector (15 downto 0);
	signal alu_z              :  std_logic;
	signal alu16_1_dout       :  std_logic_vector (15 downto 0);
	signal bor_dout           :  std_logic_vector (15 downto 0);
	signal br_dout            :  std_logic_vector (15 downto 0);
	signal clock              :  std_logic;
	signal ir1_dout           :  std_logic_vector (15 downto 0);
	signal ir2_dout           :  std_logic_vector (15 downto 0);
	signal m0_q               :  std_logic_vector (7 downto 0);
	signal m1_q               :  std_logic_vector (15 downto 0);
	signal mac_dout           :  std_logic_vector (15 downto 0);
	signal pc_dout            :  std_logic_vector (15 downto 0);
	signal ralu_dout          :  std_logic_vector (15 downto 0);
	signal tempreg16_1_dout   :  std_logic_vector (15 downto 0);
	signal br_en              :  std_logic_vector (1 downto 0);
	signal ctr_mux1           :  std_logic_vector (2 downto 0);
	signal ctr_mux2           :  std_logic_vector (2 downto 0);
	signal ctr_mux4           :  std_logic_vector (2 downto 0);
	signal ir1_en             :  std_logic_vector (1 downto 0);
	signal ir2_en             :  std_logic_vector (1 downto 0);
	signal br_din             :  std_logic_vector (15 downto 0);
	signal ir1_din            :  std_logic_vector (15 downto 0);
	signal ir2_din            :  std_logic_vector (15 downto 0);
begin
	
	---------
	-- Mux 3
	---------
	u1_mux3     :  mux_2x16   port map (ir2_dout, ext_adr, ctr_mux3, mux3_dout);
	
	---------
	-- Mux 4
	---------
	u2_mux4     :  mux_7x16   port map (mac_dout, pc_dout, m1_q, ir2_dout, br_dout, bor_dout, ralu_dout, ctr_mux4, mux4_dout);
	
	---------
	-- Mux 0
	---------
	u3_mux0     :  mux_2x4    port map (ir1_dout(7 downto 4), ir1_dout(3 downto 0), ctr_mux0, mux0_dout);
	
	---------
	-- Mux 1
	---------
	u4_mux1     :  mux_8x8    port map (bor_dout(15 downto 8), m0_q, br_dout(7 downto 0), inpr(15 downto 8), ext_out(15 downto 8), br_dout(15 downto 8), m1_q(15 downto 8), tempreg16_1_dout(15 downto 8), ctr_mux1, mux1_dout);
	
	---------
	-- Mux 2
	---------
	u5_mux2     :  mux_6x8    port map (bor_dout(7 downto 0), m0_q, inpr(7 downto 0), m1_q(7 downto 0), ext_out(7 downto 0), tempreg16_1_dout(7 downto 0), ctr_mux2, mux2_dout);
	
	---------
	-- alu
	---------
	u6_alu      :  alu        port map (br_dout, ir2_dout, ir1_dout(15 downto 11), alu_outp, alu_z);
	
	---------
	-- m1
	---------
	u7_m1       :  memAlt65536x16 port map (clock, mux3_dout, mux4_dout, m1_wren, m1_q);
	
	---------
	-- m0
	---------
	u8_m0       :  memAlt65536x8 port map (clock, mux4_dout, mux1_dout, m0_wren, m0_q);
	
	---------
	-- zf
	---------
	u9_zf       :  d_ff       port map (clk, alu_z, rst, zf_en, zf);
	
	---------
	-- br
	---------
	u10_br      :  reg_16bit_2en port map (clk, rst, br_din, br_en, br_dout);
	
	---------
	-- ir1
	---------
	u11_ir1     :  reg_16bit_2en port map (clk, rst, ir1_din, ir1_en, ir1_dout);
	
	---------
	-- ir2
	---------
	u12_ir2     :  reg_16bit_2en port map (clk, rst, ir2_din, ir2_en, ir2_dout);
	
	---------
	-- ralu
	---------
	u13_ralu    :  reg_16bit  port map (clk, rst, alu_outp, ralu_en, ralu_dout);
	
	---------
	-- tempreg16_1
	---------
	u14_tempreg16_1  :  reg_16bit  port map (clk, rst, alu16_1_dout, tempreg16_1_en, tempreg16_1_dout);
	
	---------
	-- bor
	---------
	u15_bor     :  bor_4adr_16bit port map (clk, rst, mux0_dout, mux4_dout, bor_en, bor_dout);
	
	---------
	-- mac
	---------
	u16_mac     :  counter_p_16bit port map (clk, rst, mac_en, mac_count, ext_adr, mac_dout);
	
	---------
	-- pc
	---------
	u17_pc      :  counter_p_16bit port map (clk, rst, pc_en, pc_count, mux4_dout, pc_dout);
	
	---------
	-- comp4_1
	---------
	u18_comp4_1  :  g_comp     generic map (comp_kind => "eq", size => 4) port map (ir1_dout(3 downto 0), x"0", comp4_1_dout);
	
	---------
	-- alu16_1
	---------
	u19_alu16_1  :  alu_16bit  port map (ir2_dout, bor_dout, "0001", alu16_1_dout);
	
	
	
	-----------------------
	-- Additional Signals
	-----------------------
	
	ctr_mux4       	<=	ctr_mux4_2 & ctr_mux4_1 & ctr_mux4_0;
	ctr_mux1       	<=	ctr_mux1_2 & ctr_mux1_1 & ctr_mux1_0;
	ctr_mux2       	<=	ctr_mux2_2 & ctr_mux2_1 & ctr_mux2_0;
	br_din         	<=	mux1_dout & mux2_dout;
	br_en          	<=	br_en_1 & br_en_0;
	ir1_din        	<=	m0_q & m0_q;
	ir1_en         	<=	ir1_en_1 & ir1_en_0;
	ir2_din        	<=	mux1_dout & mux2_dout;
	ir2_en         	<=	ir2_en_1 & ir2_en_0;
	clock          	<=	clk;
	ext_in         	<=	br_dout;
	outr           	<=	br_dout;
	ir1_8          	<=	ir1_dout(8);
	ir1_15         	<=	ir1_dout(15);
	ir1_14         	<=	ir1_dout(14);
	ir1_12         	<=	ir1_dout(12);
	ir1_11         	<=	ir1_dout(11);
	
	
end  arc_dp;
-----------------------------------------------
configuration cfg_dp of dp is
	for arc_dp
	end for;
end cfg_dp;
-----------------------------
