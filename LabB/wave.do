onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /testProcessor/Clk
add wave -noupdate -radix hexadecimal /testProcessor/Reset
add wave -noupdate -radix hexadecimal /testProcessor/ir_instruction
add wave -noupdate -radix hexadecimal /testProcessor/pc_address
add wave -noupdate -radix hexadecimal /testProcessor/state_o
add wave -noupdate -radix hexadecimal /testProcessor/alu_a
add wave -noupdate -radix hexadecimal /testProcessor/alu_b
add wave -noupdate -radix hexadecimal /testProcessor/alu_out
add wave -noupdate -radix hexadecimal /testProcessor/mux_out
add wave -noupdate -radix hexadecimal /testProcessor/rq0
add wave -noupdate -radix hexadecimal /testProcessor/rf_w_addr_out
add wave -noupdate -radix hexadecimal /testProcessor/rf_ra_addr_out
add wave -noupdate -radix hexadecimal /testProcessor/rf_rb_addr_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {679 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1 ns}
