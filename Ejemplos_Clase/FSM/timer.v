module timer #(
    parameter MAX_COUNT = 50_000_000
)(
    input clk,
    input rst,
    input enable,
    output reg done
);

reg [31:0] counter;

always @(posedge clk) begin

    if(rst) begin
        counter <= 0;
        done <= 0;
    end

    else if(enable) begin

        if(counter == MAX_COUNT-1) begin
            counter <= 0;
            done <= 1;
        end

        else begin
            counter <= counter + 1;
            done <= 0;
        end

    end

    else begin
        counter <= 0;
        done <= 0;
    end

end

endmodule