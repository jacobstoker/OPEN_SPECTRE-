----------------------------------------------------------------------------------
--   ____  _____  ______ _   _         _____ _____  ______ _____ _______ _____  ______ 
--  / __ \|  __ \|  ____| \ | |       / ____|  __ \|  ____/ ____|__   __|  __ \|  ____|
-- | |  | | |__) | |__  |  \| |      | (___ | |__) | |__ | |       | |  | |__) | |__   
-- | |  | |  ___/|  __| | . ` |       \___ \|  ___/|  __|| |       | |  |  _  /|  __|  
-- | |__| | |    | |____| |\  |       ____) | |    | |___| |____   | |  | | \ \| |____ 
--  \____/|_|    |______|_| \_|      |_____/|_|    |______\_____|  |_|  |_|  \_\______|
--                               ______                                                
--                              |______|                                               
--
-- Module Name: compare_7 - Behavioral
-- Description: 
-- 
-- Dependencies: 
-- 
-- Additional Comments:

library IEEE;
use IEEE.std_logic_signed.all;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity compare_7 is
    Port ( clk    : in std_logic ;
           luma_i : in STD_LOGIC_VECTOR (7 downto 0);
           output : out STD_LOGIC_VECTOR (6 downto 0);
           span : in STD_LOGIC_VECTOR (7 downto 0));
end compare_7;

architecture Behavioral of compare_7 is
signal span_div_6,span_1,span_2,span_3,span_4,span_5,span_6:  STD_LOGIC_VECTOR (7 downto 0); --create signals to hold comparitor values
constant comp_num : integer  := 6;
begin

process (clk)   --update comparitor values
    begin
        span_div_6 <= std_logic_vector(to_unsigned(to_integer(unsigned(span)) / comp_num,8)) ;
        span_1 <= span - span_div_6;
        span_2 <= span - span_div_6 - span_div_6;
        span_3 <= span - span_div_6 - span_div_6 - span_div_6;
        span_4 <= span_div_6 + span_div_6 + span_div_6;
        span_5 <= span_div_6 + span_div_6;
        span_6 <= span_div_6;
    end process;


end Behavioral;
