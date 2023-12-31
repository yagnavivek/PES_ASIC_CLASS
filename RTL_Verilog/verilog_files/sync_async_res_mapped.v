/* Generated by Yosys 0.32+51 (git sha1 6405bbab1, gcc 12.3.0-1ubuntu1~22.04 -fPIC -Os) */

(* top =  1  *)
(* src = "sync_async_res.v:2.1-15.10" *)
module sync_async_res(clk, d, sres, ares, q);
  (* src = "sync_async_res.v:6.1-14.4" *)
  wire _0_;
  (* src = "sync_async_res.v:6.1-14.4" *)
  wire _1_;
  (* src = "sync_async_res.v:3.18-3.22" *)
  wire _2_;
  wire _3_;
  (* src = "sync_async_res.v:3.11-3.12" *)
  wire _4_;
  (* src = "sync_async_res.v:3.13-3.17" *)
  wire _5_;
  wire _6_;
  (* src = "sync_async_res.v:3.18-3.22" *)
  input ares;
  wire ares;
  (* src = "sync_async_res.v:3.7-3.10" *)
  input clk;
  wire clk;
  (* src = "sync_async_res.v:3.11-3.12" *)
  input d;
  wire d;
  (* src = "sync_async_res.v:4.13-4.14" *)
  output q;
  wire q;
  (* src = "sync_async_res.v:3.13-3.17" *)
  input sres;
  wire sres;
  sky130_fd_sc_hd__clkinv_1 _7_ (
    .A(_2_),
    .Y(_3_)
  );
  sky130_fd_sc_hd__nor2b_1 _8_ (
    .A(_5_),
    .B_N(_4_),
    .Y(_1_)
  );
  (* src = "sync_async_res.v:6.1-14.4" *)
  sky130_fd_sc_hd__dfrtp_1 _9_ (
    .CLK(clk),
    .D(_0_),
    .Q(q),
    .RESET_B(_6_)
  );
  assign _4_ = d;
  assign _5_ = sres;
  assign _0_ = _1_;
  assign _2_ = ares;
  assign _6_ = _3_;
endmodule
