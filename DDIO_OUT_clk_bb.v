// megafunction wizard: %ALTDDIO_OUT%VBB%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: ALTDDIO_OUT 

// ============================================================
// File Name: DDIO_OUT_clk.v
// Megafunction Name(s):
// 			ALTDDIO_OUT
//
// Simulation Library Files(s):
// 			altera_mf
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 20.1.1 Build 720 11/11/2020 SJ Lite Edition
// ************************************************************

//Copyright (C) 2020  Intel Corporation. All rights reserved.
//Your use of Intel Corporation's design tools, logic functions 
//and other software and tools, and any partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Intel Program License 
//Subscription Agreement, the Intel Quartus Prime License Agreement,
//the Intel FPGA IP License Agreement, or other applicable license
//agreement, including, without limitation, that your use is for
//the sole purpose of programming logic devices manufactured by
//Intel and sold by Intel or its authorized distributors.  Please
//refer to the applicable agreement for further details, at
//https://fpgasoftware.intel.com/eula.

module DDIO_OUT_clk (
	datain_h,
	datain_l,
	oe,
	outclock,
	dataout);

	input	[0:0]  datain_h;
	input	[0:0]  datain_l;
	input	  oe;
	input	  outclock;
	output	[0:0]  dataout;

endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone V"
// Retrieval info: CONSTANT: EXTEND_OE_DISABLE STRING "OFF"
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Cyclone V"
// Retrieval info: CONSTANT: INVERT_OUTPUT STRING "OFF"
// Retrieval info: CONSTANT: LPM_HINT STRING "UNUSED"
// Retrieval info: CONSTANT: LPM_TYPE STRING "altddio_out"
// Retrieval info: CONSTANT: OE_REG STRING "UNREGISTERED"
// Retrieval info: CONSTANT: POWER_UP_HIGH STRING "OFF"
// Retrieval info: CONSTANT: WIDTH NUMERIC "1"
// Retrieval info: USED_PORT: datain_h 0 0 1 0 INPUT NODEFVAL "datain_h[0..0]"
// Retrieval info: CONNECT: @datain_h 0 0 1 0 datain_h 0 0 1 0
// Retrieval info: USED_PORT: datain_l 0 0 1 0 INPUT NODEFVAL "datain_l[0..0]"
// Retrieval info: CONNECT: @datain_l 0 0 1 0 datain_l 0 0 1 0
// Retrieval info: USED_PORT: dataout 0 0 1 0 OUTPUT NODEFVAL "dataout[0..0]"
// Retrieval info: CONNECT: dataout 0 0 1 0 @dataout 0 0 1 0
// Retrieval info: USED_PORT: oe 0 0 0 0 INPUT NODEFVAL "oe"
// Retrieval info: CONNECT: @oe 0 0 0 0 oe 0 0 0 0
// Retrieval info: USED_PORT: outclock 0 0 0 0 INPUT_CLK_EXT NODEFVAL "outclock"
// Retrieval info: CONNECT: @outclock 0 0 0 0 outclock 0 0 0 0
// Retrieval info: GEN_FILE: TYPE_NORMAL DDIO_OUT_clk.v TRUE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL DDIO_OUT_clk.qip TRUE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL DDIO_OUT_clk.bsf TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL DDIO_OUT_clk_inst.v TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL DDIO_OUT_clk_bb.v TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL DDIO_OUT_clk.inc TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL DDIO_OUT_clk.cmp TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL DDIO_OUT_clk.ppf TRUE FALSE
// Retrieval info: LIB_FILE: altera_mf