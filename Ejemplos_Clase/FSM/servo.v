module servo_controller(
    input clk,
    input rst,
    input abrir,
    input cerrar,
    output reg servo_pwm
);

parameter CLK_FREQ = 50_000_000;
parameter PWM_PERIOD = 1_000_000;

parameter OPEN_PULSE  = 100_000;
parameter CLOSE_PULSE = 50_000;

reg [31:0] counter;
reg [31:0] pulse_width;

always @(posedge clk) begin

    if(rst)
        pulse_width <= CLOSE_PULSE;

    else begin

        if(abrir)
            pulse_width <= OPEN_PULSE;

        else if(cerrar)
            pulse_width <= CLOSE_PULSE;

    end

end

always @(posedge clk) begin

    if(rst)
        counter <= 0;

    else if(counter >= PWM_PERIOD-1)
        counter <= 0;

    else
        counter <= counter + 1;

end

always @(*) begin

    if(counter < pulse_width)
        servo_pwm = 1;

    else
        servo_pwm = 0;

end

endmodule