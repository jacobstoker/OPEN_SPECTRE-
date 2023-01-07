-- test bench for VGA sync generator

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sync_gen_tb is
end entity;

architecture behavioral of sync_gen_tb is
    -- instantiate the sync generator
    component sync_gen is
        port (
            clk: in std_logic;       -- clock input
            rst: in std_logic;       -- reset input
            h_sync: out std_logic;   -- horizontal sync output
            v_sync: out std_logic;   -- vertical sync output
            h_count: out integer;    -- horizontal count output
            v_count: out integer     -- vertical count output
        );
    end component;

    -- test input signals
    signal clk: std_logic;
    signal rst: std_logic;

    -- test output signals
    signal h_sync: std_logic;
    signal v_sync: std_logic;
    signal h_count: integer;
    signal v_count: integer;

begin
    -- instantiate the sync generator
    UUT: sync_gen
        port map (
            clk => clk,
            rst => rst,
            h_sync => h_sync,
            v_sync => v_sync,
            h_count => h_count,
            v_count => v_count
        );

    -- test stimulus process
    stim_proc: process
    begin
        -- set the inputs and wait for the output to be stable
        clk <= '0';
        rst <= '1';
        wait for 10 ns;

        rst <= '0';
        wait for 10 ns;

        -- toggle the clock and wait for the output to be stable
        for i in 1 to 512*512*2 loop
            clk <= not clk;
            wait for 10 ns;
        end loop;

        -- end the test
        wait;
    end process;
end architecture;
