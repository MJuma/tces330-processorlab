library verilog;
use verilog.vl_types.all;
entity register_file is
    generic(
        N               : integer := 16
    );
    port(
        clock           : in     vl_logic;
        ra_addr         : in     vl_logic_vector(3 downto 0);
        ra_en           : in     vl_logic;
        rb_addr         : in     vl_logic_vector(3 downto 0);
        rb_en           : in     vl_logic;
        reset           : in     vl_logic;
        w_addr          : in     vl_logic_vector(3 downto 0);
        w_data          : in     vl_logic_vector;
        w_en            : in     vl_logic;
        ra_data         : out    vl_logic_vector(15 downto 0);
        rb_data         : out    vl_logic_vector(15 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
end register_file;
