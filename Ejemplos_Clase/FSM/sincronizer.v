module synchronizer(
    input clk,
    input async_in,
    output reg sync_out
);

reg ff1;

always @(posedge clk) begin

    ff1 <= async_in;
    sync_out <= ff1;

end

endmodule