----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.03.2023 17:52:29
-- Design Name: 
-- Module Name: test_digital_side - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.math_real.all;
use ieee.numeric_std.all; 


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_digital_side is
  Port ( 
      sys_clk      :in    STD_LOGIC;
      clk_25_in      :in    STD_LOGIC;
      rst      :in    STD_LOGIC;
      RBG_out       : out STD_LOGIC_VECTOR (23 downto 0);
      
      --temp signals to drive the mux's
    matrix_in_addr: in std_logic_vector(5 downto 0);
    matrix_in_mux   : in STD_LOGIC_VECTOR (5 downto 0);
    matrix_load: in STD_LOGIC;
    matrix_latch: in STD_LOGIC;
    matrix_cs: in std_logic_vector(3 downto 0);
    chrom_swap_i      :in    STD_LOGIC;
         
     clk_x_out  : out STD_LOGIC;
     clk_y_out  : out STD_LOGIC
  );
end test_digital_side;

architecture Behavioral of test_digital_side is
--Global Signals
signal clk_x : STD_LOGIC;
signal clk_y : STD_LOGIC;
signal video_on: std_logic; 
--Matrix Out to module in
--signal ff_d : STD_LOGIC;
--signal ff_clk : STD_LOGIC;
--signal inv_in : std_logic_vector(3 downto 0);
signal xy_inv_in : std_logic_vector(17 downto 0);
--signal delay_in : STD_LOGIC;
--signal edge_detector_in : STD_LOGIC;
signal colour_swap : STD_LOGIC;
signal luma_in1 : std_logic_vector(3 downto 0);
signal luma_in2 : std_logic_vector(3 downto 0);
--signal chroma_in1 : std_logic_vector(5 downto 0);
--signal chroma_in2 : std_logic_vector(5 downto 0);
--signal overlay_gate1 : std_logic_vector(3 downto 0);
--signal overlay_gate2 : std_logic_vector(3 downto 0);


--Matrix Out to global
signal luma_out : std_logic_vector(3 downto 0);
--signal chroma_out1 : std_logic_vector(2 downto 0);
--signal chroma_out2 : std_logic_vector(2 downto 0);

-- Chroma Mux input/output signals
--signal chroma_xor_1   : std_logic_vector(5 downto 0);
signal chroma_mux_in1 : std_logic_vector(5 downto 0);
signal chroma_mux_in2 : std_logic_vector(5 downto 0);
signal chroma_mux_out : std_logic_vector(5 downto 0);

-- Overlay Gates Signals
--signal not_overlay_gate2 : std_logic_vector(3 downto 0);

--Matrix In from module out
--signal ff_q : STD_LOGIC;
--signal ff_nq : STD_LOGIC;
signal inv_out : std_logic_vector(3 downto 0);
signal x_count : std_logic_vector(8 downto 0);
signal y_count : std_logic_vector(8 downto 0);
signal xy_count : std_logic_vector(17 downto 0);
signal xy_inv_out : std_logic_vector(17 downto 0);
--signal delay_out : STD_LOGIC;
--signal slow_cnt_6 : STD_LOGIC;
--signal slow_cnt_3 : STD_LOGIC;
--signal slow_cnt_1_5 : STD_LOGIC;
--signal slow_cnt_0_6 : STD_LOGIC;
--signal slow_cnt_0_4 : STD_LOGIC;
--signal slow_cnt_0_2 : STD_LOGIC;
--signal ext_vid_out : std_logic_vector(6 downto 0);
--signal edge_detector_out : std_logic_vector(3 downto 0);
--signal overlay_gate_out : std_logic_vector(3 downto 0);

--Matrix Module controls
--signal vid_span : std_logic_vector(7 downto 0);


--To analog side
--signal acm_out1 : STD_LOGIC;
--signal acm_out2 : STD_LOGIC;

-- Matrix control signals
-- Matrix full
-- constant x_in : integer := 8;
-- constant y_out : integer := 8;
 signal clk       : STD_LOGIC;
 signal matrix_in : STD_LOGIC_VECTOR (64 downto 0) := (others => '0');
