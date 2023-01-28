--slow counter
library ieee;
use ieee.std_logic_1164.all;

entity pulse_generator is
    generic (
        CLOCK_FREQUENCY : positive := 25_000_000
    );
    port (
        clk : in std_logic;
        pulse_6hz : out std_logic;
        pulse_3hz : out std_logic;
        pulse_1_5hz : out std_logic;
        pulse_0_6hz : out std_logic;
        pulse_0_4hz : out std_logic;
        pulse_0_2hz : out std_logic
    );
end pulse_generator;

architecture behavior of pulse_generator is
    signal counter : integer range 0 to CLOCK_FREQUENCY-1;
    signal counter_6hz : integer range 0 to (CLOCK_FREQUENCY/6)-1;
    signal counter_3hz : integer range 0 to (CLOCK_FREQUENCY/3)-1;
    signal counter_1_5hz : integer range 0 to integer(real(CLOCK_FREQUENCY)/real(1.5))-1;
    signal counter_0_6hz_pulse : integer range 0 to 10;

begin
    process (clk)
    begin
        if rising_edge(clk) then
            if counter = CLOCK_FREQUENCY-1 then
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
            
            if counter_6hz = (CLOCK_FREQUENCY/6)-1 then
                counter_6hz <= 0;
                counter_0_6hz_pulse <= counter_0_6hz_pulse + 1;
            else
                counter_6hz <= counter_6hz + 1;
            end if;
            
            if counter_3hz = (CLOCK_FREQUENCY/3)-1 then
                counter_3hz <= 0;
            else
                counter_3hz <= counter_3hz + 1;
            end if;
            
            if counter_1_5hz = integer(real(CLOCK_FREQUENCY)/real(1.5))-1 then
                counter_1_5hz <= 0;
            else
                counter_1_5hz <= counter_1_5hz + 1;
            end if;


        end if;
    end process;
    
    pulse_6hz <= '1' when counter_6hz = (CLOCK_FREQUENCY/6)-1 else '0';
    pulse_3hz <= '1' when counter_3hz = (CLOCK_FREQUENCY/3)-1 else '0';
    pulse_1_5hz <= '1' when counter_1_5hz = integer(real(CLOCK_FREQUENCY)/real(1.5))-1 else '0';
    pulse_0_6hz <= '1' when counter_0_6hz_pulse = 10 else '0';
    pulse_0_4hz <= '1' when counter_0_6hz_pulse = 15 else '0';
    pulse_0_2hz <= '1' when counter_0_6hz_pulse = 30 else '0';
end behavior;
