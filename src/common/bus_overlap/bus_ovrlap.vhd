-- module creates overlapping output busses

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bus_ovrlap is
   generic (
        n: positive := 1; -- number of overlap bits
        k: positive := 4; -- sub bus width
        p: positive := 16 -- port in width, must be then n^2?
    );
    port (
        -- inputs
        a: in std_logic_vector(p-1 downto 0);  -- inputs

        -- outputs
        y: out std_logic_vector(p-1 downto 0)  -- outputs
    );
end bus_ovrlap;

architecture Behavioral of bus_ovrlap is
    signal reordered : std_logic_vector(p-1 downto 0);

begin
     g_GENERATE_int0: for j in 0 to (p/k)-1 generate 
     g_GENERATE_int1: for i in 0 to k-1 generate  
        reordered((i+(j*k))) <= a( (i mod k) +(j*k) -(j*n)           );
    end generate g_GENERATE_int1;
    end generate g_GENERATE_int0;
 
  y <= reordered;


end Behavioral;
