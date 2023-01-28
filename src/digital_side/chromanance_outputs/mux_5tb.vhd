library ieee;
use ieee.std_logic_1164.all;

entity mux_5tb is
end mux_5tb;

architecture behavior of mux_5tb is

signal sel: std_logic;
signal a: std_logic_vector(5 downto 0);
signal b: std_logic_vector(5 downto 0);
signal c: std_logic_vector(5 downto 0);

begin

DUT: entity work.mux_5 port map (sel=>sel, a=>a, b=>b, c=>c);

stim_proc: process 
begin
    -- Initialize inputs
    sel <= '0';
    a <= "000000";
    b <= "111111";
    
    -- Wait for 100 ns
    wait for 100 ns;
    
    -- Add assert statement
    assert c = "000000" report "Error: Output not as expected" severity error;
    
    -- Change inputs
    sel <= '1';
    a <= "101010";
    b <= "010101";
    
    -- Wait for 100 ns
    wait for 100 ns;
    
    -- Add assert statement
    assert c = "010101" report "Error: Output not as expected" severity error;
    
    -- Change inputs
    sel <= '0';
    a <= "111000";
    b <= "000111";
    
    -- Wait for 100 ns
    wait for 100 ns;
    
    -- Add assert statement
    assert c = "111000" report "Error: Output not as expected" severity error;
    
    -- Stop the simulation
    wait;
end process;

end behavior;
