interface fifo_if(input bit clk,input reset_b);

logic            write;
logic   [8:0]    data_in;
logic            read;
wire   [8:0]    data_out;
wire  	        dav;
wire  	        full;

clocking testbench_cb @(posedge clk);
  default input #1 output #1;
  output  write;
  output  read;
  output  data_in;
  input   dav;
  input   full;
endclocking


clocking dut_cb @(posedge clk);
  default input #1 output #1;
  input   write;
  input   read;
  input   data_in;
  output  data_out;
  output  dav;
  output  full;
endclocking

clocking monitor_cb @(posedge clk);
    input reset_b;
    input write;
    input data_in;
    input read;
    input data_out;
    input dav;
    input full;
endclocking

modport TB(clocking testbench_cb, input reset_b);
modport DUT(clocking dut_cb, input reset_b);
modport MONITOR(clocking monitor_cb, input reset_b);

endinterface //fifo_if
