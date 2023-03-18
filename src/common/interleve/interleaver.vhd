

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Takes a bus that is n number of concatinated signals (A,B,C,D) and re aragnes them (A1,B1,C1,D1,A2,B2,C2.......

entity interleaver is
    generic (
        n: positive := 8; -- number of sources to interleaver
        p: positive := 64 -- port in width, must be then n^2?
    );
    port (
        -- inputs
        a: in std_logic_vector(p-1 downto 0);  -- first inputs

        -- outputs
        y: out std_logic_vector(p-1 downto 0)  -- outputs
    );
end interleaver;

architecture Behavioral of interleaver is
    signal reordered : std_logic_vector(p-1 downto 0);

begin
 g_GENERATE_int0: for j in 0 to (n)-1 generate 
 g_GENERATE_int1: for i in 0 to n-1 generate  
     reordered((i+(j*n))) <= a( ((i mod n) * n)   + j             );
 end generate g_GENERATE_int1;
 end generate g_GENERATE_int0;
 

        
    y <= reordered;

end Behavioral;
