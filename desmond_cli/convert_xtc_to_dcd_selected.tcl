

proc appendFiles { PDBfile XTCfile } {
    puts $PDBfile
    puts $XTCfile
    
    mol new $PDBfile type {pdb} first 0 last -1 step 1 waitfor all

    #echo "reading trajectory" $XTCfile
    mol addfile $XTCfile type {xtc} first 0 last -1 step 1 waitfor all 0

    #measure box
    molinfo top set frame 5
    set all [atomselect 0 "{protein} or {resname UNK} or {water within 5 of (resname UNK)}"]
    set minmax [measure minmax $all]
    set vec [vecsub [lindex $minmax 1] [lindex $minmax 0]]
    puts $vec
    set nf [molinfo 0 get numframes]
    for {set i 0} {$i < $nf} {incr i} {
	    molinfo 0 set frame $i
	    molinfo 0 set {a b c} $vec
    }
    # write a snapshot with correct box size
    molinfo top set frame 5
    [atomselect top "{protein} or {resname UNK} or {water within 5 of (resname UNK)}"] writepdb snapshot.pdb
    #animate write pdb snapshot.pdb beg 1 end 1 skip 1 waitfor 10 0

    set OUTfile "traj.dcd"
    set temp [atomselect 0 "{protein} or {resname UNK} or {water within 5 of (resname UNK)}"]
    set nf [expr [molinfo 0 get numframes] - 1]
    animate write dcd $OUTfile beg 1 end $nf sel $temp skip 1 waitfor all 0


}
echo $argv
eval appendFiles $argv
exit
