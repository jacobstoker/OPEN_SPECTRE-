library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity YUV_levels is
    Port ( y_signal1 : in STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
           y_signal2 : in STD_LOGIC_VECTOR(11 downto 0);
           y_alpha   : in STD_LOGIC_VECTOR(11 downto 0) ;
           y_result  : out STD_LOGIC_VECTOR(11 downto 0);
           u_signal1 : in STD_LOGIC_VECTOR(11 downto 0) (others => '0');
           u_signal2 : in STD_LOGIC_VECTOR(11 downto 0);
           u_alpha   : in STD_LOGIC_VECTOR(11 downto 0);
           u_result  : out STD_LOGIC_VECTOR(11 downto 0);
           v_signal1 : in STD_LOGIC_VECTOR(11 downto 0) (others => '0');
           v_signal2 : in STD_LOGIC_VECTOR(11 downto 0);
           v_alpha   : in STD_LOGIC_VECTOR(11 downto 0);
           v_result  : out STD_LOGIC_VECTOR(11 downto 0));
end YUV_levels;

architecture Behavioral of YUV_levels is
    component AlphaBlend
        Port ( signal1 : in STD_LOGIC_VECTOR(11 downto 0);
               signal2 : in STD_LOGIC_VECTOR(11 downto 0);
               alpha   : in STD_LOGIC_VECTOR(11 downto 0);
               result  : out STD_LOGIC_VECTOR(11 downto 0));
    end component;

    signal y_result_int, u_result_int, v_result_int : integer range 0 to 4095;
begin
    -- Instantiate alpha blend modules
    level_y : AlphaBlend
        port map (signal1 => y_signal1,
                  signal2 => y_signal2,
                  alpha => y_alpha,
                  result => y_result);

    level_u : AlphaBlend
        port map (signal1 => u_signal1,
                  signal2 => u_signal2,
                  alpha => u_alpha,
                  result => u_result);

    level_v : AlphaBlend
        port map (signal1 => v_signal1,
                  signal2 => v_signal2,
                  alpha => v_alpha,
                  result => v_result);
end Behavioral;
