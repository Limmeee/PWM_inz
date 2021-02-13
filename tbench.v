module tb;

	reg clk;

	reg rst;
	reg clk_en;

	reg [11:0] load_val;
	reg load_en;
	wire out;

	


	always #1 clk=~clk;
	
	
		

	initial begin 
	clk_en=1;
	end
	 PWM pwm1(.Clock(clk), .Clk_En(clk_en),.Rst(rst),.Load(load_val),.Load_en(load_en), .PWM_o(out), .D(12'd100));
endmodule 