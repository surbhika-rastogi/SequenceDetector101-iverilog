module test_fsm ();
	//wire reset,clk,in_seq,out_seq;
	
	//output reset, clk, in_seq;
	reg reset, clk, in_seq;
	reg out_seq;
	reg [15:0] data;
	integer i;
	
	// The input data sequence is defined in the bit
	// vector "data". On each clock one bit of data is
	// sent to the state machine which will detect the
	// sequence "101" in this data
	
	initial // Initialization
	begin
		data = 16'b0010100110101011;
		i = 0;
		reset = 1'b0; // reset the state machine
		#1200;
		reset = 1'b1;
		#20000;
		$finish;
	end
	
	initial // Clock generation
		begin
			clk = 0;
			forever begin
					#600;
					clk = ~clk;
			end
		end
		// Right shifting of data to
		// generate the input sequence

		always @ (posedge clk)
		begin
			#50;
			in_seq = data >> i;
			i = i+1;
		end
		
		SequenceDetector101 fsm0 (clk, reset, in_seq, out_seq);
		
	endmodule