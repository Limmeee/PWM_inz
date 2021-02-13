
/*module Counter (Clock, Clk_En,Rst,Load,Load_en,Ctr_0, Q);
     
	input wire Clock;
    input wire Clk_En;
	input wire Rst;
	input wire Load_en;
	input wire [11:0] Load;
	
    output reg Ctr_0;
    output wire [11:0] Q;	

	reg [11:0] out;
	reg UpDown;
	reg ctr_00;
	
	
	always@(Clock) begin
		if (out<12'd1) begin
			Ctr_0=1;
		end
		else begin
			Ctr_0=0;	
		end
	end
	
	always @(posedge Clock) begin
			
		if(Clk_En) begin
			if (UpDown)
				out <= out-1;
			else 
				out  <= out+1;
								
			if (out> 12'd998) begin
				UpDown=1;
			end
			if (out< 12'd2)begin
				UpDown=0;
			end
		end
			else  begin
				out<=out;	
			end
				
				
		if( Rst) begin
			out<=12'd0;
		UpDown=0;
			
		end

		if( Load_en) begin
			out<=Load;
		
		end

	end

assign Q=out;

endmodule
*/
module PWM (Clock, Clk_En,Rst,Load,Load_en, PWM_o);
	
	input wire Clock;
    input wire Clk_En;
	input wire Rst;
	input wire Load_en;
	input wire [11:0] Load;
	
	output wire PWM_o;
	
	
	// Counter
    reg Ctr_0;
    reg [11:0] Q;	

	reg [11:0] out;
	reg UpDown;
	reg ctr_00;
	
	
	always@(Clock) begin
		if (out<12'd1) begin
			Ctr_0=1;
		end
		else begin
			Ctr_0=0;	
		end
	end
	
	always @(posedge Clock) begin
			 Q<=out;
		if(Clk_En) begin
			if (UpDown)
				out <= out-1;
			else 
				out  <= out+1;
								
			if (out> 12'd998) begin
				UpDown=1;
			end
			if (out< 12'd2)begin
				UpDown=0;
			end
		end
			else  begin
				out<=out;	
			end
				
				
		if( Rst) begin
			out<=12'd0;
		UpDown=0;
			
		end

		if( Load_en) begin
			out<=Load;
		
		end

	end



/// Rejestr
// 12 przerzutników typu D FD1S3IX
integer i;
reg D [11:0];
wire CD;
reg D_q [11:0];

always @(posedge Clock) begin
	
	for ( i=0; i<12; i=i+1) begin
	
		if (CD) begin
			D_q[i]<=0;
		end
		else begin
			D_q[i]<=D[i];
		end
	
	end
end	


/// Komparator

wire CMPA;
assign CMPA=(Q[0]==D_q[0]&
			 Q[1]==D_q[1]& 
			 Q[2]==D_q[2]&
			 Q[3]==D_q[3]& 
			 Q[4]==D_q[4]&
			 Q[5]==D_q[5]& 
			 Q[6]==D_q[6]&
			 Q[7]==D_q[7]& 
			 Q[8]==D_q[8]&
			 Q[9]==D_q[9]& 
			 Q[10]==D_q[10]&
			 Q[1]==D_q[11])?1'b1:1'b0;


assign PWM_o=CMPA;

endmodule 