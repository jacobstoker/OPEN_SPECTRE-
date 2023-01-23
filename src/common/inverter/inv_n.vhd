-- n parallel inverters

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity inv_n is
    generic (
        n: positive  -- number of inverters
    );
    port (
        -- inputs
        a: in std_logic_vector(n-1 downto 0);  -- inputs
        
        -- outputs
        y: out std_logic_vector(n-1 downto 0)  -- outputs
    );
end entity;

architecture behavioral of inv_n is
begin
    -- implement the inverters
    for i in 0 to n-1 generate
        y(i) <= not a(i);
    end generate;
end architecture;
