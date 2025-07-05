`timescale 1ns / 1ps

module top_module2(
    input clk,
    input rst,
    input btn_trigger_in,
    
    output hdmi_clk_n,
	output hdmi_clk_p,
	output [2:0] hdmi_tx_n,
	output [2:0] hdmi_tx_p
    );
    
    wire locked;
    wire pxl_clk;
    wire sys_clk;
    wire x5_pxl_clk;
    
    clk_wiz_0 cmt
        (
    
        .clk_out1(sys_clk),     // 100 Mhz
        .clk_out2(pxl_clk),     // 25Mhz
        .clk_out3(x5_pxl_clk),     // 125Mhz
        .reset(rst), 
        .locked(locked),
        .clk_in1(clk)      
       );

    //sync of rst with pxl clk
    reg [1:0] pxl_rst_sync;
    always @(posedge pxl_clk) begin
        if(locked) pxl_rst_sync <= {pxl_rst_sync[0], rst};
        else pxl_rst_sync <= 2'b11;
    end
    wire rst_pxl = (~locked) || pxl_rst_sync[1];
    
    //sync of rest with system clk
    reg [1:0] sys_rst_sync;
    always @(posedge sys_clk) begin
        if(locked) sys_rst_sync <= {sys_rst_sync[0], rst};
        else sys_rst_sync <= 2'b11;
    end
    wire rst_sys = (~locked) || sys_rst_sync[1];
    
    wire hsync;
    wire vsync;
    wire vde;
    reg[4:0] red;
    reg[5:0] green;
    reg[4:0] blue;
    
    wire[9:0] hcnt;
    wire[9:0] vcnt;
    
    wire[3:0] color_index;
 
    reg[3:0] fifo_enable_one_hot;
    wire [4:0] tile_index; //get from tile_map
    reg[4:0] line_index;
    //assign tile_index = 5'd1; // 
    wire [127:0] tile_line_data;
    reg r_en;
    reg wr_en_fifo;
    reg[5:0] timer_cnt;
    
    reg [15:0] frame_anim_cnt;
    reg btn_trigger; ///implement it
    wire [4:0] local_ptr = frame_anim_cnt[10:6];
    reg [1:0] btn_reg;
    always@(posedge pxl_clk) begin
        if(rst_pxl) begin
            btn_reg <= 2'b00;
        end
        else btn_reg <= {btn_reg[0], btn_trigger_in};
       
    end
    
  
    //ggeting sysn write_time_sys
    wire trigger;
    assign trigger = vcnt>=10'd0 && vcnt <= 10'd480 && (hcnt > 10'd700 && hcnt <10'd730); 
    reg[1:0] sync_shift_reg;
    always@(posedge sys_clk) begin
        if(rst_sys) sync_shift_reg <= 2'b00;
        else sync_shift_reg <= {sync_shift_reg[0], trigger};
    end
    
    wire write_time_sys = sync_shift_reg[1];
    
    //reg[4:0] tile_h_index;
    reg[3:0] tile_v_index;
    
    reg tile_map_en;
    always@(posedge sys_clk) begin
    
        if(write_time_sys) begin 
            line_index <= vcnt[4:0];
            tile_v_index <= vcnt[8:5];
            //tile_h_index <= timer_cnt
            tile_map_en <= 1'b1;
            timer_cnt <= timer_cnt +1'b1;
        end
        else begin
             r_en <= 1'b0;
             timer_cnt <= 5'd0;
             wr_en_fifo <= 1'b0;
             tile_map_en <= 1'b0;
        end
        
        if(timer_cnt == 5'd4) wr_en_fifo <= 1'b1;
        if(timer_cnt == 5'd2) r_en <= 1'b1;
    end
    
  
    wire[8:0] tile_addr;
    wire [5:0] ptr;  //from [0, 20] timer_cnt [0, 20]
    assign ptr = {1'b0, frame_anim_cnt[15:11]};
    wire [5:0] ptr_new;
    wire [5:0] ptr_sum;
    assign ptr_sum = (ptr + timer_cnt-6'd1);
    assign ptr_new = ptr_sum < 6'd21 ? ptr_sum : (ptr_sum-6'd21); 
    reg tile_wr_en;
    reg [8:0] tile_wr_addr;
    reg [4:0] tile_wr_data;
    assign tile_addr = (tile_v_index + ptr_new + (ptr_new<<1) + (ptr_new<<2) + (ptr_new<<3));
//    blk_mem_gen_2 tile_map (
//  .clka(sys_clk),    // input wire clka
//  .ena(tile_map_en||tile_wr_en),      // input wire ena
//  .wea(tile_wr_en),      // input wire [0 : 0] wea
//  .addra(tile_addr),  // input wire [8 : 0] addra
//  .dina(tile_wr_data),    // input wire [4 : 0] dina
//  .douta(tile_index)  // output wire [4 : 0] douta
//);

blk_mem_gen_2 tile_map (
  .clka(pxl_clk),    // input wire clka
  .ena(tile_wr_en),      // input wire ena
  .wea(tile_wr_en),      // input wire [0 : 0] wea
  .addra(tile_wr_addr),  // input wire [8 : 0] addra
  .dina(tile_wr_data),    // input wire [4 : 0] dina
  .clkb(sys_clk),    // input wire clkb
  .enb(tile_map_en),      // input wire enb
  .addrb(tile_addr),  // input wire [8 : 0] addrb
  .doutb(tile_index)  // output wire [4 : 0] doutb
);

    
    wire[9:0] tile_data_addr = {tile_index, line_index};
                                                                                                                                                                                                                                                                            
    blk_mem_gen_1 tile_data (
  .clka(sys_clk),    // input wire clka
  .ena(r_en),      // input wire ena
  .addra(tile_data_addr),  // input wire [9 : 0] addra
  .douta(tile_line_data)  // output wire [127 : 0] douta
);

    wire[3:0] out1, out2, out3, out4;
    wire empty1, empty2, empty3, empty4;
    wire prog_full1, prog_full2, prog_full3, prog_full4; 
    assign color_index = (fifo_enable_one_hot[0] ? out1:
                            fifo_enable_one_hot[1] ? out2:
                            fifo_enable_one_hot[2] ? out3 :
                            fifo_enable_one_hot[3] ? out4 : 4'b0000);
 fifo_generator_0 fifo1 (
    .rst(rst),                  // input wire rst
    .wr_clk(sys_clk),            // input wire wr_clk
    .rd_clk(pxl_clk),            // input wire rd_clk
    .din(tile_line_data[31:0]),                  // input wire [31 : 0] din
    .wr_en((~prog_full1) && wr_en_fifo),              // input wire wr_en
    .rd_en((~empty1) && fifo_enable_one_hot[0]),              // input wire rd_en
    .dout(out1),                // output wire [3 : 0] dout
    .full(),                // output wire full
    .empty(empty1),              // output wire empty
    .prog_full(prog_full1),      // output wire prog_full
    .wr_rst_busy(),  // output wire wr_rst_busy
    .rd_rst_busy()  // output wire rd_rst_busy
);

     fifo_generator_0 fifo2 (
    .rst(rst),                  // input wire rst
    .wr_clk(sys_clk),            // input wire wr_clk
    .rd_clk(pxl_clk),            // input wire rd_clk
    .din(tile_line_data[63:32]),                  // input wire [31 : 0] din
    .wr_en((~prog_full2) && wr_en_fifo),              // input wire wr_en
    .rd_en((~empty2) && fifo_enable_one_hot[1]),              // input wire rd_en
    .dout(out2),                // output wire [3 : 0] dout
    .full(),                // output wire full
    .empty(empty2),              // output wire empty
    .prog_full(prog_full2),      // output wire prog_full
    .wr_rst_busy(),  // output wire wr_rst_busy
    .rd_rst_busy()  // output wire rd_rst_busy
);

     fifo_generator_0 fifo3 (
    .rst(rst),                  // input wire rst
    .wr_clk(sys_clk),            // input wire wr_clk
    .rd_clk(pxl_clk),            // input wire rd_clk
    .din(tile_line_data[95:64]),                  // input wire [31 : 0] din
    .wr_en((~prog_full3) && wr_en_fifo),              // input wire wr_en
    .rd_en((~empty3) && fifo_enable_one_hot[2]),              // input wire rd_en
    .dout(out3),                // output wire [3 : 0] dout
    .full(),                // output wire full
    .empty(empty3),              // output wire empty
    .prog_full(prog_full3),      // output wire prog_full
    .wr_rst_busy(),  // output wire wr_rst_busy
    .rd_rst_busy()  // output wire rd_rst_busy
);

     fifo_generator_0 fifo4 (
    .rst(rst),                  // input wire rst
    .wr_clk(sys_clk),            // input wire wr_clk
    .rd_clk(pxl_clk),            // input wire rd_clk
    .din(tile_line_data[127:96]),                  // input wire [31 : 0] din
    .wr_en((~prog_full4) && wr_en_fifo),              // input wire wr_en
    .rd_en((~empty4) && fifo_enable_one_hot[3]),              // input wire rd_en
    .dout(out4),                // output wire [3 : 0] dout
    .full(),                // output wire full
    .empty(empty4),              // output wire empty
    .prog_full(prog_full4),      // output wire prog_full
    .wr_rst_busy(),  // output wire wr_rst_busy
    .rd_rst_busy()  // output wire rd_rst_busy
);
    //read fsm
    parameter IDLE    = 3'd0,
          STATE_1 = 3'd1,
          STATE_2 = 3'd2,
          STATE_3 = 3'd3,
          STATE_4 = 3'd4;
          
    reg [2:0] curr, next;
    reg[3:0] internal_cnt;
    
    wire vde_new = (vcnt <= 10'd480) && ((hcnt <= 10'd680) || ((hcnt+local_ptr) >=10'd797));
    always@(posedge pxl_clk) begin
    if(rst_pxl || ~vde_new) begin
        curr <= IDLE;
        internal_cnt <= 4'd0;
        fifo_enable_one_hot <= 4'b0000;
    end else begin
        curr <= next;

        // Reset or increment internal counter
        if (next != curr)
            internal_cnt <= 4'd1;
        else
            internal_cnt <= internal_cnt + 1;

        case (next)
            STATE_1: fifo_enable_one_hot <= 4'b0001;
            STATE_2: fifo_enable_one_hot <= 4'b0010;
            STATE_3: fifo_enable_one_hot <= 4'b0100;
            STATE_4: fifo_enable_one_hot <= 4'b1000;
            default: fifo_enable_one_hot <= 4'b0000;
        endcase
    end
end
    
    
    always @(*) begin
    // default assignment to prevent latches
    next = curr;

    case (curr)
        IDLE: begin
            if (vde_new) //write enable
                next = STATE_1;
                
            else next = IDLE;
        end

        STATE_1: begin
                if(internal_cnt == 4'd8) next = STATE_2;
                else next = STATE_1;
        end
        
        STATE_2: begin
                if(internal_cnt == 4'd8) next = STATE_3;
                else next = STATE_2;
        end
        
        STATE_3: begin
                if(internal_cnt == 4'd8) next = STATE_4;
                else next = STATE_3;
        end
        
        STATE_4: begin
                if(internal_cnt == 4'd8) next = STATE_1;
                else next = STATE_4;
        end
        
        default: next  = IDLE; // safety
    endcase
end


//  reg[18:0] bias;
//    always@(posedge pxl_clk)begin
//        if(rst_pxl) bias <= 18'd0;
//        else if(vcnt == 10'd485) bias <= bias + 18'd1;
//        else bias <= bias;
//    end
    
//////bacjkround test
//wire [18:0] addra;
//wire [3:0] douta;
wire [15:0] RGB2;
//assign addra = (vcnt << 7) + (vcnt << 9) + hcnt + (bias>>10);
//blk_mem_gen_3 bg (
//  .clka(pxl_clk),    // input wire clka
//  .ena(vde),      // input wire ena
//  .addra(addra),  // input wire [18 : 0] addra
//  .douta(douta)  // output wire [3 : 0] douta
//);

//blk_mem_gen_4 your_instance_name (
//  .clka(pxl_clk),    // input wire clka
//  .ena(vde),      // input wire ena
//  .addra(douta),  // input wire [3 : 0] addra
//  .douta(RGB2)  // output wire [15 : 0] douta
//);
///
reg update_tile_trigger;
wire [15:0] frame_anim_cnt_1 = frame_anim_cnt + 6'd32;
always@(posedge pxl_clk) begin
    if(rst_pxl) begin 
        frame_anim_cnt <= 16'd0;
        update_tile_trigger <= 1'b0;
        //btn_trigger <= 1'b1;
        end
    //else if(btn_reg[1]==1'b1) btn_trigger <= 1'b1;
    //else if(vcnt == 10'd485 && hcnt == 10'd2) begin
        //if(btn_trigger == 1'b1) begin
        //btn_trigger <= 1'b1;
        //if(frame_anim_cnt_1[15:11] == 5'd21) frame_anim_cnt <= {5'd0, frame_anim_cnt_1[10:0]};
        //else frame_anim_cnt <= frame_anim_cnt_1;
        //end
        //else frame_anim_cnt <= {frame_anim_cnt[15:6], 6'd0};
    //end
    
    else if(vcnt == 10'd485 && hcnt == 10'd2 && frame_anim_cnt_1[15:11] == 5'd21) begin
        frame_anim_cnt <= {5'd0, frame_anim_cnt_1[10:0]};
    end
    else if(vcnt == 10'd485 && hcnt == 10'd2)begin
        frame_anim_cnt <= frame_anim_cnt_1;
        if(frame_anim_cnt_1[10:6] == 5'd0) update_tile_trigger <= 1'b1;
        else update_tile_trigger <= 1'b0;
        
    end
    
    //if(btn_reg[1]==1'b1) btn_trigger <= 1'b1;
end


//logic to gen new tile line
wire o1, o21, o22, o23, o24, o25, o31, o32, o33, o34;
//whether to draw
lfsr l1(
    .clk(pxl_clk),
    .rst(rst_pxl),
    .seed(16'd205),
    .res(o1)
);

lfsr l21(
    .clk(pxl_clk),
    .rst(rst_pxl),
    .seed(16'd255),
    .res(o21)
);

lfsr l22(
    .clk(pxl_clk),
    .rst(rst_pxl),
    .seed(16'd5),
    .res(o22)
);

lfsr l23(
    .clk(pxl_clk),
    .rst(rst_pxl),
    .seed(16'd30),
    .res(o23)
);

lfsr l24(
    .clk(pxl_clk),
    .rst(rst_pxl),
    .seed(16'd25),
    .res(o24)
);

lfsr l25(
    .clk(pxl_clk),
    .rst(rst_pxl),
    .seed(16'd97),
    .res(o25)
);


lfsr l31(
    .clk(pxl_clk),
    .rst(rst_pxl),
    .seed(16'd205),
    .res(o31)
);
lfsr l32(
    .clk(pxl_clk),
    .rst(rst_pxl),
    .seed(16'd2),
    .res(o32)
);
lfsr l33(
    .clk(pxl_clk),
    .rst(rst_pxl),
    .seed(16'd7),
    .res(o33)
);
lfsr l34(
    .clk(pxl_clk),
    .rst(rst_pxl),
    .seed(16'd13),
    .res(o34)
);

reg [4:0] old_ht = 5'd10;
reg [3:0] old_data = 4'b0000;
wire [4:0] new_height_start = (old_ht >= 5'd3) ? (old_ht - 5'd1) : 5'd2;
wire [4:0] random_bias;
wire [4:0] rand_block_temp_no;
wire [1:0] rand_block_id;
wire [1:0] rand_block_id_final;
wire to_draw_or_not;
assign rand_block_temp_no = {o21, o22, o23, o24, o25};
assign random_bias = {1'b0, o31, o32, o33, o34}; 
wire [4:0] random_new_ht;
wire [5:0] rand_new_ht_temp;
assign rand_new_ht_temp = (new_height_start + random_bias);
assign random_new_ht = new_height_start + (rand_new_ht_temp % (5'd13-new_height_start));
//assign random_new_ht = rand_new_ht_temp <= 5'd12 ? rand_new_ht_temp : ((rand_new_ht_temp + new_height_start < 5'd25) ? );
assign rand_block_id = (rand_block_temp_no == 5'd31) ? 2'd3 : ((rand_block_temp_no >= 5'd26) ? 2'd2 : ((rand_block_temp_no >= 5'd16) ? 2'd1 : 2'd0) );
reg [1:0] e_t_allow; //empty_allowed_thorn_allowed;

always @(*) begin
case (old_data)
    4'b0000 : e_t_allow = 2'b11;
    4'b0001 : e_t_allow = 2'b11;
    4'b0010 : e_t_allow = 2'b00;
    4'b0100 : e_t_allow = 2'b11;
    4'b1000 : e_t_allow = 2'b00;
    4'b1111 : e_t_allow = 2'b00;
    4'b0101 : e_t_allow = 2'b00;
    default : e_t_allow = 2'b00;
endcase
end

assign to_draw_or_not = e_t_allow[1] == 1'b1 ? o1 : 1'b1;
assign rand_block_id_final = e_t_allow[0] == 1'b1 ? rand_block_id : ((rand_block_id == 2'd3 || rand_block_id == 2'd1) ? rand_block_id : 2'd0);

//update old het and data
//get the tile_data 5 bit every fsm_cnt
//setup init data 
//setup tiles
reg [3:0] fsm_cnt;
reg [4:0] tile_data_in;

reg [4:0] to_be_new_ht;
reg [3:0] to_be_new_data;
always @(*) begin
    if(to_draw_or_not) begin
        //dual grass block
        if(rand_block_id_final == 2'd1) begin
            if(fsm_cnt == random_new_ht) tile_data_in = 5'd1; //grass top 
            else if(fsm_cnt == random_new_ht+5'd1) tile_data_in = 5'd2; //grass bottom
            else tile_data_in = 5'd0;
            to_be_new_ht = random_new_ht;
            to_be_new_data = 4'b0000;
        end
        //triple rcck block
        else if(rand_block_id_final == 2'd0) begin
            if(fsm_cnt == random_new_ht) tile_data_in = 5'd3;//rock top 
            else if(fsm_cnt == random_new_ht + 5'd1) tile_data_in = 5'd4; //rock mid
            else if(fsm_cnt == random_new_ht + 5'd2) tile_data_in = 5'd5; //rock bottom
            else tile_data_in = 5'd0;
            to_be_new_ht = random_new_ht;
            to_be_new_data = 4'b0000;
        end
        //thorn block
        else if(rand_block_id_final == 2'd2) begin
            if(fsm_cnt == random_new_ht) tile_data_in = 5'd6; //thorn top 
            else if(fsm_cnt == random_new_ht+5'd1) tile_data_in = 5'd7; //thorn bottom
            else tile_data_in = 5'd0;
            to_be_new_ht = random_new_ht;
            if(old_data == 4'b0000) to_be_new_data = 4'b0100;
            else if(old_data == 4'b0001) to_be_new_data = 4'b1111;
            else if(old_data == 4'b0100) to_be_new_data = 4'b1000;
            else to_be_new_data = 4'b0000;
        end
        //ladder block
        else begin
            if(random_new_ht < 5'd5) tile_data_in = 5'd0;
            else if(fsm_cnt == random_new_ht) tile_data_in = 5'd8;//ladder bottom
            else if(fsm_cnt == random_new_ht - 5'd1) tile_data_in = 5'd9; //ladder bottom1
            else if(fsm_cnt == random_new_ht - 5'd2) tile_data_in = 5'd10; //ladder bottom 2
            else if(fsm_cnt == random_new_ht - 5'd3) tile_data_in = 5'd11; //ladder top
            else tile_data_in = 5'd0;
            to_be_new_ht = random_new_ht + 5'd3;
            to_be_new_data = 4'b0000;
            
        end
    end
    else begin 
    tile_data_in = 5'd0;
    to_be_new_ht = old_ht;
    case (old_data)
    4'b0000 : to_be_new_data = 4'b0001;
    4'b0001 : to_be_new_data = 4'b0010;
    4'b0100 : to_be_new_data = 4'b0101;
    default : to_be_new_data = 4'b0000;
endcase
    end
end


always @(posedge pxl_clk) begin
    if(rst_pxl) begin
        old_ht <= 4'd10;
        old_data <= 4'b0000;
    end
    if(fsm_cnt == 4'd15) begin
        //update ht and old data
        old_ht <= to_be_new_ht;
        old_data <= to_be_new_data;
        
    end
end
//end logic



reg current_1, next_1;

wire [8:0] tile_wr_addr_wire;
wire [5:0] ptr__ = ptr - 1'b1;
//wire [4:0] tile_data_in;
assign tile_wr_addr_wire = (fsm_cnt + ptr__ + (ptr__<<1) + (ptr__<<2) + (ptr__<<3));
//assign tile_data_in = ptr__[0] ? 5'd0 : 5'd1;
always@(posedge pxl_clk) begin
    if(rst_pxl)begin
        tile_wr_en <= 1'b0;
        tile_wr_addr <= 9'd0;
        current_1 <= 1'b0;
        fsm_cnt <= 4'b0;
    end
    else begin
        current_1 <= next_1;
        
        if(next_1 == 1'b1) begin
            fsm_cnt <= fsm_cnt + 1'b1;
            tile_wr_en <= 1'b1;
            tile_wr_addr <= tile_wr_addr_wire;
            tile_wr_data <= tile_data_in;
        end
        else begin
            fsm_cnt <= 4'd0;
            tile_wr_en <= 1'b0;
            tile_wr_addr <= 9'd0;
            tile_wr_data <= 5'd0;
        end
    end
end

always @(*) begin
    next_1 = current_1;
    case(current_1)
        1'd0: begin
            if(update_tile_trigger) next_1 = 1'b1;
            else next_1 = 1'b0;
        end
        
        1'b1: begin
            if(fsm_cnt < 4'd15) next_1 = 1'b1;
            else next_1 = 1'b0;
        end
        default : next_1 = 1'b0;
    
    endcase
end



bg bg1 (
    .clk(pxl_clk),
    .rst(rst_pxl),
    .x_pix(hcnt),
    .y_pix(vcnt),
    .btn_trigger(btn_trigger),
    .rgb_out(RGB2)

);
    
    //assign addra = hcnt[9:5];
    wire[15:0] RGB_temp;
    blk_mem_gen_0 clut (
        .clka(pxl_clk),    // input wire clka
        .ena(~rst_pxl),      // input wire ena
        .addra(color_index),  // input wire [3 : 0] addra
        .douta(RGB_temp)  // output wire [15 : 0] douta    
    );
    
    wire in_view;
    wire [15:0] player_color;
    wire [15:0] RGB;
    assign RGB = in_view ? player_color : RGB_temp;
    player p1(
        .clk(pxl_clk),
        .rst(pxl_rst),
        .hcnt(hcnt),
        .vcnt(vcnt),
        .RGB(RGB_temp),
        .in_view(in_view),
        .player_color(player_color)
        
    );
    always@(posedge pxl_clk) begin
        if(rst_pxl) begin
            red <= 5'd0;
            green <= 6'd0;
            blue <= 5'd0;
        end
        else begin
            red <= ((RGB == 16'h5555) || (RGB == 16'h3666) || (RGB == 16'h0320) )? RGB2[15:11] : RGB[15:11];
            green <= ((RGB == 16'h5555) || (RGB == 16'h3666) || (RGB == 16'h0320) )? RGB2[10:5] : RGB[10:5];
            blue <= ((RGB == 16'h5555) || (RGB == 16'h3666) || (RGB == 16'h0320) )? RGB2[4:0] : RGB[4:0];
        end
    end
    
    
    VGA vga1(
        
    .pxl_clk(pxl_clk),
    .rst(rst_pxl),
    .hcnt(hcnt),
    .vcnt(vcnt),
    .ven(vde),
    .hsync(hsync),
    .vsync(vsync)
    
    );
    
    
    
    //vga to hdmi
    hdmi_tx_0 vga2hdmi (
  .pix_clk(pxl_clk),                // input wire pix_clk
  .pix_clkx5(x5_pxl_clk),            // input wire pix_clkx5
  .pix_clk_locked(locked),  // input wire pix_clk_locked
  .rst(rst_pxl),                        // input wire rst
  .red(red),                        // input wire [4 : 0] red
  .green(green),                    // input wire [5 : 0] green
  .blue(blue),                      // input wire [4 : 0] blue
  .hsync(hsync),                    // input wire hsync
  .vsync(vsync),                    // input wire vsync
  .vde(vde),                        // input wire vde
  .aux0_din(4'b0000),              // input wire [3 : 0] aux0_din
  .aux1_din(4'b0000),              // input wire [3 : 0] aux1_din
  .aux2_din(4'b0000),              // input wire [3 : 0] aux2_din
  .ade(1'b0),                        // input wire ade
  .TMDS_CLK_P(hdmi_clk_p),          // output wire TMDS_CLK_P
  .TMDS_CLK_N(hdmi_clk_n),          // output wire TMDS_CLK_N
  .TMDS_DATA_P(hdmi_tx_p),        // output wire [2 : 0] TMDS_DATA_P
  .TMDS_DATA_N(hdmi_tx_n)
);
    wire[15:0] test;
    wire[3:0] out_vec;
    assign test = {red, green, blue};
    assign out_vec = {out4, out3, out2, out1};
    
    wire[3:0] empty_vec;
    wire[3:0] prog_full_vec;
    assign empty_vec = {empty4, empty3, empty2, empty1};
    assign prog_full_vec = {prog_full4, prog_full3, prog_full2, prog_full1};
    wire [127:0] data_cnt = {frame_anim_cnt[15:0], ptr_new, tile_addr, fifo_enable_one_hot, out1, out2, out3, out4, 83'd0};


ila_0 il0 (
	.clk(sys_clk), // input wire clk


	.probe0(hcnt), // input wire [9:0]  probe0  
	.probe1(vcnt), // input wire [9:0]  probe1 
	.probe2(ven), // input wire [0:0]  probe2 
	.probe3(ptr), // input wire [4:0]  probe3 
	.probe4(ptr_new), // input wire [4:0]  probe4 
	.probe5(tile_addr), // input wire [8:0]  probe5 
	.probe6(tile_map_en), // input wire [0:0]  probe6 
	.probe7(wr_en_fifo), // input wire [0:0]  probe7 
	.probe8(prog_full_vec), // input wire [3:0]  probe8 
	.probe9(pxl_clk), // input wire [0:0]  probe9
	.probe10(timer_cnt),
	.probe11(tile_line_data)
);


//ila_1 il1 (
//	.clk(pxl_clk), // input wire clk


//	.probe0(hcnt), // input wire [9:0]  probe0  
//	.probe1(vcnt), // input wire [9:0]  probe1 
//	.probe2(vde), // input wire [0:0]  probe2 
//	.probe3(test), // input wire [15:0]  probe3 
//	.probe4(frame_anim_cnt), // input wire [15:0]  probe4 
//	.probe5(vde_new), // input wire [0:0]  probe5 
//	.probe6(fifo_enable_one_hot), // input wire [3:0]  probe6 
//	.probe7(empty_vec), // input wire [3:0]  probe7 
//	.probe8(ptr_new) // input wire [4:0]  probe8
//);


endmodule
