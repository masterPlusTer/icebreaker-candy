
# bitmap


This project is a **learning-oriented implementation** of a 64×64 RGB LED framebuffer on the iCEBreaker FPGA.

It includes two main parts:

1. **Verilog code** (`top.v` and modules) that implement:
   - A 64×64 framebuffer with 3-bit color (RGB, 8 colors).
   - A painter module that reads pixel data from the framebuffer and outputs RGB values to the LED matrix.
   - Initialization of the framebuffer from an external file `image.mem`, which contains the bitmap data.

2. **Pixel editor tool** (`pixel-editor.html`):
   - A simple browser-based drawing tool (like a mini paint program).
   - Lets you draw pixel art directly on a 64×64 grid.
   - Supports 8 colors (3-bit RGB).
   - Can export the drawing as an `image.mem` file that can be loaded by the Verilog code.
   - Designed for ease of experimentation and quick prototyping.

---

## Purpose

⚠️ **Important**: This project is **not optimized for performance or efficiency**.  
It was written to help beginners understand how to:

- Use a framebuffer in FPGA design.
- Interface external files (`image.mem`) with Verilog.
- Visualize custom graphics on an LED panel.

---

## Usage

1. Open `pixel-editor.html` in a browser.  
2. Draw your 64×64 pixel art.  
3. Export or download the result as `image.mem`.  
4. Place the generated `image.mem` file in the FPGA project folder.  
5. Build and upload the Verilog project to your iCEBreaker FPGA.  
6. The LED matrix will display your image! 🎉

---

## File Structure

```
.
├── bitmap.v             # Main Verilog module for iCEBreaker, Framebuffer with initialization from image.mem and pixel fetch logic
├── Makefile             # Makefile
├── pixel-editor.html    # Browser-based pixel editor (like paint)
├── image.mem            # Generated memory file (bitmap for LED matrix)
└── README.md            # This file
```

---

## Example Workflow

1. Design your image in the editor. (you can use the Live preview in VS Code) 
2. Save the fine `image.mem` in the project folder.  
3. Run `make` to synthesize the FPGA design.  
4. Upload to the board and watch your image appear on the LED panel.

---

## Notes

- The framebuffer uses **3 bits per pixel** (values 0–7), mapping to 8 colors.  
- The project demonstrates **basic principles** of FPGA graphics, not high-performance rendering.  
- Contributions and improvements are welcome!
