// 4-bit Carry Lookahead Adder (CLA)
module cla_4bit (
    input [3:0] A,      // 4-bit input A
    input [3:0] B,      // 4-bit input B
    input CIN,          // Carry input
    output [3:0] SUM,   // 4-bit sum output
    output COUT         // Final carry output
);

    wire [3:0] G, P;    // Generate and propagate signals
    wire [3:0] C;       // Internal carry signals

    // Generate (G) and propagate (P) terms
    assign G = A & B;         // Generate: Gi = Ai & Bi
    assign P = A ^ B;         // Propagate: Pi = Ai ^ Bi

    // Carry signals
    assign C[0] = CIN;
    assign C[1] = G[0] | (P[0] & CIN);
    assign C[2] = G[1] | (P[1] & C[1]);
    assign C[3] = G[2] | (P[2] & C[2]);
    assign COUT = G[3] | (P[3] & C[3]);

    // Sum calculation
    assign SUM = P ^ C;

endmodule

// Generate (G) and Propagate (P) Terms:
// Generate: G[i] = A[i] & B[i] - This indicates whether a carry is generated by the addition of A[i] and B[i].
// Propagate: P[i] = A[i] ^ B[i] - This indicates whether a carry from the previous bit should propagate to the next.

//Carry Calculation:
//Carry for each bit is calculated using the generate and propagate terms:
// C[1] = G[0] | (P[0] & CIN)
// C[2] = G[1] | (P[1] & C[1])
// C[3] = G[2] | (P[2] & C[2])
// COUT = G[3] | (P[3] & C[3])

//Sum Calculation:
// The sum is calculated using the propagate term and the corresponding carry-in:
// SUM[i] = P[i] ^ C[i]
