module bin_to_bcd(

    input  wire [3:0] bin,
    output reg  [7:0] bcd

);

always @(*) begin

    case(bin)

        4'd0:  bcd = 8'b0000_0000;
        4'd1:  bcd = 8'b0000_0001;
        4'd2:  bcd = 8'b0000_0010;
        4'd3:  bcd = 8'b0000_0011;
        4'd4:  bcd = 8'b0000_0100;
        4'd5:  bcd = 8'b0000_0101;
        4'd6:  bcd = 8'b0000_0110;
        4'd7:  bcd = 8'b0000_0111;
        4'd8:  bcd = 8'b0000_1000;
        4'd9:  bcd = 8'b0000_1001;

        4'd10: bcd = 8'b0001_0000;
        4'd11: bcd = 8'b0001_0001;
        4'd12: bcd = 8'b0001_0010;
        4'd13: bcd = 8'b0001_0011;
        4'd14: bcd = 8'b0001_0100;
        4'd15: bcd = 8'b0001_0101;

        default: bcd = 8'b0000_0000;

    endcase

end

endmodule