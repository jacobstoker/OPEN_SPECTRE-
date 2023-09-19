
--   ____  _____  ______ _   _         _____ _____  ______ _____ _______ _____  ______ 
--  / __ \|  __ \|  ____| \ | |       / ____|  __ \|  ____/ ____|__   __|  __ \|  ____|
-- | |  | | |__) | |__  |  \| |      | (___ | |__) | |__ | |       | |  | |__) | |__   
-- | |  | |  ___/|  __| | . ` |       \___ \|  ___/|  __|| |       | |  |  _  /|  __|  
-- | |__| | |    | |____| |\  |       ____) | |    | |___| |____   | |  | | \ \| |____ 
--  \____/|_|    |______|_| \_|      |_____/|_|    |______\_____|  |_|  |_|  \_\______|
--                               ______                                                
--                              |______|                                               
-- Module Name: vga_trimming_signals by RD Jordan
-- Created: Early 2023
-- Description: 
-- Dependencies: 
-- Additional Comments: You can view the project here: https://github.com/cfoge/OPEN_SPECTRE-
--640X480 timing generator boilerplate code

library ieee;
use ieee.std_logic_1164.all;

entity vga_trimming_signals is
    port (
        clk_25mhz    : in  std_logic;    -- 25MHz clock input
        h_sync       : out std_logic;    -- horizontal sync output
        v_sync       : out std_logic;    -- vertical sync output
        video_on     : out std_logic     -- video on/off output
    );
end vga_trimming_signals;

architecture rtl of vga_trimming_signals is
    -- VGA timings
    constant h_front_porch : integer := 16;
    constant h_sync_width  : integer := 96;
    constant h_back_porch  : integer := 48;
    constant h_total       : integer := 800;
    constant v_front_porch : integer := 10;
    constant v_sync_width  : integer := 2;
    constant v_back_porch  : integer := 33;
    constant v_total       : integer := 525;
    
    -- Internal counters
    signal h_count : integer range 0 to h_total - 1 := 0;
    signal v_count : integer range 0 to v_total - 1 := 0;
    
begin

    process (clk_25mhz)
    begin
        if rising_edge(clk_25mhz) then
            -- Horizontal counter
            if h_count = h_total - 1 then
                h_count <= 0;
                -- Vertical counter
                if v_count = v_total - 1 then
                    v_count <= 0;
                    video_on <= '1';
                else
                    v_count <= v_count + 1;
                    video_on <= '0';
                end if;
            else
                h_count <= h_count + 1;
                video_on <= '0';
            end if;
            
            -- Horizontal sync
            if h_count < h_sync_width + h_front_porch then
                h_sync <= '1';
            else
                h_sync <= '0';
            end if;
            
            -- Vertical sync
            if v_count < v_sync_width + v_front_porch then
                v_sync <= '1';
            else
                v_sync <= '0';
            end if;
        end if;
    end process;

end rtl;
