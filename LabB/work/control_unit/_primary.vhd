library verilog;
use verilog.vl_types.all;
entity control_unit is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        alu_s0          : out    vl_logic_vector(2 downto 0);
        d_addr          : out    vl_logic_vector(7 downto 0);
        d_wr            : out    vl_logic;
        ir_instruction  : out    vl_logic_vector(15 downto 0);
        pc_address      : out    vl_logic_vector(4 downto 0);
        rf_ra_addr      : out    vl_logic_vector(3 downto 0);
        rf_ra_rd        : out    vl_logic;
        rf_rb_addr      : out    vl_logic_vector(3 downto 0);
        rf_rb_rd        : out    vl_logic;
        rf_s            : out    vl_logic;
        rf_w_addr       : out    vl_logic_vector(3 downto 0);
        rf_w_wr         : out    vl_logic;
        state_o         : out    vl_logic_vector(3 downto 0)
    );
end control_unit;
