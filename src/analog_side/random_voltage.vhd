library ieee;

use ieee.std_logic_1164.all;

entity random_voltage is

  port (
    Clock, slew, recycle, rst, x : in std_logic;

    noise_1 : out std_logic_vector(9 downto 0);
    noise_2 : out std_logic_vector(9 downto 0)
    );

end random_voltage;

architecture exam of random_voltage is

  signal spio_out_1, spio_out_2  : std_logic_vector(7 downto 0);
  signal Sin, x_clk  : std_logic;
  signal mux_in : std_logic_vector(7 downto 0) := "001100110"; -- only inputs 0,1,5,6 are set to gnd so i set the rest to 1 i guess
  signal sipo_dac_1, sipo_dac_2, noise_1_latched, noise_2_latched  : std_logic_vector(3 downto 0);

begin

  sipo_1 : entity work.shift_sipo
    port map(
      Clock => Clock, 
      SinA => Sin, 
      SinB => Sin, 
      rst => rst,
      Pout => spio_out_1
      );

      sipo_dac_1 <= spio_out_1(3 downto 0);
      sipo_dac_2 <= spio_out_1(0 downto 3);

  sipo_2 : entity work.shift_sipo
      port map(
        Clock => Clock, 
        SinA => spio_out_1(7), 
        SinB => spio_out_1(7), 
        rst => '0',
        Pout => spio_out_2
        );


  mux_1 : entity work.mux_8_to_1
      Port map( 
          data => mux_in(7 downto 1)&recycle,
          sel = spio_out_2(7)&spio_out_2(5),
          mux_out => sin
      );

      process (Clock) begin       -- bring x into the clock domain of this module
      if (Clock'event and Clock = '1') then
        x_clk <= x;
      end if;
    end process;

      process(x_clk) begin -- latch the dac out on x... whatever x is
        if (x_clk = '1') then
          noise_1_latched <= sipo_dac_1;
          noise_2_latched <= sipo_dac_2;
          end if;

      end process;

      noise_1(9 downto 6) <= noise_1_latched;
      noise_2(9 downto 6) <= noise_2_latched;

      -- needs level contorl

end exam;