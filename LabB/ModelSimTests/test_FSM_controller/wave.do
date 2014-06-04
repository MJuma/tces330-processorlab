onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /testRegisterFile/Clk
add wave -noupdate -radix hexadecimal /testRegisterFile/Rst
add wave -noupdate -radix hexadecimal /testRegisterFile/Wen
add wave -noupdate -radix hexadecimal /testRegisterFile/WAddr
add wave -noupdate -radix hexadecimal /testRegisterFile/WData
add wave -noupdate -radix hexadecimal /testRegisterFile/RAAddr
add wave -noupdate -radix hexadecimal /testRegisterFile/RBAddr
add wave -noupdate -radix hexadecimal /testRegisterFile/RAen
add wave -noupdate -radix hexadecimal /testRegisterFile/RBen
add wave -noupdate -radix hexadecimal /testRegisterFile/RAData
add wave -noupdate -radix hexadecimal /testRegisterFile/RBData
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 241
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {216 ns}
