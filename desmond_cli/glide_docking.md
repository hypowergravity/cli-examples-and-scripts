# Glide Docking

## Running Glide

```bash
$SCHRODINGER/run xglide.py myjob.in
```

## Input File Configuration

```bash
cat > myjob.in <<EOF
RECEPTOR myrecep.maegz
LIGAND mylig.maegz,myrecep.maegz,REFPOSE
GRIDGEN_GRID_CENTER SELF
SKIP_DOCKING TRUE
EOF
```

### Parameters Explanation
- `RECEPTOR`: Path to receptor file in MAEGZ format
- `LIGAND`: Ligand file with reference pose
- `GRIDGEN_GRID_CENTER SELF`: Use receptor center for grid generation
- `SKIP_DOCKING TRUE`: Skip docking step (grid generation only)