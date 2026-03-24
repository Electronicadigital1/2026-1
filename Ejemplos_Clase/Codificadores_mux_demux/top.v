module sensor_system_top(

    input  wire [3:0] sensor0,
    input  wire [3:0] sensor1,
    input  wire [3:0] sensor2,
    input  wire [3:0] sensor3,

    input  wire [1:0] sel,

    output wire [7:0] bcd_data,

    output wire enable0,
    output wire enable1,
    output wire enable2,
    output wire enable3

);

wire [3:0] mux_out;

sensor_mux mux_inst(

    .sensor0(sensor0),
    .sensor1(sensor1),
    .sensor2(sensor2),
    .sensor3(sensor3),

    .sel(sel),

    .data_out(mux_out)

);

bin_to_bcd bcd_inst(

    .bin(mux_out),
    .bcd(bcd_data)

);

sensor_demux demux_inst(

    .sel(sel),

    .enable0(enable0),
    .enable1(enable1),
    .enable2(enable2),
    .enable3(enable3)

);

endmodule