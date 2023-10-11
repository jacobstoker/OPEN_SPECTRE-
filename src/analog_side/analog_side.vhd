----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.09.2023 16:43:19
-- Design Name: 
-- Module Name: analog_side - Behavioral
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
use IEEE.numeric_std.ALL;
library work;
use work.array_pck.all;

entity analog_side is
 Port ( 
 
    clk      :in    STD_LOGIC;
    rst      :in    STD_LOGIC;
    wr       :in    STD_LOGIC;
    out_addr     :in     std_logic_vector(3 downto 0) ;
    ch_addr      :in     std_logic_vector(3 downto 0);
    gain_in  :in    std_logic_vector(4 downto 0);
    mixer_inputs : in array_12(9 downto 0);
    outputs : out array_12(9 downto 0)  -- 12-bit wide outputs

    --analoge controls from reg file
    pos_h_1   : in std_logic_vector(8 downto 0);
    pos_v_1   : in std_logic_vector(8 downto 0);
    zoom_h_1  : in std_logic_vector(8 downto 0);
    zoom_v_1  : in std_logic_vector(8 downto 0);
    circle_1  : in std_logic_vector(8 downto 0);
    gear_1    : in std_logic_vector(8 downto 0);
    lantern_1 : in std_logic_vector(8 downto 0);
    fizz_1    : in std_logic_vector(8 downto 0);

    pos_h_2   : in std_logic_vector(8 downto 0);
    pos_v_2   : in std_logic_vector(8 downto 0);
    zoom_h_2  : in std_logic_vector(8 downto 0);
    zoom_v_2  : in std_logic_vector(8 downto 0);
    circle_2  : in std_logic_vector(8 downto 0);
    gear_2    : in std_logic_vector(8 downto 0);
    lantern_2 : in std_logic_vector(8 downto 0);
    fizz_2    : in std_logic_vector(8 downto 0);
  
    noise_freq    : in std_logic_vector(9 downto 0);
    slew_in       : in std_logic_vector(2 downto 0);
    cycle_recycle : in std_logic;

    y_level  : in std_logic_vector(11 downto 0);
    cr_level : in std_logic_vector(11 downto 0);
    cb_level : in std_logic_vector(11 downto 0);
    
 );
end analog_side;

architecture Behavioral of analog_side is
   signal out_addr_int     :   integer;
   signal ch_addr_int      :   integer;

   signal noise_1 : std_logic_vector(9 downto 0);
   signal noise_2 : std_logic_vector(9 downto 0);
   
begin

    out_addr_int <= to_integer(unsigned(out_addr));
    ch_addr_int <= to_integer(unsigned(ch_addr));
    
analox_matrix : entity work.mixer_interface
  Port map( 
    clk => clk,
      rst => rst,
      wr => wr,
      out_addr => out_addr_int,
      ch_addr => ch_addr_int,
      gain_in => gain_in,
      mixer_inputs => mixer_inputs,
      outputs => outputs
  );

  random_1 : entity work.random_voltage
    port map (
      Clock      => clk     , 
      rst        => rst       ,
      recycle    => cycle_recycle   ,  
      noise_freq => noise_freq,
      slew_in    => slew_in   , 
      noise_1    => noise_1   ,
      noise_2    => noise_2   ,
      );

      YUV_out_levels : entity work.YUV_levels 
        Port map( 
               y_signal1 => y_signal1,
               y_signal2 => y_signal2,
               y_alpha   => y_alpha  ,
               y_result  => y_result ,
               u_signal1 => u_signal1,
               u_signal2 => u_signal2,
               u_alpha   => u_alpha  ,
               u_result  => u_result ,
               v_signal1 => v_signal1,
               v_signal2 => v_signal2,
               v_alpha   => v_alpha  ,
               v_result  => v_result 
               );

end Behavioral;
