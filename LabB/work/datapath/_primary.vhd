library verilog;
use verilog.vl_types.all;
entity datapath is
    port(
        clock           : in     vl_logic;
        d_addr          : in     vl_logic_vector(7 downto 0);
        d_wr            : in     vl_logic;
        reset           : in     vl_logic;
        rf_ra_addr      : in     vl_logic_vector(3 downto 0);
        rf_ra_rd        : in     vl_logic;
        rf_rb_addr      : in     vl_logic_vector(3 downto 0);
        rf_rb_rd        : in     vl_logic;
        rf_s            : in     vl_logic;
        rf_w_addr       : in     vl_logic_vector(3 downto 0);
        rf_w_wr         : in     vl_logic;
        alu_s0          : in     vl_logic_vector(2 downto 0);
        alu_a           : out    vl_logic_vector(15 downto 0);
        alu_b           : out    vl_logic_vector(15 downto 0);
        alu_out         : out    vl_logic_vector(15 downto 0);
        mux_out         : out    vl_logic_vector(15 downto 0);
        rq0             : out    vl_logic_vector(15 downto 0)
    );
end datapath;
