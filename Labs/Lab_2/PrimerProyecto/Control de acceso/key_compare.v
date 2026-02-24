module key_compare(
    input [3:0] KEY,
    output MATCH
);

wire n2, n0;

not (n2, KEY[2]);
not (n0, KEY[0]);

and (MATCH, KEY[3], n2, KEY[1], n0);

endmodule