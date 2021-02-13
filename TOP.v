module PWM (Clock, Load, Load_en, PWM_o, delayed_pwm_o );
	
	input wire Clock;
	input wire Load_en;
	input wire [11:0] Load;
	output wire PWM_o;
	
	
	// Counter

	reg [11:0] counter;
	reg Up;
	reg Down;

	reg[2:0] Load_en_r;
		
	always @(posedge Clock) begin
		Load_en_r <= {Load_en, Load_en_r[2:1]};
		
		if(Load_en_r[1:0] == 2'b10)
			counter <= Load;
		else 
			counter <= counter+Up-Down;
		
		if (counter > 12'd1000) begin
			Up<=0;
			Down<=1;
		end
		else if (counter < 12'd2)begin
			Up<=1;
			Down<=0;
		end	
	end
	
	initial begin
		counter = 0;
		Up = 1;
		Down = 0;
		
	
		
	end
	reg [3:0] reg_delay_mem ;
	
	output wire delayed_pwm_o;
	DPR16X4C delay_mem(
		.DI3(), .DI2(),
		.DI1(),.DI0(PWM_o), 
		.WAD3(reg_delay_mem[3]),.WAD2(reg_delay_mem[2]),
		.WAD1(reg_delay_mem[1]),.WAD0(reg_delay_mem[0]),
		.WCK(Clock), .WRE(1'b1),
		.RAD3(reg_delay_mem[3]),.RAD2(reg_delay_mem[2]),
		.RAD1(reg_delay_mem[1]),.RAD0(reg_delay_mem[0]),
		.DO3(delayed_pwm_o), .DO2(),
		.DO1(), .DO0());
	
	assign PWM_o = counter > 500;

endmodule 