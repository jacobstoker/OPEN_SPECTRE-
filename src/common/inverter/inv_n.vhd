
--   ____  _____  ______ _   _         _____ _____  ______ _____ _______ _____  ______ 
--  / __ \|  __ \|  ____| \ | |       / ____|  __ \|  ____/ ____|__   __|  __ \|  ____|
-- | |  | | |__) | |__  |  \| |      | (___ | |__) | |__ | |       | |  | |__) | |__   
-- | |  | |  ___/|  __| | . ` |       \___ \|  ___/|  __|| |       | |  |  _  /|  __|  
-- | |__| | |    | |____| |\  |       ____) | |    | |___| |____   | |  | | \ \| |____ 
--  \____/|_|    |______|_| \_|      |_____/|_|    |______\_____|  |_|  |_|  \_\______|
--                               ______                                                
--                              |______|                                               
-- Module Name: inv_n by RD Jordan
-- Created: Early 2023
-- Description: 
-- Dependencies: 
-- Additional Comments: You can view the project here: https://github.com/cfoge/OPEN_SPECTRE-
-- n parallel inverters

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity inv_n is
    generic (
        n: positive  -- number of inverters
    );
    port (
        -- inputs
        a: in std_logic_vector(n-1 downto 0);  -- inputs
        
        -- outputs
        y: out std_logic_vector(n-1 downto 0)  -- outputs
    );
end entity;

architecture behavioral of inv_n is
begin
    -- implement the inverters
    for i in 0 to n-1 generate
        y(i) <= not a(i);
    end generate;
end architecture;
