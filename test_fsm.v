module test_fsm ();

	reg reset, clk, in_seq;
	wire out_seq;
	reg [31:0] data;
	integer i;
	
	reg out;
	
	
	initial 
	begin
		$dumpfile("test_bench.vcd");
		$dumpvars(0,test_fsm);
		//data = 32'b0;
		i = 0;
		reset = 1'b0; // reset 
		in_seq = 0;
		# 20 reset = 1'b1;
		# 03 in_seq = 1'b1;
		# 20 in_seq = 1'b0;
		# 17 in_seq = 1'b1;
		# 20 in_seq = 1'b0;
		# 20 in_seq = 1'b1;
		# 15 in_seq = 1'b0;
		# 50 in_seq = 1'b1;
		# 15 in_seq = 1'b0;
		# 20 in_seq = 1'b1;
		# 20 in_seq = 1'b0;
		# 30;
		$finish;
	end
	
	initial // Clock generation
		begin
			clk = 0;
			forever begin
				#10;
				clk = ~clk;
			end
		end
	
	SequenceDetector101 fsm0 (clk, reset, in_seq, out_seq);
		

		
endmodule
