package fifo_generator;

import fifo_base_unit::*;
import fifo_packet::*;

class fifo_generator extends fifo_base_unit;
   int number_of_packets;
   mailbox mbx;

   function new(mailbox mbx,int unsigned number_of_packets,string name, int id);
      super.new(name,id);
      this.number_of_packets = number_of_packets;
      this.mbx = mbx;
   endfunction //new()

   task run();
   fifo_packet pkt;

   repeat(this.number_of_packets) begin
      fifo_packet pkt;
      pkt = new();
      pkt.randomize();
      pkt.display("Generator-");
      mbx.put(pkt);
      
   end
   endtask: run

endclass //fifo_environment extends fifo_base_unit
endpackage