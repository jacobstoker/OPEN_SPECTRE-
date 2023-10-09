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
    
 );
end analog_side;

architecture Behavioral of analog_side is
   signal out_addr_int     :   integer;
   signal ch_addr_int      :   integer;
   
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

end Behavioral;
