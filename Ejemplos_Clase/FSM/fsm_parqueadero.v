module fsm_parqueadero(

    input clk,
    input rst,

    input sensor_vehiculo,
    input dato_listo,
    input id_correcto,
    input sensor_salida,
    input timer_done,

    output reg shift_enable,
    output reg comparar_enable,
    output reg servo_abrir,
    output reg servo_cerrar,
    output reg timer_enable

);

//////////////////////////////////////////////////
// Estados
//////////////////////////////////////////////////

localparam IDLE     = 3'b000;
localparam LEER     = 3'b001;
localparam VALIDAR  = 3'b010;
localparam ABRIR    = 3'b011;
localparam ESPERAR  = 3'b100;
localparam CERRAR   = 3'b101;

//////////////////////////////////////////////////
// Registros de estado
//////////////////////////////////////////////////

reg [2:0] estado_actual;
reg [2:0] siguiente_estado;

//////////////////////////////////////////////////
// Registro de estado
//////////////////////////////////////////////////

always @(posedge clk) begin

    if(rst)
        estado_actual <= IDLE;
    else
        estado_actual <= siguiente_estado;

end

//////////////////////////////////////////////////
// Lógica de transición
//////////////////////////////////////////////////

always @(*) begin

    // Valor por defecto
    siguiente_estado = estado_actual;

    case(estado_actual)

        //////////////////////////////////////////
        // Estado IDLE
        //////////////////////////////////////////

        IDLE: begin

            if(sensor_vehiculo)
                siguiente_estado = LEER;
            else
                siguiente_estado = IDLE;

        end

        //////////////////////////////////////////
        // Estado LEER
        //////////////////////////////////////////

        LEER: begin

            if(dato_listo)
                siguiente_estado = VALIDAR;
            else
                siguiente_estado = LEER;

        end

        //////////////////////////////////////////
        // Estado VALIDAR
        //////////////////////////////////////////

        VALIDAR: begin

            if(id_correcto)
                siguiente_estado = ABRIR;
            else
                siguiente_estado = IDLE;

        end

        //////////////////////////////////////////
        // Estado ABRIR
        //////////////////////////////////////////

        ABRIR: begin

            if(timer_done)
                siguiente_estado = ESPERAR;
            else
                siguiente_estado = ABRIR;

        end

        //////////////////////////////////////////
        // Estado ESPERAR
        //////////////////////////////////////////

        ESPERAR: begin

            if(sensor_salida)
                siguiente_estado = CERRAR;
            else
                siguiente_estado = ESPERAR;

        end

        //////////////////////////////////////////
        // Estado CERRAR
        //////////////////////////////////////////

        CERRAR: begin

            if(timer_done)
                siguiente_estado = IDLE;
            else
                siguiente_estado = CERRAR;

        end

        //////////////////////////////////////////
        // Estado por defecto
        //////////////////////////////////////////

        default: begin

            siguiente_estado = IDLE;

        end

    endcase

end

//////////////////////////////////////////////////
// Lógica de salida
//////////////////////////////////////////////////

always @(*) begin

    // Valores por defecto
    shift_enable     = 0;
    comparar_enable  = 0;
    servo_abrir      = 0;
    servo_cerrar     = 0;
    timer_enable     = 0;

    case(estado_actual)

        //////////////////////////////////////////
        // LEER
        //////////////////////////////////////////

        LEER: begin

            shift_enable = 1;

        end

        //////////////////////////////////////////
        // VALIDAR
        //////////////////////////////////////////

        VALIDAR: begin

            comparar_enable = 1;

        end

        //////////////////////////////////////////
        // ABRIR
        //////////////////////////////////////////

        ABRIR: begin

            servo_abrir  = 1;
            timer_enable = 1;

        end

        //////////////////////////////////////////
        // CERRAR
        //////////////////////////////////////////

        CERRAR: begin

            servo_cerrar = 1;
            timer_enable = 1;

        end

    endcase

end

endmodule