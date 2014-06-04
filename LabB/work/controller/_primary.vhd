library verilog;
use verilog.vl_types.all;
entity controller is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        instruction     : in     vl_logic_vector(15 downto 0);
        alu_s0          : out    vl_logic_vector(2 downto 0);
        ld              : out    vl_logic;
        d_addr          : out    vl_logic_vector(7 downto 0);
        d_wr            : out    vl_logic;
        pc_clr          : out    vl_logic;
        pc_up           : out    vl_logic;
        rf_ra_addr      : out    vl_logic_vector(3 downto 0);
        rf_ra_rd        : out    vl_logic;
        rf_rb_addr      : out    vl_logic_vector(3 downto 0);
        rf_rb_rd        : out    vl_logic;
        rf_s            : out    vl_logic;
        rf_w_addr       : out    vl_logic_vector(3 downto 0);
        rf_w_wr         : out    vl_logic;
        state_o         : out    vl_logic_vector(3 downto 0)
    );
end controller;
