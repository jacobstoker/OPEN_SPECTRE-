-- test bench for 53-bit wide, 57-word deep RAM

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ram_tb is
end entity;

architecture behavioral of ram_tb is
    -- test clock signal
    signal clk: std_logic := '0';

    -- test write enable signal
    signal we: std_logic := '0';

    -- test address input
    signal addr: std_logic_vector(5 downto 0) := (others => '0');

    -- test data input
    signal din: std_logic_vector(52 downto 0) := (others => '0');

    -- test data output
    signal dout: std_logic_vector(52 downto 0);

    -- instantiate the RAM
    component ram is
        port (
            clk: in std_logic;                 -- clock signal
            we: in std_logic;                  -- write enable signal
            addr: in std_logic_vector(5 downto 0);  -- address input
            din: in std_logic_vector(52 downto 0);  -- data input
            dout: out std_logic_vector(52 downto 0)  -- data output
        );
    end component;

begin
    -- instantiate the RAM
    UUT: ram
        port map (
            clk => clk,
            we => we,
            addr => addr,
            din => din,
            dout => dout
        );

    -- test stimulus process
    stim_proc: process
    begin
        -- set the input signals and wait for the output to be stable
        clk <= '0';
        we <= '0';
        addr <= "000000";
        din <= (others => '0');
        wait for 10 ns;

        -- set the input signals and wait for the output to be stable
        clk <= '1';
        we <= '1';
        addr <= "000000";
        din <= "0000000000000000000000000000000000000000000100000000000000000000";
        wait for 10 ns;

        -- set the input signals and wait for the output to be stable
        clk <= '0';
        we <= '0';
        addr <= "000000";
        din <= (others => '0');
        wait for 10 ns;

        -- set the input signals and wait for the output to be stable
        clk <= '1';
        we <= '0';
        addr <= "000000";
        din <= (others => '0');
        wait for 10 ns;

        -- set the input signals and wait for the output to be stable
        clk <= '0';
        we <= '0';
        addr <= "000000";
       
--finish!!!
