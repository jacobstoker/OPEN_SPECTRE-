library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.oscillator_pkg.all;

entity oscillator is
    generic (
        PHASE_ACCUMULATOR_WIDTH : integer := 29;
        FREQ_CTRL_WORD_WIDTH    : integer := 20;
        AMPLITUDE_WIDTH         : integer := 10
    );
	port (
        clk        : in  std_logic;
        rst        : in  std_logic;
        sync_a     : in  std_logic;
        sync_b     : in  std_logic;
        sync_sel   : in  std_logic_vector(1 downto 0);  -- 00 = no sync, 01 = sync_a, 10 = sync_b
        freq       : in  std_logic_vector(31 downto 0); -- Q16.16 Value in Hz?
        amp        : in  std_logic_vector(31 downto 0);
        deviation  : in  std_logic_vector(31 downto 0);
        sin_output : out std_logic_vector(AMPLITUDE_WIDTH-1 downto 0);
        sq_output  : out std_logic
    );
end entity oscillator;

architecture Behavioral of oscillator is

component sin_LUT is
    generic (
        IDX_WIDTH    : integer := 6;
        OUTPUT_WIDTH : integer := 9
    );
    port (
        index  : in  std_logic_vector(IDX_WIDTH-1 downto 0);
        output : out std_logic_vector(OUTPUT_WIDTH-1 downto 0)
    );
end component;

signal freq_ctrl_word : unsigned(FREQ_CTRL_WORD_WIDTH-1 downto 0);
signal phase_accum    : unsigned(PHASE_ACCUMULATOR_WIDTH-1 downto 0);
signal index : std_logic_vector(10-1 downto 0);
constant SQ_THRESHOLD : integer := PHASE_ACCUMULATOR_WIDTH / 2;

begin

-- FCW for 50Hz
freq_ctrl_word <= "00000000001010011111"; --left_shift(freq, PHASE_ACCUMULATOR_WIDTH) / 50_000_000;

phase_accum_proc : process(clk, rst)
begin
	if (rst = '1') then
		phase_accum <= (others => '0');
	elsif rising_edge(clk) then
        if (sync_sel = "01" and sync_a = '1') or (sync_sel = "10" and sync_b = '1') then
            phase_accum <= (others => '0');
        else
		    phase_accum <= phase_accum + freq_ctrl_word;
        end if;
	end if;
end process phase_accum_proc;

index <= std_logic_vector(phase_accum(PHASE_ACCUMULATOR_WIDTH-1 downto PHASE_ACCUMULATOR_WIDTH-OSC_INDEX_WIDTH));

sin_lut_1: entity work.sin_LUT
    generic map (
        IDX_WIDTH    => OSC_INDEX_WIDTH,
        OUTPUT_WIDTH => AMPLITUDE_WIDTH
    )
    port map(
        index  => index,
        output => sin_output
    );

-- TODO: not fully thought out or tested yet
sq_output <= '1' when to_integer(phase_accum) >= sq_threshold else
             '0';

end Behavioral;
