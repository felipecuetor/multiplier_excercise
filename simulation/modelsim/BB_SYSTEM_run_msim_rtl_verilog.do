transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Felipe/git/multiplier_excercise/rtl {C:/Users/Felipe/git/multiplier_excercise/rtl/uDataPath.v}
vlog -vlog01compat -work work +incdir+C:/Users/Felipe/git/multiplier_excercise/rtl {C:/Users/Felipe/git/multiplier_excercise/rtl/SC_STATEMACHINE.v}
vlog -vlog01compat -work work +incdir+C:/Users/Felipe/git/multiplier_excercise/rtl {C:/Users/Felipe/git/multiplier_excercise/rtl/SC_RegSHIFTER.v}
vlog -vlog01compat -work work +incdir+C:/Users/Felipe/git/multiplier_excercise/rtl {C:/Users/Felipe/git/multiplier_excercise/rtl/SC_RegGENERAL.v}
vlog -vlog01compat -work work +incdir+C:/Users/Felipe/git/multiplier_excercise/rtl {C:/Users/Felipe/git/multiplier_excercise/rtl/SC_RegFIXED.v}
vlog -vlog01compat -work work +incdir+C:/Users/Felipe/git/multiplier_excercise/rtl {C:/Users/Felipe/git/multiplier_excercise/rtl/CC_MUXX.v}
vlog -vlog01compat -work work +incdir+C:/Users/Felipe/git/multiplier_excercise/rtl {C:/Users/Felipe/git/multiplier_excercise/rtl/CC_DECODER.v}
vlog -vlog01compat -work work +incdir+C:/Users/Felipe/git/multiplier_excercise/rtl {C:/Users/Felipe/git/multiplier_excercise/rtl/CC_ALU.v}
vlog -vlog01compat -work work +incdir+C:/Users/Felipe/git/multiplier_excercise {C:/Users/Felipe/git/multiplier_excercise/BB_SYSTEM.v}
vlog -vlog01compat -work work +incdir+C:/Users/Felipe/git/multiplier_excercise/rtl {C:/Users/Felipe/git/multiplier_excercise/rtl/WB_SYSTEM.v}

vlog -vlog01compat -work work +incdir+C:/Users/Felipe/git/multiplier_excercise/simulation/modelsim {C:/Users/Felipe/git/multiplier_excercise/simulation/modelsim/TB_SYSTEM.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  TB_SYSTEM

add wave *
view structure
view signals
run -all
