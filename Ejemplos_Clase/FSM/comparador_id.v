module comparador_id #(
    parameter N = 8,
    parameter PASSWORD = 8'b10110011
)(
    input [N-1:0] data,
    output id_correcto
);

assign id_correcto = (data == PASSWORD);

endmodule