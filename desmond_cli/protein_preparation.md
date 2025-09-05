# Protein Preparation with Schrödinger

## Basic Protein Preparation

### Launch PrepWizard GUI
```bash
$SCHRODINGER/utilities/prepwizard
```

### Command Line Usage

#### Multi-processor Preparation
```bash
$SCHRODINGER/utilities/prepwizard -NJOBS 3 -HOST MY_HOST:3 3_pdb.mae 3_pdb_prep.mae
```
- `-NJOBS 3`: Use 3 processors
- `-HOST MY_HOST:3`: Specify host and processor count

#### Full Preparation Pipeline
```bash
$SCHRODINGER/utilities/prepwizard -rehtreat -fillsidechains -pH neutral -minimize_adj_h -epik_pH EPIK_PH -rmsd 0.3 myc-new.pdb myc-new.mae
```

#### Simplified Preparation
```bash
$SCHRODINGER/utilities/prepwizard -rehtreat -pH neutral -minimize_adj_h -epik_pH EPIK_PH -rmsd 0.3 myc-new.pdb myc-new.mae
```

### Parameter Explanation
- `-rehtreat`: Retreat problematic structures
- `-fillsidechains`: Fill missing side chains
- `-pH neutral`: Set pH to neutral
- `-minimize_adj_h`: Minimize adjacent hydrogens
- `-epik_pH EPIK_PH`: Use Epik for pH calculations
- `-rmsd 0.3`: RMSD threshold for minimization

## Protein-Ligand Splitting

### Split Complex into Components
```bash
$SCHRODINGER/run pv_convert.py -v -mode {split_pv} input_files myc-new.mae
```

This command separates the prepared complex into individual protein and ligand files.