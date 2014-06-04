library verilog;
use verilog.vl_types.all;
entity Mux2_1 is
    generic(
        N               : integer := 2
    );
    port(
        X               : in     vl_logic_vector;
        Y               : in     vl_logic_vector;
        S               : in     vl_logic;
        F               : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
end Mux2_1;
