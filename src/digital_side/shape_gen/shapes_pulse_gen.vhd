library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shapes_pulse_gen is
    port (
        clk          : in  std_logic;
        rst          : in  std_logic;
        counter_in   : in  std_logic_vector(8 downto 0);
        pulse_start  : in  std_logic_vector(8 downto 0);
        pulse_len    : in  std_logic_vector(8 downto 0);
        pulse_out    : out std_logic;
        ramp_out     : out std_logic_vector(8 downto 0)
    );
end entity shapes_pulse_gen;

architecture Behavioral of shapes_pulse_gen is
    signal counter        : unsigned(8 downto 0);
    signal step_size_calc  : integer range 0 to 100; 
    signal step_size      : integer range 0 to 100; 
    signal pulse_counter  : unsigned(8 downto 0);
    signal pulse_len_int  : unsigned(8 downto 0);
    signal pulse_active   : std_logic;
    signal ramp           : unsigned(8 downto 0);

begin
    process (clk, rst)
    begin
        if rst = '1' then
            counter <= (others => '0');
            pulse_counter <= (others => '0');
            pulse_active <= '0';
            ramp <= (others => '0');
        elsif rising_edge(clk) then
            counter <= unsigned(counter_in);
            
            if pulse_active = '1' then
                if pulse_counter = unsigned(pulse_len) then
                    pulse_active <= '0';
                    pulse_counter <= (others => '0');
                    ramp <= (others => '0');
                else
                    pulse_counter <= pulse_counter + 1;
                    ramp <= ramp + step_size;
                end if;
            elsif counter = unsigned(pulse_start) then
                pulse_active <= '1';
                step_size <= step_size_calc;
                pulse_counter <= (others => '0');
                ramp <= (others => '0');
            end if;
        end if;
    end process;
    
    process (pulse_len_int)
    begin
        --put logic to look up the stepsize
        if pulse_len_int > x"4f" then --handle the large stepsized that come as puls elen increases
            if pulse_len_int > x"4f"  and pulse_len_int < x"5e" then
                step_size_calc <= 6;
            elsif pulse_len_int >= x"5e" and pulse_len_int < x"72"  then
                step_size_calc <= 5;
            elsif pulse_len_int >= x"72" and pulse_len_int < x"93"  then
                step_size_calc <= 4;
            elsif pulse_len_int >= x"93" and pulse_len_int < x"125"  then
                step_size_calc <= 3;
            elsif pulse_len_int >= x"125" and pulse_len_int < x"CD"  then
                step_size_calc <= 2;
            elsif pulse_len_int >= x"CD" then
                step_size_calc <= 1;
            else -- 'U', 'X', '-' etc.
                step_size_calc <= 0;
            end if; 
        
        end if; 
    end process;

    pulse_len_int <= unsigned(pulse_len);
    pulse_out <= pulse_active;
    ramp_out <= std_logic_vector(ramp);

end architecture Behavioral;