-- signal matrix_in_addr  : STD_LOGIC_VECTOR (5 downto 0);
-- signal matrix_load        : std_logic ;
-- signal matrix_latch        :  std_logic ;
-- signal matrix_cs        :  STD_LOGIC_VECTOR(3 downto 0) ;
 signal matrix_out :  STD_LOGIC_VECTOR (64 downto 0):= (others => '0');
-- signal wr        : STD_LOGIC;
-- signal  Data_In  :    std_logic_vector((x_in * 8) - 1 downto 0);
-- signal  en       :    std_logic_vector(x_in -1 downto 0);
-- signal  mux_sel  :    std_logic_vector((x_in * 3)-1 downto 0);
-- signal  dmux_sel  :    std_logic_vector((y_out * 3)-1 downto 0);
-- signal  en_sel   :    std_logic_vector(positive(ceil(log2(real(x_in)))) downto 0); --this is ugly, i should fix it
-- signal  Data_out :   std_logic_vector((y_out * 8)-1 downto 0);
---- bus overlap and interleaver
--signal  interleaver_in  :    std_logic_vector((x_in * 8) - 1 downto 0);
--signal  interleaver_out  :    std_logic_vector((x_in * 8) - 1 downto 0);
--signal  overlap_in  :    std_logic_vector((x_in * 8) - 1 downto 0);
--signal  overlap_out  :    std_logic_vector((x_in * 8) - 1 downto 0);

-- Colour Output
signal luma_vid_out : std_logic_vector(3 downto 0);
signal chroma_vid_out : std_logic_vector(5 downto 0);

signal Y : std_logic_vector(7 downto 0);
signal U : std_logic_vector(7 downto 0);
signal V : std_logic_vector(7 downto 0);
signal R : std_logic_vector(7 downto 0);
signal G : std_logic_vector(7 downto 0);
signal B : std_logic_vector(7 downto 0);


-- mux test sigs
signal mux_in : std_logic_vector(31 downto 0);
signal mux_selB : std_logic_vector(16 downto 0) := (others => '0');
signal mux_selC : std_logic_vector(16 downto 0) := (others => '0');
signal mux_selD : std_logic_vector(31 downto 0) := (others => '0');
signal mux_selE : std_logic_vector(31 downto 0) := (others => '0');
signal chrom_swap : STD_LOGIC;


--External signals
signal clk_25 : STD_LOGIC;
signal ff_clr : STD_LOGIC;

--mux function
 function multi321 (A,B: in std_logic_vector) return std_logic is

  begin

      return A(to_integer(unsigned(B)));
  end multi321;

begin

    --assignemt from external in
      clk    <= sys_clk;
      clk_25    <= clk_25_in;
      luma_vid_out <= luma_out;
      chroma_vid_out <= chroma_mux_out;
    --temp controlls of muxes
 chrom_swap <= chrom_swap_i;
 clk_x_out <= clk_x;
  clk_y_out <= clk_y;

