-- n parallel XOR gates

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity xor_n is
    generic (
        n: positive  -- number of XOR gates
    );
    port (
        -- inputs
        a: in std_logic_vector(n-1 downto 0);  -- first inputs
        b: in std_logic_vector(n-1 downto 0);  -- second inputs

        -- outputs
        y: out std_logic_vector(n-1 downto 0)  -- outputs
    );
end entity;

architecture behavioral of xor_n is

       
begin
    -- implement the XOR gates
    g_GENERATE_XOR: for i in 0 to n-1 generate
        y(i) <= a(i) xor b(i);
    end generate g_GENERATE_XOR;
end architecture;
