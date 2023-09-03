

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library UNISIM;
use UNISIM.vcomponents.all;

entity digital_reg_file is
  port (
    -- CPU interface
    regs_clk                : in  std_logic;
    regs_rst                : in  std_logic;
    regs_en                 : in  std_logic;
    regs_wen                : in  std_logic_vector(3 downto 0);
    regs_addr               : in  std_logic_vector(12 downto 0);
    regs_wr_data            : in  std_logic_vector(31 downto 0);
    regs_rd_data            : out std_logic_vector(31 downto 0);
    -- outptus
    -- Pinmatrix
    matrix_out_addr               : out std_logic_vector(5 downto 0);
    matrix_in_addr                : out std_logic_vector(5 downto 0);
    matrix_load                   : out std_logic;
    matrix_latch                  : out std_logic;
    matrix_cs                     : out std_logic_vector(3 downto 0);
    
    -- debug
    debug                   : out std_logic_vector(127 downto 0)
    );
end entity digital_reg_file;

architecture RTL of digital_reg_file is

  type regs32 is array (natural range <>) of std_logic_vector(31 downto 0);
  signal regs                           : regs32(31 downto 0)
    := (others => (others => '0'));

  -- Function for converting byte adresses to an index
  -- into the 32 bit register array.
  function ra (
    byte_addr : std_logic_vector(7 downto 0)
  ) return natural is
    variable ret : natural;
  begin
    ret := to_integer(unsigned(byte_addr(7 downto 2)));
    return ret;
  end ra;

  signal addr_reg                    : std_logic_vector(12 downto 0);
  signal read_reg                    : std_logic_vector(31 downto 0);
  signal write_reg                   : std_logic_vector(31 downto 0);
  signal write_en                    : std_logic;
  
   signal matrix_out_addr_int               : std_logic_vector(5 downto 0);
    signal matrix_in_addr_int                : std_logic_vector(5 downto 0);
   signal  matrix_load_int                   : std_logic;
    signal matrix_latch_int                  : std_logic;
   signal matrix_cs_int                     : std_logic_vector(3 downto 0);

begin

  ---------------------------------------------------------------------------
  -- Register reads
  ---------------------------------------------------------------------------
  process(regs_clk)
  begin
    if rising_edge(regs_clk) then
      if regs_en = '0' then
        read_reg <= x"00000000";
      else
        read_reg <= regs(ra(regs_addr(7 downto 0)));
      end if;
    end if;
  end process;

  regs_rd_data <= read_reg;

  ---------------------------------------------------------------------------
  -- Register writes
  ---------------------------------------------------------------------------
  process(regs_clk)
  begin
    if rising_edge(regs_clk) then
      addr_reg   <= regs_addr;
      write_reg  <= regs_wr_data;
      write_en   <= '0';
      if (regs_en = '1' and regs_wen(0) = '1') then
        write_en   <= '1';
      end if;
    end if;
  end process;

  ---------------------------------------------------------------------------
  -- Assemble the register read array
  ---------------------------------------------------------------------------
  -- outgoing, so inputs to this block
  regs(ra(x"04")) <= x"000000" & "00" & matrix_out_addr_int; -- this is the matrix input
  regs(ra(x"08")) <= x"000000" & "00" & matrix_in_addr_int; --this is the matrix output
  regs(ra(x"0C")) <= x"000000" & "0000000" & matrix_load_int; 
  regs(ra(x"10")) <= x"000000" & "0000000" & matrix_latch_int;
  regs(ra(x"14")) <= x"000000" & "0000" & matrix_cs_int;

   regs(ra(x"60")) <= x"DEADBEEF"; -- x"0000000" & vid_4_crc_err_int & vid_3_crc_err_int & vid_2_crc_err_int & vid_1_crc_err_int;

  -- ---------------------------------------------------------------------------
  -- Write MUX
  ---------------------------------------------------------------------------
  process(regs_clk)
  begin
    if rising_edge(regs_clk) then
      if (write_en = '1') then
        case addr_reg(7 downto 0) is
        --save reg 1 for somthing like a status reg
          when  x"04" =>
            matrix_out_addr_int         <= write_reg(5 downto 0);
          when  x"08" =>
            matrix_in_addr_int         <= write_reg(5 downto 0);
          when  x"0C" =>
            matrix_load_int         <= write_reg(0);
          when  x"10" =>
            matrix_latch_int         <= write_reg(0);
          when  x"14" =>
            matrix_cs_int         <= write_reg(3 downto 0);

          when others  =>
            -- do nothing
        end case;
      end if;
    end if;
  end process;

  ---------------------------------------------------------------------------
  -- Output signals
  ---------------------------------------------------------------------------
    matrix_out_addr <=  matrix_out_addr_int;             
   matrix_in_addr <=  matrix_in_addr_int;            
   matrix_load <=  matrix_load_int    ;         
  matrix_latch <=  matrix_latch_int    ;        
  matrix_cs <= matrix_cs_int         ;         


end RTL;

