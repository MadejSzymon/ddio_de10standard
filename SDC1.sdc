create_clock -name board_clk -period 20.000 [get_ports {board_clk}]
create_generated_clock -source {pll_inst|pll_inst|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|refclkin} -divide_by 2 -multiply_by 12 -duty_cycle 50.00 -name {pll_inst|pll_inst|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]} {pll_inst|pll_inst|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]}
create_generated_clock -source {pll_inst|pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|vco0ph[0]} -divide_by 12 -duty_cycle 50.00 -name {tx_clk} {pll_inst|pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}
create_generated_clock -source {pll_inst|pll_inst|altera_pll_i|general[1].gpll~PLL_OUTPUT_COUNTER|vco0ph[0]} -divide_by 12 -phase 90.00 -duty_cycle 50.00 -name {DDIO_clk} {pll_inst|pll_inst|altera_pll_i|general[1].gpll~PLL_OUTPUT_COUNTER|divclk}
set_false_path -from [get_ports {btn_SEND btn pll_rst}]
set_false_path -to [get_ports {LED_alert_2a LED_alert_2b LED}]


#DDIO_OUT constrains
create_generated_clock -name clkout -source {pll_inst|pll_inst|altera_pll_i|general[1].gpll~PLL_OUTPUT_COUNTER|divclk} [get_ports {clkout}]

set tSetup 1
set tHold 1
set_output_delay -clock {clkout} -max $tSetup [get_ports {dataout*}]
set_output_delay -clock {clkout} -min -$tHold [get_ports {dataout*}]
set_output_delay -clock {clkout} -clock_fall -max $tSetup [get_ports {dataout*}] -add_delay
set_output_delay -clock {clkout} -clock_fall -min -$tHold [get_ports {dataout*}] -add_delay
set_false_path -setup -rise_from [get_clocks  {tx_clk}] -fall_to [get_clocks {clkout}]
set_false_path -hold -rise_from [get_clocks  {tx_clk}] -rise_to [get_clocks {clkout}]
set_false_path -setup -fall_from [get_clocks  {tx_clk}] -rise_to [get_clocks {clkout}]
set_false_path -hold -fall_from [get_clocks  {tx_clk}] -fall_to [get_clocks {clkout}]
set_false_path -to [get_ports {clkout}]

#DDIO_IN constrains
create_clock -name clkin -period 40.000 -waveform {10 30} [get_ports {clkin}]

set_input_delay -add_delay -max -clock [get_clocks {tx_clk}] 1 [get_ports {datain*}]
set_input_delay -add_delay -min -clock [get_clocks {tx_clk}] -1 [get_ports {datain*}]
set_input_delay -add_delay -max -clock_fall -clock [get_clocks {tx_clk}] 1 [get_ports {datain*}]
set_input_delay -add_delay -min -clock_fall -clock [get_clocks {tx_clk}] -1 [get_ports {datain*}]

set_false_path -setup -rise_from [get_clocks {tx_clk}] -fall_to [get_clocks {clkin}]
set_false_path -setup -fall_from [get_clocks {tx_clk}] -rise_to [get_clocks {clkin}]
set_false_path -hold -rise_from [get_clocks {tx_clk}] -rise_to [get_clocks {clkin}]
set_false_path -hold -fall_from [get_clocks {tx_clk}] -fall_to [get_clocks {clkin}]
