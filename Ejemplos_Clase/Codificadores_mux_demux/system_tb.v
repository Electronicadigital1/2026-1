`timescale 1ns/1ps

module sensor_system_tb;

reg [3:0] sensor0;
reg [3:0] sensor1;
reg [3:0] sensor2;
reg [3:0] sensor3;

reg [1:0] sel;

wire [7:0] bcd_data;

wire enable0;
wire enable1;
wire enable2;
wire enable3;

sensor_system_top uut(

    .sensor0(sensor0),
    .sensor1(sensor1),
    .sensor2(sensor2),
    .sensor3(sensor3),

    .sel(sel),

    .bcd_data(bcd_data),

    .enable0(enable0),
    .enable1(enable1),
    .enable2(enable2),
    .enable3(enable3)

);

initial begin

    // Archivo de ondas para GTKWave
    $dumpfile("sensor_system.vcd");
    $dumpvars(0, sensor_system_tb);

end

initial begin

    $display("Inicio de simulacion");

    sensor0 = 4'd3;
    sensor1 = 4'd7;
    sensor2 = 4'd12;
    sensor3 = 4'd9;

    sel = 2'b00; #10;
    sel = 2'b01; #10;
    sel = 2'b10; #10;
    sel = 2'b11; #10;

    sensor0 = 4'd5;
    sensor1 = 4'd10;
    sensor2 = 4'd2;
    sensor3 = 4'd15;

    sel = 2'b00; #10;
    sel = 2'b01; #10;
    sel = 2'b10; #10;
    sel = 2'b11; #10;

    sensor0 = 4'd0;
    sensor1 = 4'd1;
    sensor2 = 4'd8;
    sensor3 = 4'd4;

    sel = 2'b10; #10;
    sel = 2'b01; #10;

    $display("Fin de simulacion");
    $finish;

end

endmodule