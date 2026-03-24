module sensor_mux(

    input  wire [3:0] sensor0,
    input  wire [3:0] sensor1,
    input  wire [3:0] sensor2,
    input  wire [3:0] sensor3,

    input  wire [1:0] sel,

    output reg  [3:0] data_out

);
always @(*) begin

    case(sel)

        2'b00: data_out = sensor0;
        2'b01: data_out = sensor1;
        2'b10: data_out = sensor2;
        2'b11: data_out = sensor3;

        default: data_out = 4'b0000;

    endcase

end

endmodule