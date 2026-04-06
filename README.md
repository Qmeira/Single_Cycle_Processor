# RISC-V Single-Cycle Processor Extension: XOR Instruction

This repository contains a SystemVerilog implementation of a single-cycle RISC-V processor. The base architecture has been modified to support the hardware execution of the bitwise `xor` instruction alongside the standard base integer instruction set.

## Project Overview

The goal of this project was to extend the processor's Arithmetic Logic Unit (ALU) and control logic to correctly decode and execute the RISC-V `xor` operation without disrupting existing instruction pathways. 

### Architecture Modifications
Because `xor` is a standard R-type arithmetic instruction, the data path and several control units required no structural changes:
* **Main Decoder:** Remains unchanged. The `xor` instruction shares the standard R-type opcode (`0110011` / `0x33`). The Main Decoder routes the signals appropriately, keeping `ALUSrc` at 0 (register-to-register operation) and setting `ALUOp` to `10`.
* **ImmSrc Decoder:** Remains unchanged, as R-type instructions do not utilize immediate values.
* **ALU Decoder (`aludec.sv`):** Modified to recognize the specific `funct3` code for `xor` (`3'b100`) when `ALUOp` is `10`, outputting the correct internal `ALUControl` signal (`3'b100`) to the ALU.

## Repository Structure

Key files in this project include:
* `aludec.sv` - Contains the modified ALU Decoder truth table logic.
* `testbench.sv` - The SystemVerilog testbench, updated to verify the result of the custom `xor` program.
* `riscvtest.txt` - The hexadecimal machine code loaded into instruction memory (`imem.sv`) upon simulation startup.
* `riscvsingle.qsf` - Quartus project settings file.

## Testing and Simulation

The processor is verified using a custom 4-instruction assembly program designed to isolate and test the `xor` logic. 

**Assembly Program:**
```assembly
addi x4, x0, 7      # Load 7 into x4
addi x5, x0, 11     # Load 11 into x5
xor x6, x4, x5      # XOR x4 and x5 (7 ^ 11 = 12)
sw x6, 100(x0)      # Store result (12) into memory address 100