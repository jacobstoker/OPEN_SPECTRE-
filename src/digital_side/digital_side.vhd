----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.01.2023 16:26:53
-- Design Name: 
-- Module Name: digital_side - Behavioral
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

entity digital_side is
--  Port ( );
end digital_side;

architecture Behavioral of digital_side is

--Matrix Out to module in
signal ff_d : STD_LOGIC;
signal ff_clk : STD_LOGIC;
signal inv_in : std_logic_vector(3 downto 0);
signal xy_inv_in : std_logic_vector(17 downto 0);
signal delay_in : STD_LOGIC;

--Matrix In from module out
signal ff_q : STD_LOGIC;
signal ff_nq : STD_LOGIC;
signal inv_out : std_logic_vector(3 downto 0);
signal xy_inv_out : std_logic_vector(17 downto 0);
signal delay_out : STD_LOGIC;
signal slow_cnt_6 : STD_LOGIC;
signal slow_cnt_3 : STD_LOGIC;
signal slow_cnt_1_5 : STD_LOGIC;
signal slow_cnt_0_6 : STD_LOGIC;
signal slow_cnt_0_4 : STD_LOGIC;
signal slow_cnt_0_2 : STD_LOGIC;
signal ext_vid_in : std_logic_vector(5 downto 0);

--External signals
signal clk_25 : STD_LOGIC;
signal ff_clr : STD_LOGIC;


begin

    flip_flops: entity work.D_flipflop_ext
      port map (
           D => ff_d,
           clk => ff_clk,
           clear => ff_clr,
           preset => '1',
           Q => ff_q,
           Q_not => ff_nq
        );
    inverters: entity work.invert_4
       port map (
        input => inv_in,
        output =>  inv_out   
       );
       
    xy_invert_logic: entity work.xor18
       port map (
        a => xy_inv_in, -- comes from the x/y counters !! change it!!
        b => xy_inv_in,
        y =>  xy_inv_out   
       );
       
    delay_dig : entity work.delay_800us
        port map (
            clk => clk_25,
            input => delay_in,
            output => delay_out
        );
        
    slow_counter : entity work.pulse_generator
        port map (
            clk => clk_25,
            pulse_6hz => slow_cnt_6,
            pulse_3hz => slow_cnt_3,
            pulse_1_5hz => slow_cnt_1_5,
            pulse_0_6hz => slow_cnt_0_6,
            pulse_0_4hz => slow_cnt_0_4,
            pulse_0_2hz => slow_cnt_0_2
        
        );
        
    video_in : entity work.compare_7
        Port map ( 
           clk => clk_25,
           luma_i => "00000000",
           output => ext_vid_in,
           span => "11111111"
         );



end Behavioral;
