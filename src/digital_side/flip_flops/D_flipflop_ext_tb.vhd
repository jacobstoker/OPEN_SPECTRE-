
--   ____  _____  ______ _   _         _____ _____  ______ _____ _______ _____  ______ 
--  / __ \|  __ \|  ____| \ | |       / ____|  __ \|  ____/ ____|__   __|  __ \|  ____|
-- | |  | | |__) | |__  |  \| |      | (___ | |__) | |__ | |       | |  | |__) | |__   
-- | |  | |  ___/|  __| | . ` |       \___ \|  ___/|  __|| |       | |  |  _  /|  __|  
-- | |__| | |    | |____| |\  |       ____) | |    | |___| |____   | |  | | \ \| |____ 
--  \____/|_|    |______|_| \_|      |_____/|_|    |______\_____|  |_|  |_|  \_\______|
--                               ______                                                
--                              |______|                                               
-- Module Name: D_flipflop_ext_tb by RD Jordan
-- Created: Early 2023
-- Description: 
-- Dependencies: 
-- Additional Comments: You can view the project here: https://github.com/cfoge/OPEN_SPECTRE-
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity D_flipflop_ext_tb is
end D_flipflop_ext_tb;

architecture Behavioral of D_flipflop_ext_tb is
    signal D, clk, clear, preset : std_logic;
    signal Q, Q_not : std_logic;
begin
    -- Instantiate the DUT
    dut: entity work.D_flipflop_ext
        port map (D => D, clk => clk, clear => clear, preset => preset, Q => Q, Q_not => Q_not);

    -- Test case 1: input is stored on rising edge of clock
    D <= '1';
    clk <= '0';
    clear <= '0';
    preset <= '0';
    wait for 10 ns;
    clk <= '1';
    wait for 10 ns;
    assert Q = '1'
        report "Test case 1 failed: input is not stored on rising edge of clock"
        severity failure;

    -- Test case 2: clear sets Q to 0
    D <= '1';
    clk <= '0';
    clear <= '1';
    preset <= '0';
    wait for 10 ns;
    clk <= '1';
    wait for 10 ns;
    assert Q = '0'
        report "Test case 2 failed: clear does not set Q to 0"
        severity failure;
    
    -- Test case 3: preset sets Q to 1
    D <= '0';
    clk <= '0';
    clear <= '0';
    preset <= '1';
    wait for 10 ns;
    clk <= '1';
    wait for 10 ns;
    assert Q = '1'
        report "Test case 3 failed: preset does not set Q to 1"
        severity failure;

    -- Test case 4: Q_not is inverted value of Q
    D <= '1';
    clk <= '0';
    clear <= '0';
    preset <= '0';
    wait for 10 ns;
    clk <= '1';
    wait for 10 ns;
    assert Q_not = '0'
        report "Test case 4 failed: Q_not is not inverted value of Q"
        severity failure;

end Behavioral;
