
module video_timing
(
    input       clk,
    input       clk_pix,
    input       reset,

    input  [2:0] pcb,
    input        refresh_mod,

    input  signed [3:0] hs_offset,
    input  signed [3:0] vs_offset,

    input  signed [3:0] hs_width,
    input  signed [3:0] vs_width,

    output [8:0] hc,
    output [8:0] vc,

    output reg  hsync,
    output reg  vsync,

    output reg  hbl,
    output reg  vbl,
    output reg  video_vbl
);

wire [8:0] h_ofs = 0;
wire [8:0] HBL_START  = 256;
wire [8:0] HBL_END    = 0;
wire [8:0] HS_START   = HBL_START + 44 + $signed(hs_offset);
wire [8:0] HS_END     = HBL_START + 76 + $signed(hs_offset) + $signed(hs_width);
wire [8:0] HTOTAL     = 383;

wire [8:0] v_ofs = 0;
wire [8:0] VBL_START  = 241;
wire [8:0] VBL_END    = 17;
// CRT TEST 07: known-good ArcadeVGA target for this exact monitor/game.
// External raster: 384 x 262 total at 6 MHz = 59.637 Hz.
// 240-line external active window: lines 8..247.
// External VSYNC: 3-line front porch, 3-line sync, 16-line back porch.
// The game's own VBlank boundaries remain 241 -> 17 (224 active lines).
wire [8:0] VIDEO_VBL_START = 248;
wire [8:0] VIDEO_VBL_END   = 8;
wire [8:0] VS_START        = 251 + $signed(vs_offset);
wire [8:0] VS_END          = 254 + $signed(vs_offset) + $signed(vs_width);
wire [8:0] VTOTAL          = 261;

reg [8:0] v;
reg [8:0] h;

assign vc = v - v_ofs;
assign hc = h - h_ofs;

always @ (posedge clk) begin
    if (reset) begin
        h <= 0;
        v <= 0;

        hbl <= 0;
        vbl <= 0;
        video_vbl <= 1;

        hsync <= 0;
        vsync <= 0;
    end else if ( clk_pix == 1 ) begin 
        // counter
        if (h == HTOTAL) begin
            h <= 0;
            v <= v + 1'd1;

            if ( v == VTOTAL ) begin
                v <= 0;
            end
        end else begin
            h <= h + 1'd1;
        end

        // h signals
        if ( h == HBL_START ) begin
            hbl <= 1;
        end else if ( h == HBL_END ) begin
            hbl <= 0;
        end

        // Game VBlank: preserve original 224-line game window / IRQ behavior.
        if ( v == VBL_START ) begin
            vbl <= 1;
        end else if ( v == VBL_END ) begin
            vbl <= 0;
        end

        // External video blanking: expose a 240-line active raster to the display.
        if ( v == VIDEO_VBL_START ) begin
            video_vbl <= 1;
        end else if ( v == VIDEO_VBL_END ) begin
            video_vbl <= 0;
        end

        if ( v == (VS_START ) ) begin
            vsync <= 1;
        end else if ( v == (VS_END ) ) begin
            vsync <= 0;
        end

        if ( h == (HS_START ) ) begin
            hsync <= 1;
        end else if ( h == (HS_END ) ) begin
            hsync <= 0;
        end
    end
end

endmodule

