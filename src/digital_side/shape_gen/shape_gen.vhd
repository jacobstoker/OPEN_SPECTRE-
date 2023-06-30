
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity shape_gen is
  Port ( 
        clk          : in  std_logic;
        counter_x          : in  std_logic_vector(8 downto 0);
        counter_y          : in  std_logic_vector(8 downto 0);
        rst          : in  std_logic;
        pos_h   : in  std_logic_vector(8 downto 0);
        pos_v   : in  std_logic_vector(8 downto 0);
        zoom_h   : in  std_logic_vector(8 downto 0);
        zoom_v   : in  std_logic_vector(8 downto 0);
        circle   : in  std_logic_vector(8 downto 0);
        gear   : in  std_logic_vector(8 downto 0);
        lantern   : in  std_logic_vector(8 downto 0);
        fizz   : in  std_logic_vector(8 downto 0);

        shape_a    : out std_logic;
        shape_b    : out std_logic
  
  
  );
end shape_gen;

architecture Behavioral of shape_gen is

    signal pulse_x           : std_logic;
    signal ramp_x           : std_logic_vector(8 downto 0);
    signal parab_x           : std_logic_vector(8 downto 0);
    signal reset_ramp_x           : std_logic_vector(8 downto 0);
    signal reset_ramp_x_length           : unsigned(8 downto 0);
    signal noise_x           : std_logic_vector(8 downto 0);
    
    signal pulse_y           : std_logic;
    signal ramp_y           : std_logic_vector(8 downto 0);
    signal parab_y           : std_logic_vector(8 downto 0);
    signal reset_ramp_y           : std_logic_vector(8 downto 0);
    signal reset_ramp_y_length           : unsigned(8 downto 0);
    signal noise_y           : std_logic_vector(8 downto 0);

begin

reset_ramp_x_length <= shift_right(unsigned(zoom_h), 2);  -- zoom value x 4 so that the reset ram runs faster then h zoom but has a relation to it
reset_ramp_y_length <= shift_right(unsigned(zoom_v), 2); 

x_pulse_gen : entity work.shapes_pulse_gen
port map(
        clk          => clk,
        rst           => rst,
        counter_in    => counter_x,
        pulse_start   => pos_h,
        pulse_len     => zoom_h,
        zoom          => std_logic_vector(reset_ramp_x_length),
        pulse_out     => pulse_x,
        ramp_out      => ramp_x,
        parab_out    => parab_x,
        reset_ramp    => reset_ramp_x,
        noise_out     => noise_x
        );
        
y_pulse_gen : entity work.shapes_pulse_gen
port map(
        clk          => clk,
        rst           => rst,
        counter_in    => counter_y,
        pulse_start   => pos_v,
        pulse_len     => zoom_v,
        zoom          => std_logic_vector(reset_ramp_y_length),
        pulse_out     => pulse_y,
        ramp_out      => ramp_y,
        parab_out    => parab_y,
        reset_ramp    => reset_ramp_y,
        noise_out     => noise_y
        );



end Behavioral;
