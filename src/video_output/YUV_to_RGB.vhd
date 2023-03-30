-- converts YUV to rgb

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity YUV_to_RGB is
    Port (
        Y : in std_logic_vector(7 downto 0);
        U : in std_logic_vector(7 downto 0);
        V : in std_logic_vector(7 downto 0);
        R : out std_logic_vector(7 downto 0);
        G : out std_logic_vector(7 downto 0);
        B : out std_logic_vector(7 downto 0)
    );
end YUV_to_RGB;

architecture Behavioral of YUV_to_RGB is

function saturation(input_value : signed; min_value : integer := 0; max_value : integer := 255) return signed is
begin
    if input_value < to_signed(min_value, input_value'length) then
        return to_signed(min_value, input_value'length);
    elsif input_value > to_signed(max_value, input_value'length) then
        return to_signed(max_value, input_value'length);
    else
        return input_value;
    end if;
end function saturation;


    signal Ys, Us, Vs : signed(7 downto 0);
    signal Rs, Gs, Bs : signed(7 downto 0);
    signal C1, C2, C3, C4, C5 : signed(7 downto 0);

    -- Constants for color conversion
    constant Kr : integer := 298;
    constant Kg : integer := 587;
    constant Kb : integer := 114;

begin

    -- Convert YUV to RGB
    Ys <= signed(Y) - 16;
    Us <= signed(U) - 128;
    Vs <= signed(V) - 128;

    C1 <= to_signed(Kr, C1'length) * Ys;
    C2 <= to_signed(Kb, C2'length) * Us;
    C3 <= to_signed(Kg, C3'length) * Us;
    C4 <= to_signed(Kr, C4'length) * Ys;
    C5 <= to_signed(Kg, C5'length) * Vs;

    Rs <= C1 + C2 + C5;
    Gs <= C1 - C3 - C5;
    Bs <= C1 + C4 + C2;

    -- Clamp RGB values to [0, 255]
    R <= std_logic_vector(resize(saturation(Rs), 8));
    G <= std_logic_vector(resize(saturation(Gs), 8));
    B <= std_logic_vector(resize(saturation(Bs), 8));

end Behavioral;


