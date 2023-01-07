-- test bench for n-bit comparator

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity comparator_tb is
end entity;

architecture behavioral of comparator_tb is
    -- instantiate the comparator
    component comparator is
        generic (
            width: integer := 8  -- width of the operands
        );
        port (
            a: in std_logic_vector(width-1 downto 0);  -- first operand
            b: in std_logic_vector(width-1 downto 0);  -- second operand
            equal: out std_logic;  -- '1' if a = b, '0' otherwise
            greater: out std_logic  -- '1' if a > b, '0' otherwise
        );
    end component;

    -- test input signals
    signal a: std_logic_vector(7 downto 0);
    signal b: std_logic_vector(7 downto 0);

    -- test output signals
    signal equal: std_logic;
    signal greater: std_logic;

begin
    -- instantiate the comparator
    UUT: comparator
        generic map (
            width => 8
        )
        port map (
            a => a,
            b => b,
            equal => equal,
            greater => greater
        );

    -- test stimulus process
    stim_proc: process
    begin
        -- set the inputs and wait for the output to be stable
        a <= "00000000";
        b <= "00000000";
        wait for 10 ns;

        a <= "00000000";
        b <= "00000001";
        wait for 10 ns;

        a <= "00000001";
        b <= "00000000";
        wait for 10 ns;

        a <= "00000001";
        b <= "00000001";
        wait for 10 ns;

        -- end the test
        wait;
    end process;
end architecture;
