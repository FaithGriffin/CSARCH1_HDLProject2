//NAME: Griffin, Faith Juliamae O. SECTION: S11

`timescale 1ns/1ps
module hdl_project2_tb();
	reg [7:0] t_input_X;
    reg [7:0] t_input_Y;
    reg C0;
	wire [7:0] t_S;
    wire t_C8;
	hybrid_adder_circuit dut(t_S, t_C8, t_input_X, t_input_Y, C0);
	
	initial
		begin
			t_input_X = 8'b01100000;
            t_input_Y = 8'b01111111;
			C0 = 1'b0;

            #10 t_input_X = 8'b11111111; t_input_Y = 8'b11111110; C0 = 1'b0;
            #10 t_input_X = 8'b10101010; t_input_Y = 8'b01010101; C0 = 1'b0;
            #10 t_input_X = 8'b00001000; t_input_Y = 8'b10000001; C0 = 1'b0;

            #10 t_input_X = 8'b00001000; t_input_Y = 8'b10000001; C0 = 1'b1;
            #10 t_input_X = 8'b00000001; t_input_Y = 8'b00000000; C0 = 1'b1;
            #10 t_input_X = 8'b11110000; t_input_Y = 8'b10001000; C0 = 1'b1;
            /*
                Initial: X = 01100000; Y = 01111111; C0 = 0;
                Then successive propagation delay of 10-unit time:
                X = 11111111; Y= 11111110
                X = 10101010; Y= 01010101
                X = 00001000; Y= 10000001
                X = 00001000; Y= 10000001; C0 = 1
                X = 00000001; Y = 00000000
                X = 11110000; Y= 10001000
            */
		end
	initial
		begin
			$display("Name: Griffin, Faith Juliamae O.");
			$display("8-bit Hybrid Adder Circuit");
            $display ("Specification: From C0: 2-bit ripple carry_3-bit carry lookahead_3-bit ripple carry");
			$display("Verilog Model: Structural Model");
			$monitor("Time = %0d\t",$time, "C0 = %b\tInput_X = %b\tInput_Y = %b\tOutput_Sum = %b\tOutput_C8 = %b", C0, t_input_X, t_input_Y, t_S, t_C8);
			$dumpfile("grif2.vcd");
			$dumpvars();    
	end
endmodule