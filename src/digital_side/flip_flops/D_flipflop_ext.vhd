
--   ____  _____  ______ _   _         _____ _____  ______ _____ _______ _____  ______ 
--  / __ \|  __ \|  ____| \ | |       / ____|  __ \|  ____/ ____|__   __|  __ \|  ____|
-- | |  | | |__) | |__  |  \| |      | (___ | |__) | |__ | |       | |  | |__) | |__   
-- | |  | |  ___/|  __| | . ` |       \___ \|  ___/|  __|| |       | |  |  _  /|  __|  
-- | |__| | |    | |____| |\  |       ____) | |    | |___| |____   | |  | | \ \| |____ 
--  \____/|_|    |______|_| \_|      |_____/|_|    |______\_____|  |_|  |_|  \_\______|
--                               ______                                                
--                              |______|                                               
-- Module Name: D_flipflop_ext by RD Jordan
-- Created: Early 2023
-- Description: 
-- Dependencies: 
-- Additional Comments: You can view the project here: https://github.com/cfoge/OPEN_SPECTRE-
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity D_flipflop_ext is
    Port ( D : in  STD_LOGIC;
           m_clk : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           clear : in  STD_LOGIC;
           preset : in  STD_LOGIC;
           Q : out  STD_LOGIC;
           Q_not : out  STD_LOGIC);
end D_flipflop_ext;

architecture Behavioral of D_flipflop_ext is

signal q_out : STD_LOGIC;
signal edge_event : STD_LOGIC;

begin
    process (clk) begin
         if (edge_event = '1') then
            if (clear = '1') then
                Q <= '0';
            elsif (preset = '1') then
                Q <= '1';
            else
                q_out <= D;
                
            end if;
        end if;
        Q_not <= not q_out;
        Q <=  q_out;
    end process;
    
    
        detect_edge: entity work.edge_detector
        port map (
            x => clk,
            clk => m_clk,
            rising_edge_O => edge_event
        );
        
end Behavioral;
