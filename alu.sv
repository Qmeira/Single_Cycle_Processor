module alu(
    input  logic [31:0] a,          // SrcA
    input  logic [31:0] b,          // SrcB
    input  logic [2:0]  alucontrol, // ALUControl signal from the decoder
    output logic [31:0] result,     // ALUResult
    output logic        zero        // Zero flag (1 if result is 0)
);

    always_comb begin
        case (alucontrol)
            3'b000: result = a + b;       // ADD
            3'b001: result = a - b;       // SUB
            3'b010: result = a & b;       // AND
            3'b011: result = a | b;       // OR
            3'b100: result = a ^ b;       // XOR
            3'b101: result = (a < b) ? 32'b1 : 32'b0; // SLT (Set Less Than)
            default: result = 32'bx;      // Undefined
        endcase
    end

    // The Zero flag is true if the result is exactly zero
    assign zero = (result == 32'b0);

endmodule