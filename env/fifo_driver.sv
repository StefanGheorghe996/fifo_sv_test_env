package fifo_driver;

import fifo_base_unit::*;
import fifo_packet::*;

class fifo_driver extends fifo_base_unit;
virtual fifo_if vif;
mailbox mbx;

    function new(virtual fifo_if vif, mailbox mbx , string name, int id);
        super.new(name,id);
        this.vif = vif;
        this.mbx = mbx;
    endfunction //new()

    task run();        
        fifo_packet pkt;
        @(negedge vif.reset_b);
        while (mbx.num() != 0) 
        begin
            mbx.get(pkt);
            pkt.display("Driver-");
            if(pkt.op.name == "READ")
            begin
                @(posedge vif.clk);
                vif.read <= 'b1;
                vif.write <= 'b0;
                vif.data_in <= pkt.data;
                @(posedge vif.clk);
            end
            else 
            begin
                @(posedge vif.clk);
                vif.read <= 'b0;
                vif.write <= 'b1;
                vif.data_in <= pkt.data;
                @(posedge vif.clk);
            end
        end
    endtask
endclass //fifo_driver extends fifo_base_unit
endpackage