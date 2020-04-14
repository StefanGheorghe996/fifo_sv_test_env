module memory(clk,data_in,write_addr,we,data_out,read_addr,re);
   input clk;
   
   input [3:0] write_addr;
   input [8:0] data_in;
   input       we;
   
   input [3:0] read_addr;   
   output [8:0] data_out;
   input 	re;
   
   reg [8:0]   mem [15:0];

   assign data_out = re ? mem[read_addr] : 9'bz;
   always @(posedge clk)
     mem[write_addr] <= we ? data_in : mem[write_addr]; // an "else" might be required for better sinthesis   
endmodule // memory
