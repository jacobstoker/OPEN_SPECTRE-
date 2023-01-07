-- edge detector

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity edge_detector is
    port (
        -- input
        x: in std_logic;  -- input signal

        -- outputs
        rising_edge: out std_logic;  -- rising edge detected
        falling_edge: out std_logic  -- falling edge detected
    );
end entity;

architecture behavioral of edge_detector is
    signal x_reg: std_logic;  -- flip-flop for storing the previous value of x
begin
    -- rising edge detection
    rising_edge <= '1' when x_reg = '0' and x = '1' else '0';

    -- falling edge detection
    falling_edge <= '1' when x_reg = '1' and x = '0' else '0';

    -- store the previous value of x
    process (x)
    begin
        x_reg <= x;
    end process;
end architecture;
