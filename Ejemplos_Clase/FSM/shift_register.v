module shift_register #(
    parameter N = 8
)(
    input clk,
    input rst,
    input enable,
    input serial_in,
    output reg [N-1:0] data
);

always @(posedge clk) begin
    if(rst)
        data <= 0;

    else if(enable)
        data <= {data[N-2:0], serial_in};

end

endmodule