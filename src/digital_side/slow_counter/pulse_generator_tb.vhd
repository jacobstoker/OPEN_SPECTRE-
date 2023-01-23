library ieee;
use ieee.std_logic_1164.all;

entity pulse_generator_tb is
end pulse_generator_tb;

architecture behavior of pulse_generator_tb is
    signal clk : std_logic := '0';
    signal pulse_6hz : std_logic;
    signal pulse_3hz : std_logic;
    signal pulse_1_5hz : std_logic;
    signal pulse_0_6hz : std_logic;
    signal pulse_0_4hz : std_logic;
    signal pulse_0_2hz : std_logic;
begin
    -- Instantiate the pulse_generator module
    uut: entity work.pulse_generator
        generic map (
            CLOCK_FREQUENCY => 25_000_000
        )
        port map (
            clk => clk,
            pulse_6hz => pulse_6hz,
            pulse_3hz => pulse_3hz,
            pulse_1_5hz => pulse_1_5hz,
            pulse_0_6hz => pulse_0_6hz,
            pulse_0_4hz => pulse_0_4hz,
            pulse_0_2hz => pulse_0_2hz
        );
    
    -- Clock process to drive the test bench
    clk_process : process
    begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;
    
    -- Test case to check the output frequencies
    test_case : process
    begin
        wait for 50 ns;
        assert pulse_6hz = '1' report "6Hz pulse not high" severity failure;
        wait for 50 ns;
        assert pulse_6hz = '0' report "6Hz pulse not low" severity failure;
        wait for 50 ns;
        assert pulse_6hz = '1' report "6Hz pulse not high" severity failure;
        
        wait for 50 ns;
        assert pulse_3hz = '1' report "3Hz pulse not high" severity failure;
        wait for 50 ns;
        assert pulse_3hz = '0' report "3Hz pulse not low" severity failure;
        wait for 50 ns;
        assert pulse_3hz = '1' report "3Hz pulse not high" severity failure;
        
        wait for 50 ns;
        assert pulse_1_5hz = '1' report "1.5Hz pulse not high" severity failure;
        wait for 50 ns;
        assert pulse_1_5hz = '0' report "1.5Hz pulse not low" severity failure;
        wait for 50 ns;
        assert pulse_1_5hz = '1' report "1.5Hz pulse not high" severity failure;
        
        wait for 50 ns;
        assert pulse_0_6hz = '1' report "0.6Hz pulse not high" severity failure;
        wait for 50 ns;
        assert pulse_0_6hz = '0' report "0.6Hz pulse not low" severity failure;
        wait for 50 ns;
       
--FINISH!!!