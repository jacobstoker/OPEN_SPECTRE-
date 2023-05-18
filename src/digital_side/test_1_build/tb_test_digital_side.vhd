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
            chrom_swap_i: in std_logic;
            clk_x_out  : out STD_LOGIC;
            clk_y_out  : out STD_LOGIC
        );
    end component;
    
    component write_file_ex is
       port (
            clk    : in  std_logic;   
            hs    : in  std_logic;   
            vs    : in  std_logic;   
            r    : in  std_logic_vector(7 downto 0);  
            g    : in  std_logic_vector(7 downto 0);   
            b    : in  std_logic_vector(7 downto 0)   
    
        );
    end component;

    signal sys_clk: std_logic := '0';
    signal clk_25_in: std_logic := '0';
    signal rst: std_logic := '0';
    signal RBG_out: std_logic_vector(23 downto 0);
    signal RBG: std_logic_vector(23 downto 0);
    signal mux_selB_i: std_logic_vector(16 downto 0);
    signal mux_selC_i: std_logic_vector(16 downto 0);
    signal mux_selD_i: std_logic_vector(31 downto 0);
    signal mux_selE_i: std_logic_vector(31 downto 0);
    signal chrom_swap_i: std_logic := '0';
    signal clk_x_out: std_logic := '0';
    signal clk_Y_out: std_logic := '0';
    

begin
    RBG<= RBG_out;

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
            chrom_swap_i => chrom_swap_i,
            clk_x_out => clk_x_out,
            clk_Y_out => clk_Y_out
        );
        
        -- logging
    logger : write_file_ex
        port map (
            clk  => clk_25_in,
            hs   => clk_x_out,   
            vs   => clk_y_out,  
            r    => RBG(23 downto 16),--RBG(7 downto 0),
            g    => RBG(23 downto 16),--RBG(15 downto 8),
            b    => RBG(23 downto 16)--RBG(23 downto 16)
            
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
        mux_selB_i <= '0'&"0101"&"0101"&"0101"&"0011";--std_logic_vector(to_unsigned(16, 17));
        mux_selC_i <= '0'&"1110"&"1110"&"1110"&"1101";--std_logic_vector(to_unsigned(15, 17));
        mux_selD_i <= std_logic_vector(to_unsigned(16, 32));
        mux_selE_i <= std_logic_vector(to_unsigned(1, 32));
        

        -- Test case 1
        chrom_swap_i <= '0';
        wait for 200 ns;

--        -- Test case 2
--        chrom_swap_i <= '1';
--        wait for 200 ns;

        -- End simulation
       -- wait for 10 ns;
      --  assert false report "End of simulation" severity failure;
        wait;
    end process simulation;
    

    

end behavior;
