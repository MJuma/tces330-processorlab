library verilog;
use verilog.vl_types.all;
entity instruction_register is
    port(
        clock           : in     vl_logic;
        clear           : in     vl_logic;
        data            : in     vl_logic_vector(15 downto 0);
        ld              : in     vl_logic;
        instruction     : out    vl_logic_vector(15 downto 0)
    );
end instruction_register;
