# Single-Cycle CPU in Verilog

This project implements a **single-cycle CPU** using **Verilog HDL**.  
The goal of the project is to understand **basic processor structure**, **datapath–control separation**, and how instructions flow through hardware.

The design is verified using **RTL simulation**.

---

## Overview

- Single-cycle processor design
- Modular RTL implementation
- Clear separation between datapath and control logic
- Simulation-based verification

---

## Architecture Description

The CPU follows a **single-cycle architecture**, where each instruction is completed in one clock cycle.  
The design is organized into separate modules to make the structure easy to understand and debug.

### Main Modules
- **Program Counter (PC)**  
- **Instruction Memory**  
- **Register File**  
- **ALU**  
- **Control Unit**  
- **Datapath**

Each module is written and tested individually and then integrated at the top level.

---

## Tools & Technologies

- **Language:** Verilog HDL  
- **Simulation:** Xilinx Vivado (RTL simulation and waveform analysis)

---

## Verification

- Functional verification performed using **custom testbenches**
- Simulation waveforms used to observe:
  - Instruction flow
  - Register updates
  - Control signal behavior


