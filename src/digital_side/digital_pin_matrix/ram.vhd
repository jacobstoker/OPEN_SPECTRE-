-- 53-bit wide, 57-word deep RAM

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ram is
    port (
        -- inputs
        clk: in std_logic;                 -- clock signal
        we: in std_logic;                  -- write enable signal
        addr: in std_logic_vector(5 downto 0);  -- address input
        din: in std_logic_vector(52 downto 0);  -- data input

        -- outputs
        dout: out std_logic_vector(52 downto 0)  -- data output
    );
end entity;

architecture behavioral of ram is
    type ram_type is array (0 to 56) of std_logic_vector(52 downto 0);
    signal ram: ram_type;
begin
    -- read operation
    dout <= ram(conv_integer(addr));

    -- write operation
    process (clk)
    begin
        if rising_edge(clk) then
            if we = '1' then
                ram(conv_integer(addr)) <= din;
            end if;
        end if;
    end process;
end architecture;
