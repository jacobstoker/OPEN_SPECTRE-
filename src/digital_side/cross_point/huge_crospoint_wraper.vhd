
--   ____  _____  ______ _   _         _____ _____  ______ _____ _______ _____  ______ 
--  / __ \|  __ \|  ____| \ | |       / ____|  __ \|  ____/ ____|__   __|  __ \|  ____|
-- | |  | | |__) | |__  |  \| |      | (___ | |__) | |__ | |       | |  | |__) | |__   
-- | |  | |  ___/|  __| | . ` |       \___ \|  ___/|  __|| |       | |  |  _  /|  __|  
-- | |__| | |    | |____| |\  |       ____) | |    | |___| |____   | |  | | \ \| |____ 
--  \____/|_|    |______|_| \_|      |_____/|_|    |______\_____|  |_|  |_|  \_\______|
--                               ______                                                
--                              |______|                                               
-- Module Name: huge_crospoint_wraper by RD Jordan
-- Created: Early 2023
-- Description: 
-- Dependencies: 
-- Additional Comments: You can view the project here: https://github.com/cfoge/OPEN_SPECTRE-
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity huge_crospoint_wraper is
    Port ( matrix_in : in STD_LOGIC_VECTOR (64 downto 0);
           in_addr  : in STD_LOGIC_VECTOR (5 downto 0);
           in_mux   : in STD_LOGIC_VECTOR (5 downto 0);
           clk        : in std_logic ;
           rst        : in std_logic ;
           load        : in std_logic ;
           latch        : in std_logic ;
           cs        : in STD_LOGIC_VECTOR(3 downto 0) ;
           matrix_out : out STD_LOGIC_VECTOR (64 downto 0));
end huge_crospoint_wraper;

architecture Behavioral of huge_crospoint_wraper is

signal matrix_in_d  :  STD_LOGIC_VECTOR (64 downto 0) := (others => '0');
signal matrix_out_0  :  STD_LOGIC_VECTOR (64 downto 0) := (others => '0');
signal matrix_out_1  :  STD_LOGIC_VECTOR (64 downto 0):= (others => '0');
signal matrix_out_2  :  STD_LOGIC_VECTOR (64 downto 0):= (others => '0');
signal matrix_out_3  :  STD_LOGIC_VECTOR (64 downto 0):= (others => '0');
signal matrix_pullup :  STD_LOGIC_VECTOR (64 downto 0);

begin

    process(clk)
    begin
         if rising_edge(clk) then
            matrix_in_d <= matrix_in;
         end if;
    end process ;
    
    matrix_pullup <= matrix_in_d(64 downto 1) & '1'; -- First input to the first matrix is set high
    --    matrix_pullup <= matrix_in_d(64 downto 1) & '0'; -- First input to the first matrix is set low, this is for testing


    pin_matrix_0: entity work.huge_crospoint_test
      port map (
           matrix_in => matrix_pullup,
           in_addr  => in_addr,
           in_mux => in_mux,
           clk      => clk,
           rst      => rst,
           load       => load ,
           latch     => latch,
           cs      => cs(0) ,
           matrix_out => matrix_out_0
        );
   pin_matrix_1: entity work.huge_crospoint_test
      port map (
           matrix_in => matrix_in_d,
           in_addr  => in_addr,
           in_mux => in_mux,
           clk      => clk,
           rst      => rst,
           load       => load ,
           latch     => latch,
           cs      => cs(1) ,
           matrix_out => matrix_out_1
        );
   pin_matrix_2: entity work.huge_crospoint_test
      port map (
           matrix_in => matrix_in_d,
           in_addr  => in_addr,
           in_mux => in_mux,
           clk      => clk,
           rst      => rst,
           load       => load ,
           latch     => latch,
           cs      => cs(2) ,
           matrix_out => matrix_out_2
        );
   pin_matrix_3: entity work.huge_crospoint_test
      port map (
           matrix_in => matrix_in_d,
           in_addr  => in_addr,
           in_mux => in_mux,
           clk      => clk,
           rst      => rst,
           load       => load ,
           latch     => latch,
           cs      => cs(3) ,
           matrix_out => matrix_out_3
        );
        
        
        
        -- Combine all 4 matrix mixers, each mixer can be thought of as a single pin in the orginal EMS pin matrix 
        matrix_out <= matrix_out_0 or matrix_out_1 or matrix_out_2 or matrix_out_3; 


end Behavioral;