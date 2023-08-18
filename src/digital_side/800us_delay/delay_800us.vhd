
--   ____  _____  ______ _   _         _____ _____  ______ _____ _______ _____  ______ 
--  / __ \|  __ \|  ____| \ | |       / ____|  __ \|  ____/ ____|__   __|  __ \|  ____|
-- | |  | | |__) | |__  |  \| |      | (___ | |__) | |__ | |       | |  | |__) | |__   
-- | |  | |  ___/|  __| | . ` |       \___ \|  ___/|  __|| |       | |  |  _  /|  __|  
-- | |__| | |    | |____| |\  |       ____) | |    | |___| |____   | |  | | \ \| |____ 
--  \____/|_|    |______|_| \_|      |_____/|_|    |______\_____|  |_|  |_|  \_\______|
--                               ______                                                
--                              |______|                                               
-- Module Name: delay_800us by RD Jordan
-- Created: Early 2023
-- Description: 
-- Dependencies: 
-- Additional Comments: You can view the project here: https://github.com/cfoge/OPEN_SPECTRE-
library ieee;
use ieee.std_logic_1164.all;

entity delay_800us is
    port (
        clk: in std_logic;
        input: in std_logic;
        output: out std_logic
    );
end entity;

architecture behavioral of delay_800us is
    -- 800 us delay = 800 us * 25 MHz = 20,000 clock cycles
    constant DELAY: integer := 20000;
    signal counter: integer range 0 to DELAY;
    signal bufferA: std_logic;
begin
    process (clk)
    begin
        if rising_edge(clk) then
            if counter = DELAY then
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    bufferA <= input when counter = 0 else 'Z';
    output <= bufferA;
end architecture;
