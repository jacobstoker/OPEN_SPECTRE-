library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_Std.ALL;

entity tb_test_digital_side is
end tb_test_digital_side;

architecture behavior of tb_test_digital_side is
    component test_digital_side is
        port ( 
            sys_clk: in std_logic;
            clk_25_in: in std_logic;
            rst: in std_logic;
            RBG_out: out std_logic_vector(23 downto 0);
            mux_selB_i: in std_logic_vector(16 downto 0);
            mux_selC_i: in std_logic_vector(16 downto 0);
            mux_selD_i: in std_logic_vector(31 downto 0);
            mux_selE_i: in std_logic_vector(31 downto 0);
            chrom_swap_i: in std_logic
        );
    end component;

    signal sys_clk: std_logic := '0';
    signal clk_25_in: std_logic := '0';
    signal rst: std_logic := '0';
    signal RBG_out: std_logic_vector(23 downto 0);
    signal mux_selB_i: std_logic_vector(16 downto 0);
    signal mux_selC_i: std_logic_vector(16 downto 0);
    signal mux_selD_i: std_logic_vector(31 downto 0);
    signal mux_selE_i: std_logic_vector(31 downto 0);
    signal chrom_swap_i: std_logic := '0';

begin
    DUT: test_digital_side
        port map (
            sys_clk => sys_clk,
            clk_25_in => clk_25_in,
            rst => rst,
            RBG_out => RBG_out,
            mux_selB_i => mux_selB_i,
            mux_selC_i => mux_selC_i,
            mux_selD_i => mux_selD_i,
            mux_selE_i => mux_selE_i,
            chrom_swap_i => chrom_swap_i
        );

    clk_process: process
    begin
        sys_clk <= '0';
        clk_25_in <= '0';
        wait for 10 ns;
        sys_clk <= '1';
        clk_25_in <= '1';
        wait for 10 ns;
    end process clk_process;

    simulation: process
    begin
        -- Reset
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        mux_selB_i <= std_logic_vector(to_unsigned(16, 4));
        mux_selC_i <= std_logic_vector(to_unsigned(15, 17));
        mux_selD_i <= std_logic_vector(to_unsigned(16, 32));
        mux_selE_i <= std_logic_vector(to_unsigned(1, 32));
        

        -- Test case 1
        chrom_swap_i <= '0';
        wait for 200 ns;

--        -- Test case 2
--        chrom_swap_i <= '1';
--        wait for 200 ns;

        -- End simulation
        wait for 10 ns;
        assert false report "End of simulation" severity failure;
        wait;
    end process simulation;

end behavior;
