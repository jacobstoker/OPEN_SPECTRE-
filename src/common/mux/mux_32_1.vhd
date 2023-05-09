library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mux_32_1 is
    Port (
        sel : in  std_logic_vector(4 downto 0);
        din : in  std_logic_vector(31 downto 0);
        dout : out std_logic_vector(31 downto 0)
    );
end mux_32_1;

architecture Behavioral of mux_32_1 is
begin

    process(sel, din)
    begin
        case sel is
            when "00000" =>
                dout <= din(31 downto 0);
            when "00001" =>
                dout <= din(63 downto 32);
            when "00010" =>
                dout <= din(95 downto 64);
            when "00011" =>
                dout <= din(127 downto 96);
            when "00100" =>
                dout <= din(159 downto 128);
            when "00101" =>
                dout <= din(191 downto 160);
            when "00110" =>
                dout <= din(223 downto 192);
            when "00111" =>
                dout <= din(255 downto 224);
            when "01000" =>
                dout <= din(287 downto 256);
            when "01001" =>
                dout <= din(319 downto 288);
            -- add more cases for remaining inputs
            when others =>
                dout <= (others => 'X'); -- default case
        end case;
    end process;

end Behavioral;
