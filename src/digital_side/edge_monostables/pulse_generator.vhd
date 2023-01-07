--aproximation of a monostable with a generic defined pullse lenght

library ieee;
use ieee.std_logic_1164.all;

entity pulse_generator is
    generic (
        pulse_width: positive
    );
    port (
        clk: in std_logic;
        rst: in std_logic;
        trigger: in std_logic;
        pulse: out std_logic
    );
end pulse_generator;

architecture beh of pulse_generator is
    signal count: positive range 0 to pulse_width;
    signal pulse_enable: std_logic;
begin
    process(clk)
    begin
        if rst = '1' then
            count <= 0;
            pulse <= '0';
        elsif rising_edge(clk) then
            if pulse_enable = '1' then
                if count = pulse_width then
                    count <= 0;
                    pulse_enable <= '0';
                else
                    count <= count + 1;
                end if;
            end if;
        end if;
    end process;

    process(trigger)
    begin
        if falling_edge(trigger) then
            pulse_enable <= '1';
        end if;
    end process;
end beh;
