library verilog;
use verilog.vl_types.all;
entity register_dual_oe is
    generic(
        N               : integer := 16
    );
    port(
        clock           : in     vl_logic;
        ld              : in     vl_logic;
        input_data      : in     vl_logic_vector;
        oea             : in     vl_logic;
        oeb             : in     vl_logic;
        reset           : in     vl_logic;
        qa              : out    vl_logic_vector;
        qb              : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
end register_dual_oe;
