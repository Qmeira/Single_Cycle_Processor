module regfile(
    input  logic        clk, 
    input  logic        we3,   // RegWrite: Write Enable
    input  logic [4:0]  a1,    // Instr[19:15]: Read Address 1
    input  logic [4:0]  a2,    // Instr[24:20]: Read Address 2
    input  logic [4:0]  a3,    // Instr[11:7]:  Write Address
    input  logic [31:0] wd3,   // Result: Write Data
    output logic [31:0] rd1,   // SrcA: Read Data 1
    output logic [31:0] rd2    // WriteData: Read Data 2
);

    // Create an array of 32 registers, each 32 bits wide
    logic [31:0] rf[31:0];

    // Synchronous Write: Happens on the rising edge of the clock
    always_ff @(posedge clk) begin
        if (we3) begin
            rf[a3] <= wd3;
        end
    end

    // Combinational Read: Happens instantly. 
    // If the address is 0, force the output to 0 (x0 is hardwired to 0).
    assign rd1 = (a1 != 0) ? rf[a1] : 32'b0;
    assign rd2 = (a2 != 0) ? rf[a2] : 32'b0;

endmodule