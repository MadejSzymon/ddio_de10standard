transcript on
if ![file isdirectory CRC_DDIO_iputf_libs] {
	file mkdir CRC_DDIO_iputf_libs
}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

###### Libraries for IPUTF cores 
###### End libraries for IPUTF cores 
###### MIF file copy and HDL compilation commands for IPUTF cores 


vlog "C:/Users/delta/Documents/Intelprojects/CRC_DDIO_2/pll_sim/pll.vo"

vlog -vlog01compat -work work +incdir+C:/Users/delta/Documents/Intelprojects/CRC_DDIO_2 {C:/Users/delta/Documents/Intelprojects/CRC_DDIO_2/debouncer.v}
vlog -vlog01compat -work work +incdir+C:/Users/delta/Documents/Intelprojects/CRC_DDIO_2 {C:/Users/delta/Documents/Intelprojects/CRC_DDIO_2/state_change1.v}
vlog -vlog01compat -work work +incdir+C:/Users/delta/Documents/Intelprojects/CRC_DDIO_2 {C:/Users/delta/Documents/Intelprojects/CRC_DDIO_2/output_control1.v}
vlog -vlog01compat -work work +incdir+C:/Users/delta/Documents/Intelprojects/CRC_DDIO_2 {C:/Users/delta/Documents/Intelprojects/CRC_DDIO_2/FSM1.v}
vlog -vlog01compat -work work +incdir+C:/Users/delta/Documents/Intelprojects/CRC_DDIO_2 {C:/Users/delta/Documents/Intelprojects/CRC_DDIO_2/RAM1.v}
vlog -vlog01compat -work work +incdir+C:/Users/delta/Documents/Intelprojects/CRC_DDIO_2 {C:/Users/delta/Documents/Intelprojects/CRC_DDIO_2/top.v}
vlog -vlog01compat -work work +incdir+C:/Users/delta/Documents/Intelprojects/CRC_DDIO_2 {C:/Users/delta/Documents/Intelprojects/CRC_DDIO_2/DDIO_OUT.v}
vlog -vlog01compat -work work +incdir+C:/Users/delta/Documents/Intelprojects/CRC_DDIO_2 {C:/Users/delta/Documents/Intelprojects/CRC_DDIO_2/DDIO_IN.v}
vlog -vlog01compat -work work +incdir+C:/Users/delta/Documents/Intelprojects/CRC_DDIO_2 {C:/Users/delta/Documents/Intelprojects/CRC_DDIO_2/DDIO_OUT_clk.v}
vlog -vlog01compat -work work +incdir+C:/Users/delta/Documents/Intelprojects/CRC_DDIO_2 {C:/Users/delta/Documents/Intelprojects/CRC_DDIO_2/state_change2.v}
vlog -vlog01compat -work work +incdir+C:/Users/delta/Documents/Intelprojects/CRC_DDIO_2 {C:/Users/delta/Documents/Intelprojects/CRC_DDIO_2/FSM2.v}
vlog -vlog01compat -work work +incdir+C:/Users/delta/Documents/Intelprojects/CRC_DDIO_2 {C:/Users/delta/Documents/Intelprojects/CRC_DDIO_2/output_control2.v}
vlog -vlog01compat -work work +incdir+C:/Users/delta/Documents/Intelprojects/CRC_DDIO_2 {C:/Users/delta/Documents/Intelprojects/CRC_DDIO_2/RAM2.v}

vlog -vlog01compat -work work +incdir+C:/Users/delta/Documents/Intelprojects/CRC_DDIO_2 {C:/Users/delta/Documents/Intelprojects/CRC_DDIO_2/tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  tb

add wave *
view structure
view signals
run 100000 ns
