library verilog;
use verilog.vl_types.all;
entity alu is
    generic(
        IN_BITS         : integer := 16;
        OUT_BITS        : integer := 16
    );
    port(
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector;
        \select\        : in     vl_logic_vector(2 downto 0);
        q               : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of IN_BITS : constant is 1;
    attribute mti_svvh_generic_type of OUT_BITS : constant is 1;
end alu;
