# FPGA 2D Game Engine

**Authors**: Kishor Kunal, Soumyajit Halder  
**Date**: July 5, 2025  
**Platform**: AMD Spartan-7 FPGA (Boolean Board)  
**Language**: Verilog HDL  
**Resolution**: 640×480 @ 60Hz  
**Tools**: Vivado, UART, JavaScript, VGA/HDMI

---

## Abstract

This project implements a 2D endless-runner-style game engine entirely in Verilog. It is optimized for real-time performance on resource-constrained FPGA hardware, with a modular architecture supporting background scrolling, tile rendering, animation, and input handling. The engine also includes procedural generation and audio output — offering a complete retro game experience built from the ground up in hardware.

---

## System Architecture

- **VGA Controller**: Outputs 640×480@60Hz video using HDMI.
- **Scrolling Background**: Infinite horizontal parallax-style movement using tile repetition.
- **Tile Management System**: Handles 32×32 tiles with 4-bit indexed colors.
- **Rendering Pipeline**: FIFO-based high-throughput tile rendering with dual clock domains.
- **Procedural Level Generator**: Pseudo-random terrain generation using LFSRs.
- **Audio Output**: Square wave music generation via passive buzzer.
- **UART Input Handler**: Keyboard control via serial communication at 9600 baud.
- **BCD-Based Timer System**: Human-readable score/time counter.
- **UI System**: Bitmap-based score display on screen.
- **Sprite Animation**: FSM-based animation (partially implemented).
- **Physics Engine**: Collision + gravity (partially implemented).
- **Tile Designer App**: JavaScript tool for exporting `.coe` files.

---

## Major Modules

### VGA Controller

 The VGA controller is responsible for generating synchronization and timing signals to correctly display video on a monitor.
 Although the Boolean Board does not have a native VGA port, it includes an HDMI port. We use a VGA-to-HDMI converter
 IP to transform the VGA-style signal output to HDMI for compatibility with modern displays.

- Standard 640×480 @ 60Hz VGA timing.
- Outputs: `HSYNC`, `VSYNC`, `RGB`, `V_EN`.
- Uses VGA-to-HDMI IP to support modern displays.



<img width="540" height="309" alt="image" src="https://github.com/user-attachments/assets/a77db484-e2e6-4131-bd81-98e148d8c8e4" />


### Scrolling Background

- ROM-based mirrored 128-pixel blocks.
- 4-bit CLUT maps to RGB565.
- Infinite seamless horizontal scrolling.

<p align="left"> <img src="https://github.com/user-attachments/assets/88f3132c-5775-4603-b35f-1160ced14e6c" alt="Scrolling Background Image 1" height="280" /> &nbsp;&nbsp; <img src="https://github.com/user-attachments/assets/c0730c6f-372f-49c7-826d-c94c0bcf7092" alt="Scrolling Background Image 2" height="280" /> </p>

### Tile Management

- Up to 32 tiles of 32×32 pixels.
- Tile map defines layout (20×15).
- Uses BRAM for storage and dual-port RAM for performance.
<img width="468" height="306" alt="image" src="https://github.com/user-attachments/assets/aa89545f-1e27-4c83-97fa-baab338b169b" />

### Rendering Engine

- FIFO-based line buffer writes 32 pixels per cycle.
- Cross-clock domain design.
- 128× faster rendering using burst writes.
- Hardware scrolling support via FSM.

### Procedural Generator

- Uses LFSRs to generate height and tile types.
- Probability-controlled tile selection.
- Enforces constraints like max 2 empty tiles.

### Audio System

- 100 MHz-driven square wave for buzzer output.
- Precomputed half-periods for notes.
- Plays looping 16-note melody.

### UART Input

- Reads player input from PC keyboard.
- UART receiver FSM decodes start/data/stop bits.
- Uses double-registering to avoid metastability.

### Timer System

- BCD timer increments every second.
- Compatible with 7-segment or bitmap display.
- Pause and reset functionality included.

### UI Score Display

- Score shown via 4-digit 32×32 bitmaps.
- `.coe` initialized BRAMs for digits 0–9.
- Bitmapped directly on VGA frame.

---

## Tools & Resources

- **Vivado**: HDL simulation, timing analysis, ILA debugging.
- **JavaScript Applet**: For designing tiles and exporting `.coe` files.
- **Useful Sites**:
  - https://fpga4fun.com/
  - https://projectf.io/
  - https://nandland.com/
  - https://tikzmaker.com/

---

## Challenges Faced

1. **Ideation Overhead** – Designing the architecture from scratch.
2. **Setup/Hold Violations** – Early code had timing issues.
3. **Clock Domain Crossing** – Syncing pixel clock to sys clock cleanly.
4. **FSM for Animation** – Subtle bugs in FIFO and overflow logic.

---

## Major Learnings

- Gained deep insight into pipelined hardware logic and FSMs.
- Developed cross-domain communication safely.
- Understood the importance of proper simulation and validation tools.

---

## AI Usage

- Assisted with LaTeX formatting and structuring.
- Helped design the `.coe` generator tool.
- Provided clarity in idea refinement — not much in raw Verilog coding.

---

Screenshots 
<p align="center"> <img src="https://github.com/user-attachments/assets/bde902ab-c571-41e9-97f3-212b399781c4" alt="Controlling the Ball and Updating Score" width="400"/> &nbsp;&nbsp;&nbsp; <img src="https://github.com/user-attachments/assets/a9955859-a16d-4277-8533-c1cb6984a8e4" alt="Random Tiles" width="400"/> </p> <p align="center"> <b>Left:</b> Controlling the Ball and Updating Score &nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp; <b>Right:</b> Random Tiles </p>

 Demos
1️ UART Receiver Demo


https://github.com/user-attachments/assets/dfad0f55-3180-4cd1-b2cc-4b0183502bbe


2️ Basic Controlling and Gameplay


https://github.com/user-attachments/assets/d2322b7f-7b8d-4c9e-9a6f-344c8d576084


3️ Random Tiles Generation


https://github.com/user-attachments/assets/9c48661f-54fe-47e2-8bdf-e2fc54b951d7





## File Structure (suggested)



```bash
project/
├── src/                   # Verilog modules
├── coe/                   # Tile/sprite bitmap .coe files
├── js_tile_designer/      # JavaScript app
├── docs/                  # Report / README
└── constraints/           # XDC / pin mappings
