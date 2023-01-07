-- n-bit comparator

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity comparator is
    generic (
        width: integer := 8  -- width of the operands
    );
    port (
        a: in std_logic_vector(width-1 downto 0);  -- first operand
        b: in std_logic_vector(width-1 downto 0);  -- second operand
        equal: out std_logic;  -- '1' if a = b, '0' otherwise
        greater: out std_logic  -- '1' if a > b, '0' otherwise
    );
end entity;

architecture behavioral of comparator is
begin
    -- compare a and b and set outputs
    equal <= '1' when a = b else '0';
    greater <= '1' when a > b else '0';
end architecture;
