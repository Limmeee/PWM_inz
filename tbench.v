module tb;
	reg XTAL1_20MHz_i;

	always begin
		XTAL1_20MHz_i = 0;
		forever
			#(10) XTAL1_20MHz_i = !XTAL1_20MHz_i;
	end
	
	reg[15:0] i;
	always begin
		i = 0;
		#10
		forever begin
			#20
			i <= i+1;
			if(i>=5000) $stop;
		end
	end
	
	PWM pwm1(.Clock(XTAL1_20MHz_i), .Load(0), .Load_en(1'b0), .PWM_o(out));
endmodule 