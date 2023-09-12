library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.ALL;
library work;
use work.array_pck.all;

entity analog_matrix is
    Port (
         clk : in STD_LOGIC;
         reset : in STD_LOGIC;
         mixer_inputs : in array_12(9 downto 0);
         mixer_gains_0 : in array_4(9 downto 0);
         mixer_gains_1 : in array_4(9 downto 0);
         mixer_gains_2 : in array_4(9 downto 0);
         mixer_gains_3 : in array_4(9 downto 0);
         mixer_gains_4 : in array_4(9 downto 0);
         mixer_gains_5 : in array_4(9 downto 0);
         mixer_gains_6 : in array_4(9 downto 0);
         mixer_gains_7 : in array_4(9 downto 0);
         mixer_gains_8 : in array_4(9 downto 0);
         mixer_gains_9 : in array_4(9 downto 0);
        outputs : out array_12(9 downto 0)  -- 12-bit wide outputs
    );
end analog_matrix;

architecture Behavioral of analog_matrix is
    component AudioMixer
        Port (
            clk : in STD_LOGIC;
            reset : in STD_LOGIC;
            inputs : in array_12(9 downto 0);
            gains : in array_4(9 downto 0);
            output : out STD_LOGIC_VECTOR(11 downto 0)
        );
    end component;



    signal mixer_outputs : STD_LOGIC_VECTOR(119 downto 0);

begin
    -- Instantiate 10 instances of the AudioMixer module
    Mixer0: AudioMixer port map (
        clk => clk,
        reset => reset,
        inputs => mixer_inputs,
        gains => mixer_gains_0,
        output => outputs(0)
    );
    
    Mixer1: AudioMixer port map (
        clk => clk,
        reset => reset,
        inputs => mixer_inputs,
        gains => mixer_gains_1,
        output => outputs(1)
    );
    
    Mixer2: AudioMixer port map (
        clk => clk,
        reset => reset,
        inputs => mixer_inputs,
        gains => mixer_gains_2,
        output => outputs(2)
    );
    
    Mixer3: AudioMixer port map (
        clk => clk,
        reset => reset,
        inputs => mixer_inputs,
        gains => mixer_gains_3,
        output => outputs(3)
    );
    
    Mixer4: AudioMixer port map (
        clk => clk,
        reset => reset,
        inputs => mixer_inputs,
        gains => mixer_gains_4,
        output => outputs(4)
    );
    
    Mixer5: AudioMixer port map (
        clk => clk,
        reset => reset,
        inputs => mixer_inputs,
        gains => mixer_gains_5,
        output => outputs(5)
    );
    
    Mixer6: AudioMixer port map (
        clk => clk,
        reset => reset,
        inputs => mixer_inputs,
        gains => mixer_gains_6,
        output => outputs(6)
    );
    
    Mixer7: AudioMixer port map (
        clk => clk,
        reset => reset,
        inputs => mixer_inputs,
        gains => mixer_gains_7,
        output => outputs(7)
    );
    
    Mixer8: AudioMixer port map (
        clk => clk,
        reset => reset,
        inputs => mixer_inputs,
        gains => mixer_gains_8,
        output => outputs(8)
    );
    
    Mixer9: AudioMixer port map (
        clk => clk,
        reset => reset,
        inputs => mixer_inputs,
        gains => mixer_gains_9,
        output => outputs(9)
    );



end Behavioral;
