library verilog;
use verilog.vl_types.all;
entity program_counter is
    port(
        clock           : in     vl_logic;
        clear           : in     vl_logic;
        up              : in     vl_logic;
        address         : out    vl_logic_vector(4 downto 0)
    );
end program_counter;
