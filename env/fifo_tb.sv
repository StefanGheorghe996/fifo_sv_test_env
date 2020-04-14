module fifo_tb;

import fifo_generator::*;
import fifo_driver::*;
import fifo_packet::*;


wire clk;
wire reset;

fifo_generator  generator;
fifo_driver     driver;
fifo_if         intf (clk,reset_b);
mailbox         #(fifo_packet) m_box;



//m_box = new(); //creating mailbox

fifo DUT(
  .clk      (intf.clk)          ,
  .reset_b  (intf.DUT.reset_b)  ,
  .write    (intf.DUT.write)    ,
  .data_in  (intf.DUT.data_in)  ,
  .read     (intf.DUT.read)     ,
  .data_out (intf.DUT.data_out) ,
	.dav      (intf.DUT.dav)      ,
	.full     (intf.DUT.full)   
);

clock_rst_gen CLK_RST_GEN(
  .clk    (clk),
  .reset  (reset_b)
);

initial begin

  m_box= new(); //declaring mailbox m_box
  generator = new(m_box,20,"Generator",1); //creating generator and passing mailbox handle
  driver = new(intf.TB,m_box,"Driver",2); //creating driver and passing mailbox handle

  fork
  generator.run(); //Process-1
  driver.run(); //Process-2
  join
  
  
end




endmodule