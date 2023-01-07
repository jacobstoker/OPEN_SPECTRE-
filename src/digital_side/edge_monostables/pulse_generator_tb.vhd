library ieee;
use ieee.std_logic_1164.all;

entity pulse_generator_tb is
    generic (
        pulse_width: positive
    );
end pulse_generator_tb;

architecture beh of pulse_generator_tb is
    signal clk: std_logic := '0';
    signal rst: std_logic;
    signal trigger: std_logic;
    signal pulse: std_logic;
    constant clk_period: time := 40 ns;
begin
    -- Generate a 25 MHz clock
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Reset the pulse generator
    rst <= '1';
    wait for clk_period;
    rst <= '0';

    -- Test case for no trigger
    trigger <= '0';
    wait for clk_period*10;
    assert pulse = '0' report "Error: unexpected pulse output with no trigger" severity error;

    -- Test case for trigger on falling edge
    trigger <= '1';
    wait for clk_period;
    trigger <= '0';
    wait for clk_period*10;
    assert pulse = '1' report "Error: unexpected pulse output on falling edge trigger" severity error;

    -- Test case for trigger on rising edge
    trigger <= '0';
    wait for clk_period;
    trigger <= '1';
    wait for clk_period*10;
    assert pulse = '0' report "Error: unexpected pulse output on rising edge trigger" severity error;
end beh;
