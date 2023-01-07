library ieee;
use ieee.std_logic_1164.all;

entity delay_800us is
    port (
        clk: in std_logic;
        input: in std_logic;
        output: out std_logic
    );
end entity;

architecture behavioral of delay_800us is
    -- 800 us delay = 800 us * 25 MHz = 20,000 clock cycles
    constant DELAY: integer := 20000;
    signal counter: integer range 0 to DELAY;
    signal buffer: std_logic;
begin
    process (clk)
    begin
        if rising_edge(clk) then
            if counter = DELAY then
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    buffer <= input when counter = 0 else 'Z';
    output <= buffer;
end architecture;
