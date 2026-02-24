module tb_top;

reg [3:0] KEY;
reg ENABLE;
wire OPEN;

top DUT(KEY, ENABLE, OPEN);

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, tb_top);
    KEY = 4'b1010; ENABLE = 1;
    #10;

    KEY = 4'b1001; ENABLE = 1;
    #10;

    KEY = 4'b1010; ENABLE = 0;
    #10;

    $finish;
end

endmodule