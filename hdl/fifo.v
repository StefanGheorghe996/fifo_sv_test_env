module fifo(clk, reset_b, write, data_in, read, data_out, dav, full);
   input       clk;
   input       reset_b;
   
   input       write;
   input [8:0] data_in;
   input       read;

   output [8:0] data_out;
   output 	dav;
   output 	full;
   
   wire 	s0; //partial needed to compute full/empty
   wire 	s1; //partial needed to compute full/empty
   wire [8:0] 	data_out_w;
   
   reg [4:0] 	w_p_r; //write pointer
   reg [4:0] 	r_p_r; //read pointer

   reg 		read_r; //"read" buffered one cycle

   wire 	n_empty; //not empty
   wire 	n_full;  //not full

   wire 	inc_write; //increment the write pointer
   wire 	inc_read;  //increment the read pointer

   memory mem(
	      .clk (clk),
	      .write_addr(w_p_r[3:0]),
	      .data_in(data_in),
	      .we(n_full),
	      .read_addr(r_p_r[3:0]),
	      .data_out (data_out_w),
	      .re(n_empty)
	      );
   assign 	data_out[7:0] = read_r ? data_out_w[7:0] : 8'bz;
   assign 	data_out[8] = data_out_w[8];
   
   assign 	s0 = (w_p_r[3:0] == r_p_r[3:0]);
   assign 	s1 = (w_p_r[4] ^ r_p_r[4]);
   
   assign 	n_empty = ~(s0 & ~s1);
   assign 	full = (s0 & s1);	
   assign 	n_full = ~full;
   
   assign 	inc_write = n_full & write;
   assign 	inc_read = n_empty & read_r;

   assign 	dav = n_empty;
   
   //writing thread
   always @(posedge clk or negedge reset_b)
     begin
	if (reset_b == 0) 
	  w_p_r <= 5'b0;
	else
	  w_p_r <= inc_write ? w_p_r + 1 : w_p_r;
     end

   //reading thread
   always @(posedge clk or negedge reset_b)
     begin
	if (reset_b == 0) 
	  r_p_r <= 5'b0;
	else
	  r_p_r <= inc_read ? r_p_r + 1 : r_p_r;
     end

   //delay thread
   always @(posedge clk or negedge reset_b)
     begin
	if (reset_b == 0)
	  begin
	     read_r <= 0;
	  end
	else
	  begin
	     read_r <= read;
	  end
     end
endmodule // fifo
