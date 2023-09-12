library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.ALL;
library work;
use work.array_pck.all;

entity AudioMixer is
    Port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        inputs : in array_12(9 downto 0); -- 12-bit wide inputs
        gains : in array_4(9 downto 0);  -- 4-bit gain control for each input
        output : out STD_LOGIC_VECTOR(11 downto 0)  -- 12-bit wide output
    );
end AudioMixer;

architecture Behavioral of AudioMixer is
    signal accumulator : unsigned(15 downto 0) := (others => '0');
    signal accumulator_2 : unsigned(15 downto 0) := (others => '0');
    signal clamped_output : unsigned(11 downto 0);
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                accumulator <= (others => '0');
            else
             
          
                accumulator <=  (unsigned(inputs(0)) * unsigned(gains(0)))+
                                (unsigned(inputs(1)) * unsigned(gains(1)))+
                                (unsigned(inputs(2)) * unsigned(gains(2)))+
                                (unsigned(inputs(3)) * unsigned(gains(3)))+
                                (unsigned(inputs(4)) * unsigned(gains(4)))+
                                (unsigned(inputs(5)) * unsigned(gains(5)))+
                                (unsigned(inputs(6)) * unsigned(gains(6)))+
                                (unsigned(inputs(7)) * unsigned(gains(7)))+
                                (unsigned(inputs(8)) * unsigned(gains(8)))+
                                (unsigned(inputs(9)) * unsigned(gains(9)))
                
                ;
                accumulator_2 <= accumulator / 15; 
               
           end if;   
      
                -- Clamp the output to prevent overflows and underflows
                if accumulator_2 > 4094 then  -- Maximum value for 12-bit unsigned
                    clamped_output <= (others => '1');
--                elsif accumulator_2 < 1 then  -- Minimum value for 12-bit signed
--                    clamped_output <= (others => '0');
                else
                    clamped_output <= accumulator_2(11 downto 0);
                end if;
            end if;

    end process;

    output <= std_logic_vector(clamped_output);
end Behavioral;
