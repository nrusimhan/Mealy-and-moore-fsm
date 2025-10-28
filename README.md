# 🧠 FSM Sequence Detector (Moore & Mealy)

This project implements two types of **Finite State Machines (FSMs)** in **Verilog HDL** to detect specific binary sequences from a serial input bit stream.  
It includes both **Moore** and **Mealy** FSM versions, along with their **testbenches** for simulation.

---

## 📁 Files Included

| File Name | Description |
|------------|-------------|
| `moore_seq101.v` | Moore FSM that detects the bit sequence `101` |
| `tb_moore_seq101.v` | Testbench for the Moore FSM |
| `mealy_seq110.v` | Mealy FSM that detects the bit sequence `110` |
| `tb_mealy_seq110.v` | Testbench for the Mealy FSM |

---

## ⚙️ 1. Moore FSM — Sequence `101`

### 📋 Description
- Detects the **bit sequence `101`** in a serial bitstream.  
- Uses **Moore model**, where output depends **only on the current state**.  
- The output (`y = 1`) becomes high **one clock cycle after** the entire sequence is detected.  
- **Overlapping sequences** are supported (e.g., input `10101` detects twice).

### 🧩 State Definitions
| State | Meaning |
|--------|----------|
| S0 | No bits matched |
| S1 | Saw `1` |
| S2 | Saw `10` |
| S3 | Saw `101` (Output = 1) |

### 🕒 Example Waveform
For input stream `1 0 1 0 1`,  
output `y` = `0 0 1 0 1`

---

## ⚙️ 2. Mealy FSM — Sequence `110`

### 📋 Description
- Detects the **bit sequence `110`** in a serial bitstream.  
- Uses **Mealy model**, where output depends on **both the current state and input**.  
- Output (`y = 1`) goes high **immediately when the last bit (0)** of the sequence is received.  
- **Overlapping detection** supported (e.g., `110110` detects twice).

### 🧩 State Definitions
| State | Meaning |
|--------|----------|
| S0 | No bits matched |
| S1 | Saw `1` |
| S2 | Saw `11` |

### 🕒 Example Waveform
For input stream `1 1 0 1 1 0`,  
output `y` = `0 0 1 0 0 1`

---

## 🧪 Testbench Overview

Both testbenches:
- Generate a **10 ns clock** (period = 10 ns).  
- Apply a serial bit input stream to verify FSM response.  
- Use `$monitor` statements to print `time`, `input`, `state`, and `output` during simulation.  

---

## 🧰 How to Simulate

1. Open your preferred Verilog simulator (ModelSim, Vivado, or EDA Playground).
2. Add the `.v` files to your project.
3. Set the testbench (`tb_moore_seq101.v` or `tb_mealy_seq110.v`) as the top module.
4. Run the simulation and observe the output waveform or console log.

---

## 🧾 Author

Created by **WHITE ROOK**  
For academic learning and FSM design practice in Verilog.
