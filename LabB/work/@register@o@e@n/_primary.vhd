library verilog;
use verilog.vl_types.all;
entity RegisterOEN is
    generic(
        M               : integer := 16
    );
    port(
        I               : in     vl_logic_vector;
        Ld              : in     vl_logic;
        Oea             : in     vl_logic;
        Oeb             : in     vl_logic;
        Clk             : in     vl_logic;
        Rst             : in     vl_logic;
        Qa              : out    vl_logic_vector(15 downto 0);
        Qb              : out    vl_logic_vector(15 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of M : constant is 1;
end RegisterOEN;
