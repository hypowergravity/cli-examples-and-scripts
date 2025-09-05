# Desmond Trajectory Analysis

## VMD to Desmond Workflow

### Step 1: Convert Trajectory Format
```bash
vmd -dispdev text -e convert_crd_to_dtr.tcl -args $pdb $crd
```

### Step 2: Create Python Conversion Script
```bash
$SCHRODINGER/run python3 convert_pdb_to_mae.py
```

### Step 3: Set up Index File
```bash
cat > desmond-out.idx <<EOF
structure = desmond-out.cms
trajectory = desmond_trj
EOF
```

### Step 4: Rebuild CMS File
```bash
$SCHRODINGER/run rebuild_cms.py -make_comp_ct full_system.mae -force_field OPLS_2005 desmond-out.cms
```

### Step 5: Analysis Commands
```bash
$SCHRODINGER/run event_analysis.py desmond-out.cms -l auto
$SCHRODINGER/run analyze_trajectories.py desmond-out.cms desmond-in.eaf desmond-out.eaf
```

## Detailed VMD to MAE Conversion

### Preparation Steps

1. Load protein.prmtop and protein.xtc in VMD
2. Save frame 0 as MAE file

### Residue Renumbering (if needed)
```tcl
# Load VMD extensions
source https://raw.githubusercontent.com/tonigi/vmd_extensions/master/VMDextensions.tcl

# Select and renumber residues
set sel [atomselect top "all"]
renumber atomselect 3  # starting number
```

### Create Conversion Script
```bash
cat > convert_pdb_to_mae.py <<EOF
import schrodinger.structure as structure

st1 = structure.StructureReader('frame_0.mae')
st = next(st1)
st.property["s_ffio_ct_type"] = "full_system"
st.property["s_chorus_trajectory_file"] = "desmond-out.idx"

st.write('full_system.mae')
EOF
```

### Execute Conversion
```bash
$SCHRODINGER/run python3 convert_pdb_to_mae.py
```

### Final Analysis
```bash
# Load full_system.mae and rebuild CMS file using Model System Generation (Desmond)
$SCHRODINGER/run event_analysis.py analyze desmond_rebuildsystem.cms
$SCHRODINGER/run analyze_simulation.py desmond_rebuildsystem.cms protein.xtc desmond_rebuildsystem.cms-out.eaf desmond_rebuildsystem.cms-in.eaf
```

## Reference
- [Desmond MD Users Group Discussion](https://groups.google.com/g/desmond-md-users/c/vy1VvhBMyi8)