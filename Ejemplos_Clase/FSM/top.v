module top_parqueadero(
    input clk,
    input rst,

    input sensor_vehiculo,
    input bit_serial,
    input dato_listo,
    input sensor_salida,

    output servo_pwm
);

//-------------------------------------------------
// Señales internas
//-------------------------------------------------

wire shift_enable;
wire comparar_enable;
wire servo_abrir;
wire servo_cerrar;
wire timer_enable;

wire [7:0] password_data;

wire id_correcto;
wire timer_done;

//-------------------------------------------------
// Shift Register
//-------------------------------------------------

shift_register shift0(
    .clk(clk),
    .rst(rst),
    .enable(shift_enable),
    .serial_in(bit_serial),
    .data(password_data)
);

//-------------------------------------------------
// Comparador
//-------------------------------------------------

comparador_id comp0(
    .data(password_data),
    .id_correcto(id_correcto)
);

//-------------------------------------------------
// Timer
//-------------------------------------------------

timer timer0(
    .clk(clk),
    .rst(rst),
    .enable(timer_enable),
    .done(timer_done)
);

//-------------------------------------------------
// FSM
//-------------------------------------------------

fsm_parqueadero fsm0(
    .clk(clk),
    .rst(rst),

    .sensor_vehiculo(sensor_vehiculo),
    .dato_listo(dato_listo),
    .id_correcto(id_correcto),
    .sensor_salida(sensor_salida),

    .timer_done(timer_done),

    .shift_enable(shift_enable),
    .comparar_enable(comparar_enable),

    .servo_abrir(servo_abrir),
    .servo_cerrar(servo_cerrar),

    .timer_enable(timer_enable)
);

//-------------------------------------------------
// Servo Controller
//-------------------------------------------------

servo_controller servo0(
    .clk(clk),
    .rst(rst),

    .abrir(servo_abrir),
    .cerrar(servo_cerrar),

    .servo_pwm(servo_pwm)
);

endmodule