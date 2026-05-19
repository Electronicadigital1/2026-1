`timescale 1ns/1ps

module tb_top_parqueadero;

//-------------------------------------------------
// Entradas
//-------------------------------------------------

reg clk;
reg rst;

reg sensor_vehiculo;
reg bit_serial;
reg dato_listo;
reg sensor_salida;

//-------------------------------------------------
// Salidas
//-------------------------------------------------

wire servo_pwm;

//-------------------------------------------------
// DUT
//-------------------------------------------------

top_parqueadero dut(
    .clk(clk),
    .rst(rst),
    .sensor_vehiculo(sensor_vehiculo),
    .bit_serial(bit_serial),
    .dato_listo(dato_listo),
    .sensor_salida(sensor_salida),
    .servo_pwm(servo_pwm)
);

//-------------------------------------------------
// Reducir timer para simulación rápida
//-------------------------------------------------

defparam dut.timer0.MAX_COUNT = 20;

//-------------------------------------------------
// Clock
//-------------------------------------------------

always #10 clk = ~clk;

//-------------------------------------------------
// Task: enviar password serial
//-------------------------------------------------

task send_password;

    input [7:0] password;

    integer i;

    begin

        $display("Enviando password...");

        for(i=7; i>0; i=i-1) begin

            bit_serial = password[i];

            $display("Bit enviado = %b", password[i]);

            #20;

        end

    end

endtask

//-------------------------------------------------
// Monitor
//-------------------------------------------------

always @(posedge clk) begin

    $display(
        "T=%0t | Estado=%b | Shift=%b | ID_OK=%b | Abrir=%b | Cerrar=%b",
        $time,
        dut.fsm0.estado_actual,
        dut.shift_enable,
        dut.id_correcto,
        dut.servo_abrir,
        dut.servo_cerrar
    );

end

//-------------------------------------------------
// Inicialización
//-------------------------------------------------

initial begin

    $dumpfile("waveform.vcd");
    $dumpvars(0, tb_top_parqueadero);

    clk = 0;
    rst = 1;

    sensor_vehiculo = 0;
    bit_serial = 0;
    dato_listo = 0;
    sensor_salida = 0;

    //-------------------------------------------------
    // RESET
    //-------------------------------------------------

    #100;
    rst = 0;

    $display("\n===== RESET LIBERADO =====");

    //-------------------------------------------------
    // CASO 1:
    // Password correcta
    //-------------------------------------------------

    $display("\n===== CASO 1: PASSWORD CORRECTA =====");

    // Vehículo llega

    #100;
    sensor_vehiculo = 1;

    #200;
    sensor_vehiculo = 0;

    // Esperar FSM -> LEER

    #100;

    // Enviar password correcta

    send_password(8'b10110011);

    // Datos listos

    dato_listo = 1;

    #40;
    dato_listo = 0;

    // Esperar apertura

    #1000;

    // Vehículo pasa

    sensor_salida = 1;

    #200;
    sensor_salida = 0;

    // Esperar cierre

    #1000;

    //-------------------------------------------------
    // CASO 2:
    // Password incorrecta
    //-------------------------------------------------

    $display("\n===== CASO 2: PASSWORD INCORRECTA =====");

    #500;

    sensor_vehiculo = 1;

    #40;
    sensor_vehiculo = 0;

    #100;

    // Password incorrecta

    send_password(8'b11111111);

    dato_listo = 1;

    #40;
    dato_listo = 0;

    // Debe regresar a IDLE

    #500;

    //-------------------------------------------------
    // CASO 3:
    // dato_listo nunca llega
    //-------------------------------------------------

    $display("\n===== CASO 3: ESPERA EN LEER =====");

    sensor_vehiculo = 1;

    #40;
    sensor_vehiculo = 0;

    // FSM debe quedarse en LEER

    #1000;

    //-------------------------------------------------
    // CASO 4:
    // sensor_salida tarda en activarse
    //-------------------------------------------------

    $display("\n===== CASO 4: ESPERA EN ESPERAR =====");

    rst = 1;
    #40;
    rst = 0;

    #100;

    sensor_vehiculo = 1;

    #40;
    sensor_vehiculo = 0;

    #100;

    send_password(8'b10110011);

    dato_listo = 1;

    #40;
    dato_listo = 0;

    // Esperar mucho tiempo sin salida

    #2000;

    sensor_salida = 1;

    #40;
    sensor_salida = 0;

    #1000;

    //-------------------------------------------------
    // FIN
    //-------------------------------------------------

    $display("\n===== FIN SIMULACION =====");

    $finish;

end

endmodule