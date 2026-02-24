module top(
    input [3:0] KEY,
    input ENABLE,
    output OPEN
);

wire match_signal;

key_compare U1(
    .KEY(KEY),
    .MATCH(match_signal)
);
enable_control U2(
    .MATCH(match_signal),
    .ENABLE(ENABLE),
    .OPEN(OPEN)
);

endmodule