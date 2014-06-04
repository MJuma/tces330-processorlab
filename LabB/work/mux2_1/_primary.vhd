library verilog;
use verilog.vl_types.all;
entity mux2_1 is
    generic(
        N               : integer := 2
    );
    port(
        x               : in     vl_logic_vector;
        y               : in     vl_logic_vector;
        s               : in     vl_logic;
        f               : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
end mux2_1;
