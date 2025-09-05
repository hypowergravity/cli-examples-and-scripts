

proc appendFiles { PDBfile CRDfile } {
    puts $PDBfile
    puts $CRDfile
    
    mol new $PDBfile type {pdb} first 0 last -1 step 1 waitfor all

    #echo "reading trajectory" $CRDfile
    mol addfile $CRDfile type {netcdf} first 0 last -1 step 1 waitfor all 0

    #measure box
    molinfo top set frame 0
    set all [atomselect 0 "noh"]
    set minmax [measure minmax $all]
    set vec [vecsub [lindex $minmax 1] [lindex $minmax 0]]
    puts $vec
    set nf [molinfo 0 get numframes]
    for {set i 0} {$i < $nf} {incr i} {
	    molinfo 0 set frame $i
	    molinfo 0 set {a b c} $vec
    }
    # write a snapshot with correct box size
    molinfo top set frame 0
    [atomselect top all] writepdb snapshot.pdb
    #animate write pdb snapshot.pdb beg 1 end 1 skip 1 waitfor 10 0

    set OUTfile "desmond_trj"
    set nf [expr [molinfo 0 get numframes] - 1]
    animate write dtr $OUTfile beg 1 end $nf skip 1 waitfor all 0

}
echo $argv
eval appendFiles $argv
exit
