# Some Desmond Molecular CLI

This repository contains some CLI and scripts of Schrödinger's Desmond molecular dynamics software. 

## Contents Overview

### Core Documentation Files

| File | Description |
|------|-------------|
| [`desmond_python_api.md`](./desmond_python_api.md) | Python API usage for trajectory analysis |
| [`trajectory_analysis.md`](./trajectory_analysis.md) | VMD to Desmond workflow and trajectory processing |
| [`job_management.md`](./job_management.md) | Job control, monitoring, and analysis commands |
| [`protein_preparation.md`](./protein_preparation.md) | Protein preparation using PrepWizard |
| [`glide_docking.md`](./glide_docking.md) | Glide docking setup and configuration |
| [`site_definition.md`](./site_definition.md) | Binding site definition syntax |

### Utility Scripts

| Script | Description |
|--------|-------------|
| [`convert_xtc_to_dcd_selected.tcl`](./convert_xtc_to_dcd_selected.tcl) | VMD script for trajectory format conversion |


### 1. Environment Setup
```bash
# Set up Schrödinger virtual environment
$SCHRODINGER/run schrodinger_virtualenv.py schrodinger.ve
source schrodinger.ve/bin/activate
```

## Useful Resources

- [Schrödinger Documentation](https://www.schrodinger.com/documentation)
- [Desmond MD Users Group](https://groups.google.com/g/desmond-md-users)
- [VMD Extensions](https://github.com/tonigi/vmd_extensions)

## Common Commands Quick Reference

```bash
# Job management
$SCHRODINGER/jobcontrol -list

# Analysis
$SCHRODINGER/run analyze_simulation.py <cms_file> <trajectory> <output.eaf> <input.eaf>

# Protein preparation
$SCHRODINGER/utilities/prepwizard <input.pdb> <output.mae>

# Format conversion
$SCHRODINGER/run -FROM mmshare amber_prm2cms.py -p <prmtop> -c <inpcrd> -o <output>
```

---
