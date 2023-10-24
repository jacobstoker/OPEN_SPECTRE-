library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use STD.TEXTIO.ALL;

library work;
use work.ALL;
use work.oscillator_pkg.all;

ENTITY oscillator_tb IS
END oscillator_tb;

ARCHITECTURE behavior OF oscillator_tb IS

	 ------------------------------------------------
	 -- TEXTIO STUFF
	 constant C_FILE_NAME : string := "DataOut.txt";
	 file fptr: text;
	 signal eof : std_logic := '0';
	 signal stop : std_logic := '0';
	 ------------------------------------------------

    component oscillator
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
    end component oscillator;

    --Inputs
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';

    --Outputs
    signal sin_output : std_logic_vector(OSC_AMPLITUDE_WIDTH-1 downto 0);
    signal sq_output  : std_logic;
    
    --40Mhz clock
    constant clk_period : time := 25 ns;

begin

	-- Instantiate the Unit Under Test (UUT)
    uut: oscillator 
        port map(
            clk        => clk,
            rst        => reset,
            sync_a     => '0',
            sync_b     => '0',
            sync_sel   => (others => '0'),
            freq       => (others => '0'),
            amp        => (others => '0'),
            deviation  => (others => '0'),
            sin_output => sin_output,
            sq_output  => sq_output
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;


   -- Stimulus process
   stim_proc: process
   begin
      -- hold reset state for 100 ns.
      wait for 100 ns;
      reset <= '1';
      wait for clk_period;
      reset <= '0';
      wait for 3 ms;
      stop <= '1'; -- get the file to stop writing
      wait;
   end process;


	WriteData_proc: process
		variable fstatus : file_open_status;
		variable file_line : line;
		variable var_data1 : std_logic_vector(OSC_AMPLITUDE_WIDTH-1 downto 0);
	begin
		var_data1 := (others => '0');
		eof <= '0';

		wait until reset = '0';

		file_open(fstatus, fptr, C_FILE_NAME, write_mode);

		while (stop = '0') loop
			wait until clk = '1';
			var_data1 := sin_output;
			write(file_line, var_data1, left, OSC_AMPLITUDE_WIDTH);
			writeline(fptr, file_line);
		end loop;

		wait until rising_edge(clk);
		eof <= '1';
		file_close(fptr);
		wait;
	end process;

end;
