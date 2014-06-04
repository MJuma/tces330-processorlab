library verilog;
use verilog.vl_types.all;
entity read_decoder is
    generic(
        N               : integer := 2
    );
    port(
        Ra_adr          : in     vl_logic_vector;
        Rb_adr          : in     vl_logic_vector;
        Ra_ena          : in     vl_logic;
        Rb_ena          : in     vl_logic;
        Oea             : out    vl_logic_vector;
        Oeb             : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
end read_decoder;
