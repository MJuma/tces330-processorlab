library verilog;
use verilog.vl_types.all;
entity Datapath is
    port(
        Clock           : in     vl_logic;
        Reset           : in     vl_logic;
        D_addr          : in     vl_logic_vector(7 downto 0);
        D_wr            : in     vl_logic;
        RF_s            : in     vl_logic;
        RF_W_addr       : in     vl_logic_vector(3 downto 0);
        RF_W_wr         : in     vl_logic;
        RF_Ra_addr      : in     vl_logic_vector(3 downto 0);
        RF_Ra_rd        : in     vl_logic;
        RF_Rb_addr      : in     vl_logic_vector(3 downto 0);
        RF_Rb_rd        : in     vl_logic;
        Alu_s0          : in     vl_logic_vector(2 downto 0);
        alu_a           : out    vl_logic_vector(15 downto 0);
        alu_b           : out    vl_logic_vector(15 downto 0);
        alu_out         : out    vl_logic_vector(15 downto 0);
        rq0             : out    vl_logic_vector(15 downto 0);
        mux_out         : out    vl_logic_vector(15 downto 0)
    );
end Datapath;
