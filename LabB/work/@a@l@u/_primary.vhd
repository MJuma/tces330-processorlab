library verilog;
use verilog.vl_types.all;
entity ALU is
    generic(
        N               : integer := 16
    );
    port(
        A               : in     vl_logic_vector;
        B               : in     vl_logic_vector;
        S               : in     vl_logic_vector(2 downto 0);
        Q               : out    vl_logic_vector(15 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
end ALU;
