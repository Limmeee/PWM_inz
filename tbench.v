`timescale 1ns/1ps

module tb;
	reg XTAL1_20MHz_i;

	always begin
		XTAL1_20MHz_i = 0;
		forever
			#(25) XTAL1_20MHz_i = !XTAL1_20MHz_i;
	end

	reg[15:0] i;
	always begin
		i = 0;
		forever begin
			#50
			i <= i+1;
			if(i>=5000) $stop;
		end
	end

	PWM pwm1(.Clock(XTAL1_20MHz_i), .Load(0), .Load_en(1'b0), .PWM_o(out),.PWM_o2(out2),.delayed_pwm_o(delayed_out) );
endmodule