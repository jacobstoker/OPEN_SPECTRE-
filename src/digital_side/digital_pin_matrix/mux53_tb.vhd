-- test bench for 53-to-1 multiplexer

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mux53_tb is
end entity;

architecture behavioral of mux53_tb is
    -- instantiate the multiplexer
    component mux53 is
        port (
            a: in std_logic_vector(52 downto 0);  -- input signals
            s: in std_logic_vector(5 downto 0);   -- select signals
            y: out std_logic  -- output signal
        );
    end component;

    -- test input signals
    signal a: std_logic_vector(52 downto 0) := (others => '0');
    signal s: std_logic_vector(5 downto 0) := (others => '0');

    -- test output signal
    signal y: std_logic;

begin
    -- instantiate the multiplexer
    UUT: mux53
        port map (
            a => a,
            s => s,
            y => y
        );

    -- test stimulus process
    stim_proc: process
    begin
        -- set the inputs and wait for the output to be stable
        a <= (others => '0');
        s <= "000000";
        wait for 10 ns;

        -- set the inputs and wait for the output to be stable
        a <= (others => '1');
        s <= "111111";
        wait for 10 ns;

        -- set the inputs and wait for the output to be stable
        a <= "0000000000000000000000000000000000000000000100000000000000000000";
        s <= "000001";
        wait for 10 ns;

        -- end the test
        wait;
    end process;
end architecture;
