library ieee;

use ieee.std_logic_1164.all;

entity random_voltage is

  port (
    Clock, recycle, rst, chroma_pin_74 : in std_logic;
    noise_freq, slew_freq : in std_logic_vector(9 downto 0);
    noise_1 : out std_logic_vector(9 downto 0);
    noise_2 : out std_logic_vector(9 downto 0)
    );

end random_voltage;

architecture Behavioral of random_voltage is

  signal spio_out_1, spio_out_2  : std_logic_vector(7 downto 0);
  signal count, slew_count : std_logic_vector(9 downto 0);
  signal Sin,x, x_clk, x_clk_d, s_and_h_en, x_latch, cnt_rst, slew_rst,slew_match, cnt_match, sipo_clk  : std_logic := '0';
  signal mux_in, mux_in_des : std_logic_vector(7 downto 0) := "01100011"; -- only inputs 0,1,5,6 are set to gnd so i set the rest to 1 i guess
  signal sipo_dac_1, sipo_dac_2, noise_1_latched, noise_2_latched, noise_1_sh, noise_2_sh  : std_logic_vector(3 downto 0);
  signal mux_sel_in : std_logic_vector(2 downto 0);

begin

  

  sipo_clk <= cnt_match;
  
  sipo_1 : entity work.shift_sipo
    port map(
      Clock => sipo_clk, 
      SinA => Sin, 
      SinB => Sin, 
      rst => rst,
      Pout => spio_out_1
      );

      sipo_dac_1 <= spio_out_1(3 downto 0);
      sipo_dac_2 <= spio_out_1(0) & spio_out_1(1) & spio_out_1(2) & spio_out_1(3);

  sipo_2 : entity work.shift_sipo
      port map(
        Clock => sipo_clk, 
        SinA => spio_out_1(7), 
        SinB => spio_out_1(7), 
        rst => '0',
        Pout => spio_out_2
        );

    mux_in_des <= mux_in(7 downto 0);
    mux_sel_in <= spio_out_2(7)&spio_out_2(5)&recycle;
    
  mux_random : entity work.mux_8_to_1
      Port map( 
          data => mux_in_des,
          sel => mux_sel_in,
          mux_out => sin
      );
      
    process(clock) begin 
       
        if (count > noise_freq) then 
            cnt_match <= '1';
        else 
            cnt_match <= '0';
        end if;

        if (slew_count > slew_freq) then 
            slew_match <= '1';
        else 
            slew_match <= '0';
        end if;
        
      end process;
      
  cnt_rst <= chroma_pin_74 or cnt_match or rst;
  
  random_freq: entity work.counter
    generic map (
        width => 10
    )
    port map (
        clk => clock,
        rst => cnt_rst,
        enable => '1',
        count => count
    );
  
  slew_rst <= slew_match or rst;
  
  slewfreq: entity work.counter
    generic map (
        width => 10
    )
    port map (
        clk => clock,
        rst => slew_rst,
        enable => '1',
        count => slew_count
    );

        x_clk <= slew_rst;

      process(clock) begin -- latch the dac out on x... whatever x is
        x_clk_d <= x_clk;
        if (x_clk = '0' and x_clk_d = '1') then -- on falling edge latch
          s_and_h_en <= not s_and_h_en;
           noise_1_sh <= sipo_dac_1;
          noise_2_sh <= sipo_dac_2;
        end if;
      end process;
      
      
       process(clock) begin
        if (s_and_h_en = '0') then -- on falling edge latch
          noise_1_latched <= sipo_dac_1;
          noise_2_latched <= sipo_dac_2;
        elsif s_and_h_en = '1' then
          noise_1_latched <= noise_1_sh;
          noise_2_latched <= noise_2_sh;
        end if;
       end process;

      noise_1(9 downto 6) <= noise_1_latched;
      noise_1(5 downto 0) <= (others => '0');
      noise_2(9 downto 6) <= noise_2_latched;
      noise_2(5 downto 0) <= (others => '0');

      -- needs level contorl

end Behavioral;
