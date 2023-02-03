

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity monstable_4 is
  Port ( 
        input  : in std_logic;
        clk  : in std_logic;
        output : out STD_LOGIC_VECTOR (3 downto 0)
  );
end monstable_4;

architecture Behavioral of monstable_4 is
signal ed_o0, ed_o1, ed_o2, ed_o3 : std_logic;

begin
    ed_1: entity work.edge_detector
        port map (
            x => input,
            clk => clk,
            rising_edge_O => ed_o0
        );
     ed_2: entity work.edge_detector
        port map (
            x => input,
            clk => clk,
            rising_edge_O => ed_o1
        );
     ed_3: entity work.edge_detector
        port map (
            x => input,
            clk => clk,
            rising_edge_O => ed_o2
        );
     ed_4: entity work.edge_detector
        port map (
            x => input,
            clk => clk,
            rising_edge_O => ed_o3
        );
        
        output(0) <= (not input) nand ed_o0;
        output(1) <= (input) nand ed_o1;
        output(2) <= (not input) nand ed_o2;
        output(3) <= (input) nand ed_o3;

end Behavioral;
