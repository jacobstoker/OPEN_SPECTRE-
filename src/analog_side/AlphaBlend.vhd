library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity AlphaBlend is
    Port ( signal1 : in STD_LOGIC_VECTOR(11 downto 0);
           signal2 : in STD_LOGIC_VECTOR(11 downto 0);
           alpha   : in STD_LOGIC_VECTOR(11 downto 0);
           result  : out STD_LOGIC_VECTOR(11 downto 0));
end AlphaBlend;

architecture Behavioral of AlphaBlend is
    signal signal1_int : integer range 0 to 4095;
    signal signal2_int : integer range 0 to 4095;
    signal alpha_int : integer range 0 to 4095;
    signal result_int : integer range 0 to 4095;
begin
    -- Convert std_logic_vector to integer
    signal1_int <= TO_INTEGER(UNSIGNED(signal1));
    signal2_int <= TO_INTEGER(UNSIGNED(signal2));
    alpha_int <= TO_INTEGER(UNSIGNED(alpha));

    -- Perform alpha blending
    result_int <= signal1_int + (alpha_int * (signal2_int - signal1_int)) / 4096;

    -- Convert integer result back to std_logic_vector
    result <= STD_LOGIC_VECTOR(TO_UNSIGNED(result_int, 12));
end Behavioral;
