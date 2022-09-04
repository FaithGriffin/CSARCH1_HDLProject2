//NAME: Griffin, Faith Juliamae O. SECTION: S11

`timescale 1ns / 1ps
module half_adder(F, G, X, Y);
	output F, G;
	input X, Y;
	PG_generator z1(F, G, X, Y);
endmodule

module PG_generator(P, G, X, Y);
	output P, G;
	input X, Y;
	assign P = X ^ Y;
	assign G = X & Y;
endmodule

module full_adder(F, G, X, Y, Z);
	output F, G;
	input X, Y, Z;
	wire P1, P2;
	half_adder z1(P1, P2, X, Y);
	assign F = P1 ^ Z;
	assign G = P1 & (Z | (X & Y));
endmodule

module sum(S, P, C);
	output S;
	input P, C;
	assign S = P ^ C;
endmodule

module carry_lookahead_circuit_generator(P2, P3, P4, C5, C4, C3, C2, X, Y, C0);
	output P2, P3, P4, C5, C4, C3, C2;
	input [4:0]X;
	input [4:0]Y;
	input C0;
	wire G4, G3, G2, G1, G0, P1, P0;
	PG_generator z0(P0, G0, X[0], Y[0]);
	PG_generator z1(P1, G1, X[1], Y[1]);
	PG_generator z2(P2, G2, X[2], Y[2]);
	PG_generator z3(P3, G3, X[3], Y[3]);
	PG_generator z4(P4, G4, X[4], Y[4]);
	assign C2 = G1 | (P1 & G0) | (P1 & P0 & C0);
	assign C3 = G2 | (P2 & G1) | (P2 & P1 & G0) | (P2 & P1 & P0 & C0);
	assign C4 = G3 | (P3 & G2) | (P3 & P2 & G1) | (P3 & P2 & G0) | (P3 & P2 & P1 & P0 & C0);
	assign C5 = G4 | (P4 & G3) | (P4 & P3 & G2) | (P4 & P3 & G1) | (P4 & P3 & G0) | (P4 & P3 & P2 & P1 & P0 & C0);
endmodule

module hybrid_adder_circuit(S, C8, X, Y, C0);
	input [7:0]X;
	input [7:0]Y; 
	input C0;
	output [7:0]S;
	output C8;
	wire P2, P3, P4, C1, C2, C3, C4, C5, C6, C7;

	full_adder z1(S[0], C1, X[0], Y[0], C0);
	assign S[1] = X[1] ^ Y[1] ^ C1;
	carry_lookahead_circuit_generator z3(P2, P3, P4, C5, C4, C3, C2, X[4:0], Y[4:0], C0);
	sum z4(S[2], P2, C2);
	sum z5(S[3], P3, C3);
	sum z6(S[4], P4, C4);
	full_adder z7(S[5], C6, X[5], Y[5], C5);
	full_adder z8(S[6], C7, X[6], Y[6], C6);
	full_adder z9(S[7], C8, X[7], Y[7], C7);
endmodule

