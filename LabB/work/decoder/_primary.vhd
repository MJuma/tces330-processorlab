library verilog;
use verilog.vl_types.all;
entity decoder is
    generic(
        N               : integer := 2
    );
    port(
        w               : in     vl_logic_vector;
        e               : in     vl_logic;
        y               : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
end decoder;