vga_trimming_signals : entity work.vga_trimming_signals
        port map (
      clk_25mhz   => clk_25, 
        h_sync => clk_x,      
        v_sync  => clk_y,     
        video_on  => video_on
        );

    x_counter : entity work.counter
        port map (
         clk => clk_25_in, -- check what it is actualy driven by, pixel clk right?
        rst => clk_x,--rst, -- x needs to be reset by hs otherwise some bits out run over and get out of sync on the next line
        enable => '1',
        count => x_count
        );
        
    y_counter : entity work.counter
        port map (
         clk => clk_x, -- check what it is actualy driven by, hoz sync right
        rst => clk_y, --vsync reset to stop rolling
        enable => '1',
        count => y_count
        );
       
    xy_count <= (y_count & x_count); -- concat x & y
    xy_invert_logic: entity work.xor18
       port map (
        a => xy_count, 
        b => xy_inv_in,
        y =>  xy_inv_out   
       );
       
      
       matrix_in(0) <= '0';
       matrix_in(18 downto 1) <= xy_inv_out;  -- the 0 at the start is a place holder for no pins
       matrix_in(31 downto 19) <= (others => '0');
    ---------------------------------------------------------------
    -- HUGE MULTIPLEXER 
    pin_matrix : entity work.huge_crospoint_wraper
    Port map ( 
           matrix_in => matrix_in,
           in_addr => matrix_in_addr,
           in_mux => matrix_in_mux,
           clk        => clk,
           rst       => rst,
           load       =>matrix_load,
           latch      =>matrix_latch,
           cs        => matrix_cs,
           matrix_out  => matrix_out
           );

       
       ----------------------------------------asignments
       xy_inv_in(17 downto 0)       <= matrix_out(17 downto 0);
       
       luma_in1(3 downto 0)       <= matrix_out(40 downto 37);
       chroma_mux_in1(2 downto 0) <= matrix_out(43 downto 41);
       chroma_mux_in2(2 downto 0) <= matrix_out(46 downto 44);
       luma_in2(3 downto 0)       <= matrix_out(50 downto 47);
       chroma_mux_in1(5 downto 3) <= matrix_out(53 downto 51); 
       chroma_mux_in2(5 downto 3) <= matrix_out(56 downto 54);

       


--       luma_in1(0) <= multi321(mux_in, mux_selB(3 downto 0));
--       luma_in1(1) <= multi321(mux_in, mux_selB(7 downto 4));
--       luma_in1(2) <= multi321(mux_in, mux_selB(11 downto 8));
--       luma_in1(3) <= multi321(mux_in, mux_selB(15 downto 12));
       
--       luma_in2(0) <= multi321(mux_in, mux_selC(3 downto 0));
--       luma_in2(1) <= multi321(mux_in, mux_selC(7 downto 4));
--       luma_in2(2) <= multi321(mux_in, mux_selC(11 downto 8));
--       luma_in2(3) <= multi321(mux_in, mux_selC(15 downto 12));
       
--       chroma_mux_in1(0) <= multi321(mux_in, mux_selD(3 downto 0));
--       chroma_mux_in1(1) <= multi321(mux_in, mux_selD(7 downto 4));
--       chroma_mux_in1(2) <= multi321(mux_in, mux_selD(11 downto 8));
--       chroma_mux_in1(3) <= multi321(mux_in, mux_selD(15 downto 12));
--       chroma_mux_in1(4) <= multi321(mux_in, mux_selD(19 downto 16));
--       chroma_mux_in1(5) <= multi321(mux_in, mux_selD(23 downto 20));
       
--       chroma_mux_in2(0) <= multi321(mux_in, mux_selE(3 downto 0));
--       chroma_mux_in2(1) <= multi321(mux_in, mux_selE(7 downto 4));
--       chroma_mux_in2(2) <= multi321(mux_in, mux_selE(11 downto 8));
--       chroma_mux_in2(3) <= multi321(mux_in, mux_selE(15 downto 12));
--       chroma_mux_in2(4) <= multi321(mux_in, mux_selE(19 downto 16));
--       chroma_mux_in2(5) <= multi321(mux_in, mux_selE(23 downto 20));
       
       -------------------------------------- output
       
       
       luma_output: entity work.xor_n
       generic map (
        n => 4
       )
       port map (
        a => luma_in1,
        b => luma_in2,
        y => luma_out  
       );
       
           chroma_output : entity work.mux_5 
        Port map ( 
            sel => chrom_swap, -- temp val was colour swap
            a => chroma_mux_in1,
            b => chroma_mux_in2,
            c => chroma_mux_out
         );
       
       -----------------------------------------

   -- -- Pack chroma and luma into YUV converter
    Y <= (luma_vid_out) & "0000";  
    U <= chroma_vid_out(5 downto 3) & "00000";  
    V <= chroma_vid_out(2 downto 0) & "00000";  
    -- YUV to RGB converter

     -- Pack rgb output into output bus
     RBG_out <= Y & U & V;

end Behavioral;
