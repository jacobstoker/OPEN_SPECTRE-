-- test bench for edge detector

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity edge_detector_tb is
end entity;

architecture behavioral of edge_detector_tb is
    -- test input signal
    signal x: std_logic := '0';

    -- test outputs
    signal rising_edge: std_logic;
    signal falling_edge: std_logic;

    -- instantiate the edge detector
    component edge_detector is
        port (
            x: in std_logic;  -- input signal
            rising_edge: out std_logic;  -- rising edge detected
            falling_edge: out std_logic  -- falling edge detected
        );
    end component;

begin
    -- instantiate the edge detector
    UUT: edge_detector
        port map (
            x => x,
            rising_edge => rising_edge,
            falling_edge => falling_edge
        );

    -- test stimulus process
    stim_proc: process
    begin
        -- set the input signal and wait for the output to be stable
        x <= '0';
        wait for 10 ns;

        -- set the input signal and wait for the output to be stable
        x <= '1';
        wait for 10 ns;

        -- set the input signal and wait for the output to be stable
        x <= '1';
        wait for 10 ns;

        -- set the input signal and wait for the output to be stable
        x <= '0';
        wait for 10 ns;

        -- end the test
        wait;
    end process;
end architecture;
