
--   ____  _____  ______ _   _         _____ _____  ______ _____ _______ _____  ______ 
--  / __ \|  __ \|  ____| \ | |       / ____|  __ \|  ____/ ____|__   __|  __ \|  ____|
-- | |  | | |__) | |__  |  \| |      | (___ | |__) | |__ | |       | |  | |__) | |__   
-- | |  | |  ___/|  __| | . ` |       \___ \|  ___/|  __|| |       | |  |  _  /|  __|  
-- | |__| | |    | |____| |\  |       ____) | |    | |___| |____   | |  | | \ \| |____ 
--  \____/|_|    |______|_| \_|      |_____/|_|    |______\_____|  |_|  |_|  \_\______|
--                               ______                                                
--                              |______|                                               
-- Module Name: edge_detector by RD Jordan
-- Created: Early 2023
-- Description: 
-- Dependencies: 
-- Additional Comments: You can view the project here: https://github.com/cfoge/OPEN_SPECTRE-
-- edge detector

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity edge_detector is
    port (
        -- input
        x: in std_logic;  -- input signal
        clk : in std_logic; 

        -- outputs
        rising_edge_O: out std_logic;  -- rising edge detected
        falling_edge_O: out std_logic  -- falling edge detected
    );
end entity;

architecture behavioral of edge_detector is
    signal x_reg: std_logic;  -- flip-flop for storing the previous value of x
begin
    -- rising edge detection
    rising_edge_O <= '1' when x_reg = '0' and x = '1' else '0';

    -- falling edge detection
    falling_edge_O <= '1' when x_reg = '1' and x = '0' else '0';

    -- store the previous value of x
    process (clk)
    begin
        if rising_edge(clk) then
            x_reg <= x;
        end if;
    end process;
        
end architecture;
