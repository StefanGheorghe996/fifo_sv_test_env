program test;
    fifo_environment env;
    initial begin
        env = new(15,"Environment",25);
        env.run();
    end
endprogram