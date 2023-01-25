--basic n:1 mux
-- needs cleanup and finish

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_1bit_n_to_1 is
    Port ( a : in  STD_LOGIC_VECTOR (n-1 downto 0);
           sel : in  STD_LOGIC_VECTOR (log2(n) downto 0);
           out : out  STD_LOGIC);
end mux_1bit_n_to_1;

architecture Behavioral of mux_1bit_n_to_1 is
begin
    process(a,b,sel)
    begin
    case sel is
        when "0000" => out <= a(0);
        when "0001" => out <= a(1);
        when "0010" => out <= a(2);
        ...
        when "1110" => out <= a(n-1);
    end case;
    end process;
end Behavioral;
