-- VGA video sync generator with a resolution of 512x512

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sync_gen is
    port (
        clk: in std_logic;       -- clock input
        rst: in std_logic;       -- reset input
        h_sync: out std_logic;   -- horizontal sync output
        v_sync: out std_logic;   -- vertical sync output
        h_count: out integer;    -- horizontal count output
        v_count: out integer     -- vertical count output
    );
end entity;

architecture behavioral of sync_gen is
    signal h_count_int: integer range 0 to 511;  -- internal horizontal count
    signal v_count_int: integer range 0 to 511;  -- internal vertical count
begin
    process(clk, rst)  -- sensitivity list
    begin
        if rst = '1' then
            h_count_int <= 0;
            v_count_int <= 0;
            h_sync <= '0';
            v_sync <= '0';
        elsif clk'event and clk = '1' then
            h_count_int <= h_count_int + 1;
            if h_count_int = 511 then
                h_count_int <= 0;
                v_count_int <= v_count_int + 1;
                if v_count_int = 511 then
                    v_count_int <= 0;
                end if;
            end if;
        end if;
    end process;
    h_count <= h_count_int;
    v_count <= v_count_int;
    h_sync <= '1' when h_count_int = 0 else '0';
    v_sync <= '1' when v_count_int = 0 else '0';
end architecture;
