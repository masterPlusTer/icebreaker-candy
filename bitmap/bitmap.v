`default_nettype none

// =============================================================
// TOP para iCEBreaker con framebuffer 64x64 RGB (3 bits por pixel)
// =============================================================


`include "../include/led-delay.v"

module top (
    input         CLK,
    input         BTN_N,
    output [15:0] LED_PANEL
);

    led_main #(
        .DELAY(2)
    ) main (
        .CLK(CLK),
        .resetn_btn(BTN_N),
        .LED_PANEL(LED_PANEL)
    );



endmodule

// =============================================================
// Painter: recibe coordenadas (x,y) y devuelve color del framebuffer
// =============================================================
module painter(
    input        clk,
    input        reset,
    input  [9:0] frame,
    input  [7:0] subframe,
    input  [5:0] x,
    input  [5:0] y,
    output [2:0] rgb
);

    // dirección lineal: y*64 + x
    wire [11:0] addr = y * 64 + x;   
    wire [2:0] pixel_color;

    framebuffer fb (
        .clk(clk),
        .we(1'b0),               // solo lectura por ahora
        .addr(addr),
        .data_in(3'b000),
        .data_out(pixel_color)
    );

    assign rgb = pixel_color;

endmodule

// =============================================================
// Framebuffer 64x64 con inicialización desde archivo "image.mem"
// Cada pixel = 3 bits (RGB)
// =============================================================
module framebuffer(
    input  wire        clk,
    input  wire        we,          // write enable
    input  wire [11:0] addr,        // dirección 0..4095
    input  wire [2:0]  data_in,     // RGB a escribir
    output reg  [2:0]  data_out
);

    reg [2:0] mem [0:4095];  // 64*64 = 4096 pixeles, 3 bits c/u
    reg [11:0] addr_r;       // registro para direccion

    initial begin
        // el archivo debe estar en el mismo directorio de compilación (circle/)
        $readmemh("image.mem", mem); 
    end

    always @(posedge clk) begin
        addr_r <= addr;              // retardo de dirección
        if (we) begin
            mem[addr] <= data_in;
        end
        data_out <= mem[addr_r];     // salida con dirección registrada
    end

endmodule
