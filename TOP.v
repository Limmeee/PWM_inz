module PWM (Clock, Load, Load_en, PWM_o);
	
	input wire Clock;
	input wire Load_en;
	input wire [11:0] Load;
	output wire PWM_o;
	
	
	// Counter

	reg [11:0] counter;
	reg UpDown;
	
	reg[2:0] Load_en_r;
		
	always @(posedge Clock) begin
		Load_en_r <= {Load_en, Load_en_r[2:1]};
		
		if(Load_en_r[1:0] == 2'b10)
			counter <= Load;
		else if (UpDown)
			counter <= counter+1;
		else 
			counter <= counter-1;
		
		if (counter > 12'd998) begin
			UpDown<=0;
		end
		else if (counter< 12'd2)begin
			UpDown<=1;
		end	
	end
	
	initial begin
		counter = 0;
		UpDown = 0;
	end
		
	assign PWM_o = counter > 500;

endmodule 