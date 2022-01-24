module SequenceDetector101 (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 

	wire in_seq_reg;
	reg out_seq;
	
    
    parameter SIZE = 2;
	parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;
    
    //------------ Internal Variables ----------------------------------
	reg [SIZE-1:0] state; // Memory part of the FSM
	reg [SIZE-1:0] next_state; // Combinational part of the FSM

    assign in_seq_reg = x;
	 assign z = out_seq;
    
    always @ (*)
	begin : FSM_COMBO
		next_state = 2'b00;
        if (aresetn == 1'b0)
			out_seq <= 1'b0;
		else begin
			case(state)
			S0 : 	if (in_seq_reg == 1'b0) begin
					next_state = S0;
					out_seq <= 1'b0;
					end
					else begin
					next_state = S1;
					out_seq <= 1'b0;
                	end
            S1 : 	if (in_seq_reg == 1'b0) begin
					next_state = S2;
					out_seq <= 1'b0;
					end
					else begin
					next_state = S1;
					out_seq <= 1'b0;
					end
			S2 : 	if (in_seq_reg == 1'b0) begin
					next_state = S0;
					out_seq <= 1'b0;
					end
					else begin
					next_state = S1;
					out_seq <= 1'b1;
					end
			default : begin
					next_state = S0;
					out_seq <= 1'b0;
					end
			endcase
        end
    end

    // Register combinational “next_state” variable
    always @(posedge clk, negedge aresetn)
	begin : FSM_SEQ
        if (aresetn == 1'b0)
            state <= S0;
        else
            state <= next_state;
	end

endmodule
