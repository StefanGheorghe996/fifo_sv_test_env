class fifo_environment extends fifo_base_unit;
    int number_of_packets;

    function new(int unsigned number_of_packets,string name, int id);
        super.new(name,id);
        this.number_of_packets = number_of_packets;
    endfunction //new()

    task run();
  
      repeat(this.number_of_packets) begin
         fifo_packet pkt;
         pkt = new();
         pkt.randomize();
         pkt.display();
      end
   endtask: run

endclass //fifo_environment extends fifo_base_unit