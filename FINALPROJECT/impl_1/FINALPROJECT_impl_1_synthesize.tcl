if {[catch {

# define run engine funtion
source [file join {C:/lscc/radiant/2023.1} scripts tcl flow run_engine.tcl]
# define global variables
global para
set para(gui_mode) 1
set para(prj_dir) "Z:/es4/ES4FinalProject-gamestates-NEED-TO-TEST/FINALPROJECT"
# synthesize IPs
# synthesize VMs
# propgate constraints
file delete -force -- FINALPROJECT_impl_1_cpe.ldc
run_engine_newmsg cpe -f "FINALPROJECT_impl_1.cprj" "mypll.cprj" -a "iCE40UP"  -o FINALPROJECT_impl_1_cpe.ldc
# synthesize top design
file delete -force -- FINALPROJECT_impl_1.vm FINALPROJECT_impl_1.ldc
run_engine_newmsg synthesis -f "FINALPROJECT_impl_1_lattice.synproj"
run_postsyn [list -a iCE40UP -p iCE40UP5K -t SG48 -sp High-Performance_1.2V -oc Industrial -top -w -o FINALPROJECT_impl_1_syn.udb FINALPROJECT_impl_1.vm] "Z:/es4/ES4FinalProject-gamestates-NEED-TO-TEST/FINALPROJECT/impl_1/FINALPROJECT_impl_1.ldc"

} out]} {
   runtime_log $out
   exit 1
}
