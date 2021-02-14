module PWM (Clock, Load, Load_en, PWM_o, delayed_pwm_o );

	input wire Clock;
	input wire Load_en;
	input wire [11:0] Load;
	output wire PWM_o;


	// Counter

	reg [11:0] counter;
	reg UpDown;

	reg[2:0] Load_en_r;

	reg [3:0] counter_shift ;
	reg [3:0] cykl;
	always @(posedge Clock) begin
		Load_en_r <= {Load_en, Load_en_r[2:1]};

		if(Load_en_r[1:0] == 2'b10)
			counter <= Load;
		else if (UpDown)
			counter <= counter+1;
		else
			counter <= counter-1;

		if (counter > 12'd1000) begin
			UpDown<=0;
		end
		else if (counter < 12'd2)begin
			UpDown<=1;
		end	

			counter_shift<=counter_shift+1;
			
		if(counter_shift>cykl) 
			counter_shift<=0;
			
	end

	initial begin
		counter = 0;
		UpDown = 1;
		counter_shift=0;
		cykl=5;
	end

	output  delayed_pwm_o;
	DPR16X4C delay_mem(
		.DI3(), .DI2(),
		.DI1(),.DI0(PWM_o),
		.WAD3(counter_shift[3]),.WAD2(counter_shift[2]),
		.WAD1(counter_shift[1]),.WAD0(counter_shift[0]),
		.WCK(Clock), .WRE(1'b1),
		.RAD3(counter_shift[3]),.RAD2(counter_shift[2]),
		.RAD1(counter_shift[1]),.RAD0(counter_shift[0]),
		.DO3(), .DO2(),
		.DO1(), .DO0(delayed_pwm_o));

	assign PWM_o = counter > 500;

endmodule