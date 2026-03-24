module sensor_demux(

    input  wire [1:0] sel,

    output reg enable0,
    output reg enable1,
    output reg enable2,
    output reg enable3

);

always @(*) begin

    enable0 = 1'b0;
    enable1 = 1'b0;
    enable2 = 1'b0;
    enable3 = 1'b0;

    case(sel)

        2'b00: enable0 = 1'b1;
        2'b01: enable1 = 1'b1;
        2'b10: enable2 = 1'b1;
        2'b11: enable3 = 1'b1;

    endcase

end

endmodule