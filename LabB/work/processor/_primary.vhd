library verilog;
use verilog.vl_types.all;
entity processor is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        state_o         : out    vl_logic_vector(3 downto 0);
        pc_address      : out    vl_logic_vector(4 downto 0);
        ir_instruction  : out    vl_logic_vector(15 downto 0);
        alu_a           : out    vl_logic_vector(15 downto 0);
        alu_b           : out    vl_logic_vector(15 downto 0);
        alu_out         : out    vl_logic_vector(15 downto 0);
        rq0             : out    vl_logic_vector(15 downto 0);
        mux_out         : out    vl_logic_vector(15 downto 0);
        rf_w_addr_out   : out    vl_logic_vector(3 downto 0);
        rf_ra_addr_out  : out    vl_logic_vector(3 downto 0);
        rf_rb_addr_out  : out    vl_logic_vector(3 downto 0)
    );
end processor;
