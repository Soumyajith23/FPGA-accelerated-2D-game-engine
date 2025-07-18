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

### 1. VGA Controller  
The VGA Controller generates synchronization and video timing signals required for displaying graphics on a monitor. Since the Boolean Board lacks a VGA port, an HDMI IP core is used to convert VGA-style signals to HDMI, allowing output on modern displays.

**What It Does**  
Implements VGA 640×480 @ 60 Hz standard (based on VESA spec)

Produces key signals:  
H sync – Horizontal sync pulse  
V sync – Vertical sync pulse  
V en – Video enable (active during visible area)  
RGB – Pixel color data  

These signals are sent to the HDMI IP core to drive an external monitor.

<img width="540" height="309" alt="image" src="https://github.com/user-attachments/assets/a77db484-e2e6-4131-bd81-98e148d8c8e4" />


### 2. Scrolling Background  

The Scrolling Background System enables infinite horizontal scrolling by repeating mirrored tile blocks. A 128-pixel-wide strip is stored in Single-Port ROM (from BRAM) and duplicated to cover the screen with 5 blocks, creating a seamless scrolling effect.

The system uses a 4-bit Color Lookup Table (CLUT) to map color indices to RGB565 (16-bit) format for rendering.


<p align="left"> <img src="https://github.com/user-attachments/assets/88f3132c-5775-4603-b35f-1160ced14e6c" alt="Scrolling Background Image 1" height="280" /> &nbsp;&nbsp; <img src="https://github.com/user-attachments/assets/c0730c6f-372f-49c7-826d-c94c0bcf7092" alt="Scrolling Background Image 2" height="280" /> </p>

### 3. Tile Management

The Tile Management System handles rendering tile-based maps for the game background. Each tile is a 32×32 pixel block, where every pixel is represented by a 4-bit color index. This index is mapped to an RGB565 color using a Color Lookup Table (CLUT) implemented in ROM.

The system supports up to 32 unique tiles (5-bit indices) and organizes them through a Tile Map, which references these tiles to form the complete background.
Key Components:  
Tile Data:  
Stored in Single-Port ROM, containing pixel data for all 32 tiles.  
Tile Map:  
Stored in Single-Port ROM, 5-bit width, 315 entries.  
Represents 20×15 tiles (300 total) for a full screen.  
Includes 15 extra entries reserved for seamless scrolling.  
<img width="468" height="306" alt="image" src="https://github.com/user-attachments/assets/aa89545f-1e27-4c83-97fa-baab338b169b" />

### 4. Rendering Engine  

Key Features of the Rendering Pipeline  
Asymmetric FIFO System  
Uses 4 asymmetric FIFOs to write 128 bits (32 pixels) in one cycle, while enabling 4-bit pixel reads at the pixel clock rate.  

High-Speed Framebuffer Updates  
Cross-clock design writes to the framebuffer at 4× pixel clock speed, enabling a 640-pixel line update in just 20 system cycles.  

Massive Write Throughput  
Achieves up to 128× faster write speed compared to naive pixel-clock-based designs.  

Efficient Memory Usage via CLUT  
Stores 4-bit color indices, mapped to RGB565 through a CLUT for memory efficiency without visual loss.  

Hardware Scrolling Support  
Dedicated FSM enables smooth hardware scrolling with programmable offsets, even for 32-pixel-wide tile maps.  

Parallelism & Timing Decoupling    
FIFO buffering and decoupled clocks allow parallel tile decoding and pixel rendering, boosting scalability and efficiency.  
<img width="768" height="590" alt="Screenshot 2025-07-19 034024" src="https://github.com/user-attachments/assets/86c5a59e-aeea-4fa1-bca5-a206f734b0d7" />




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
