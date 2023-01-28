library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux_1_to_8 is
    Port ( 
        data: in  std_logic;
        sel: in  std_logic_vector(2 downto 0);
        demux_out: out  std_logic_vector(7 downto 0)
    );
end demux_1_to_8;

architecture Behavioral of demux_1_to_8 is
begin
    process(sel, data)
    begin
        demux_out <= (others => '0');
        case sel is
            when "000" => demux_out(0) <= data;
            when "001" => demux_out(1) <= data;
            when "010" => demux_out(2) <= data;
            when "011" => demux_out(3) <= data;
            when "100" => demux_out(4) <= data;
            when "101" => demux_out(5) <= data;
            when "110" => demux_out(6) <= data;
            when "111" => demux_out(7) <= data;
        end case;
    end process;
end Behavioral;
