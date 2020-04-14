package fifo_base_unit;
class fifo_base_unit;
    string name;
    int id;

    function new(string name, int id);
        this.name = name;
        this.id = id;
    endfunction //new()

    function display_name(int id);
     $display("%s",name);
   endfunction: display_name

   virtual task run;
   endtask


endclass //fifo_base_unit
endpackage