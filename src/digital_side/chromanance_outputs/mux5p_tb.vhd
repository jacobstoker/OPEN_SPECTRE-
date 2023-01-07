library ieee;
use ieee.std_logic_1164.all;

entity mux5p_tb is
end mux5p_tb;

architecture beh of mux5p_tb is
    signal sel: std_logic;
    signal a: std_logic_vector(5 downto 0);
    signal b: std_logic_vector(5 downto 0);
    signal c: std_logic_vector(5 downto 0);
begin
    -- Instantiate the multiplexer
    dut: entity work.mux5p port map (sel=sel, a=a, b=b, c=c);

    -- Test case for when sel is '0'
    sel <= '0';
    a <= "000000";
    b <= "111111";
    wait for 10 ns;
    assert c = "000000" report "Error: unexpected output when sel='0'" severity error;

    -- Test case for when sel is '1'
    sel <= '1';
    a <= "101010";
    b <= "010101";
    wait for 10 ns;
    assert c = "010101" report "Error: unexpected output when sel='1'" severity error;

end beh;
