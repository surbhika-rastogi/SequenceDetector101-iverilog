module SequenceDetector101 (
    input clk,
    input aresetn,
    input x,
    output z ); 

wire in;
reg out;


parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;


reg [1:0] state; 
reg [1:0] next_state; 

assign in = x;
assign z = out;

//next state 
always @(posedge clk, negedge aresetn)
	begin 
	if (aresetn == 1'b0)
	    state <= S0;
	else
	    state <= next_state;
	end
 
//FSM   
always @(*)
begin 
	next_state = 2'b00;
if (aresetn == 1'b0)
		out <= 1'b0;
	else begin
		case(state)
		S0 : 	if (in == 1'b0) begin
				next_state = S0;
				out <= 1'b0;
				end
				else begin
				next_state = S1;
				out <= 1'b0;
        	end
   		 S1 : 	if (in == 1'b0) begin
				next_state = S2;
				out <= 1'b0;
				end
				else begin
				next_state = S1;
				out <= 1'b0;
				end
		S2 : 	if (in == 1'b0) begin
				next_state = S0;
				out <= 1'b0;
				end
				else begin
				next_state = S1;
				out <= 1'b1;
				end
		default : begin
				next_state = S0;
				out <= 1'b0;
				end
		endcase
	end
end

endmodule
