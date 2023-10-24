library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


use work.oscillator_pkg.all;
use work.sin_LUT_pkg.all;

--TODO: More thinking and work could be done to make this more generic, I think you could pass LUT_data as a generic even
entity sin_LUT is
    generic (
        IDX_WIDTH    : integer := 10;
        OUTPUT_WIDTH : integer := 10
    );
    port (
        index  : in  std_logic_vector(IDX_WIDTH-1 downto 0);
        output : out std_logic_vector(OUTPUT_WIDTH-1 downto 0)
    );
end entity;

architecture Behavioural of sin_LUT is
begin
    process(index)
    variable idx_value : integer;
    begin
        idx_value := to_integer(unsigned(index));
        if (idx_value < ROM_DEPTH) then
            output <= ROM_data(idx_value);
        else
            -- Index somehow out of range
            output <= (others => '0');
        end if;
    end process;
end Behavioural;
