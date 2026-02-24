module enable_control(
    input MATCH,
    input ENABLE,
    output OPEN
);

and (OPEN, MATCH, ENABLE);

endmodule