-- 53-to-1 multiplexer

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mux53 is
    port (
        -- inputs
        a: in std_logic_vector(52 downto 0);  -- input signals
        s: in std_logic_vector(5 downto 0);   -- select signals

        -- output
        y: out std_logic  -- output signal
    );
end entity;

architecture behavioral of mux53 is
begin
    -- implement the multiplexer
    y <= a(52) when s = "111111" else
         a(51) when s = "111110" else
         a(50) when s = "111101" else
         a(49) when s = "111100" else
         a(48) when s = "111011" else
         a(47) when s = "111010" else
         a(46) when s = "111001" else
         a(45) when s = "111000" else
         a(44) when s = "110111" else
         a(43) when s = "110110" else
         a(42) when s = "110101" else
         a(41) when s = "110100" else
         a(40) when s = "110011" else
         a(39) when s = "110010" else
         a(38) when s = "110001" else
         a(37) when s = "110000" else
         a(36) when s = "101111" else
         a(35) when s = "101110" else
         a(34) when s = "101101" else
         a(33) when s = "101100" else
         a(32) when s = "101011" else
         a(31) when s = "101010" else
         a(30) when s = "101001" else
         a(29) when s = "101000" else
         a(28) when s = "100111"
--finish