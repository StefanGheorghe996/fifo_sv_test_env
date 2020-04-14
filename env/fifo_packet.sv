package fifo_packet;
typedef enum {READ ,WRITE} operation;

class fifo_packet;


    rand bit[7:0] data;
    rand operation op;

    function display(string prefix);
      $display("[%0t] %s packet payload is %d operation is %0s ", $time,prefix,this.data,this.op.name());
    endfunction : display

endclass //fifo_packet
endpackage