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
        inputs : in array_12(9 downto 0); -- 12-bit wide inputs
        --gains : in array_4(9 downto 0);  -- 4-bit gain control for each input
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

    signal mixer_inputs : array_12(9 downto 0);
    signal mixer_gains_0 : array_4(9 downto 0);
    signal mixer_gains_1 : array_4(9 downto 0);
    signal mixer_gains_2 : array_4(9 downto 0);
    signal mixer_gains_3 : array_4(9 downto 0);
    signal mixer_gains_4 : array_4(9 downto 0);
    signal mixer_gains_5 : array_4(9 downto 0);
    signal mixer_gains_6 : array_4(9 downto 0);
    signal mixer_gains_7 : array_4(9 downto 0);
    signal mixer_gains_8 : array_4(9 downto 0);
    signal mixer_gains_9 : array_4(9 downto 0);

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
