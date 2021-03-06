library verilog;
use verilog.vl_types.all;
entity write_decoder is
    generic(
        N               : integer := 2
    );
    port(
        W               : in     vl_logic_vector;
        E               : in     vl_logic;
        Y               : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
end write_decoder;
