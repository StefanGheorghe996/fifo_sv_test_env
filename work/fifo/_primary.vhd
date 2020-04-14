library verilog;
use verilog.vl_types.all;
entity fifo is
    port(
        clk             : in     vl_logic;
        reset_b         : in     vl_logic;
        write           : in     vl_logic;
        data_in         : in     vl_logic_vector(8 downto 0);
        read            : in     vl_logic;
        data_out        : out    vl_logic_vector(8 downto 0);
        dav             : out    vl_logic;
        full            : out    vl_logic
    );
end fifo;
