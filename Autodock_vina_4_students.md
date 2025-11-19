# Docking Tutorial using AutoDock Vina  

---

# 1. Choosing the Structure  

In this tutorial, we perform docking of **Ibuprofen** into **Cyclooxygenase-2 (COX-2)** using the PDB entry:

**PDB ID: [4PH9](https://www.rcsb.org/structure/4PH9)**  


This structure contains **Ibuprofen (IBP)** already bound, making it an ideal reference for learning how docking works.

---

# 2. Principles for Choosing a Good PDB Structure

Choosing a reliable experimental structure is the most important step before docking.

###  Resolution  
Prefer PDB structures with **≤ 2.5 Å** resolution.

### B-factor analysis  
Low B-factors around the ligand means stable positioning.  
Use **[ProteinPlus – EDIA](https://proteins.plus)** to evaluate atom-level stability:  


### Goodness of fit  
[Check electron-density fit using RCSB Ligand Validation](https://www.rcsb.org/ligand-validation/4PH9/IBP):  

A reliable ligand fit avoids docking into an incorrect pose.

---

# 3. Comparing 4PH9 vs 4RS0

Evaluate IBP ligand quality in:

- **4PH9 – IBP_A_601**  
- **4RS0 – IBP_A_706**

Using ProteinPlus EDIA:

- **4PH9** → stable B-factors, consistent EDIA scores  
- **4RS0** → variable EDIA/B-factor, ligand mobility

**Conclusion:**  
4PH9 provides a high-confidence binding mode → use this for docking.

---

# 4. Downloading the PDB File

Go to the PDB page and download:

**Files → Download → PDB Format (.pdb)**

AutoDock Vina works best with legacy PDB format.

---

# 5. Required Software

### [UCSF Chimera ](https://www.cgl.ucsf.edu/chimera/download.html) 
For visualization, structure cleaning, DockPrep.  
https://www.cgl.ucsf.edu/chimera/download.html

### [AutoDock Vina](https://vina.scripps.edu/downloads/)  
For docking.  
https://vina.scripps.edu/downloads/

Install both as per system instructions.

---

# 6. Protein Preparation in Chimera

Load the file **4PH9.pdb**.

---

## 6.1 Keep only Chain A
In Chimera
- Select → Chain → A  
- Select → Invert (selected model)  
- Action → Atoms/Bonds → Delete  

This removes all chains except A.

---

## 6.2 Remove all non-standard residues except IBP

- Select → Residue → all non-standard  
- Open the Command Line (Favorites → Command Line)  
- Type:  `~select :601`

This deselects IBP (residue 601) so it stays.

- Action → Atoms/Bonds → Delete  

Now only the protein and IBP remain.

---

## 6.3 Measure Ligand Center (for Grid Center)

In the Command Line: `measure center :601`
Example output:
```Center of 15 atoms = (12.92, 23.35, 25.29)```
Note these XYZ coordinates for Vina.

---

## 6.4 Split Ligand From Protein
In the Command Line: 
`split ligands`

This creates two models:

- Protein  
- IBP ligand  

---

# 7. Preparing Protein and Ligand using DockPrep

Run:

**Tools → Structure Editing → Dock Prep**

Perform DockPrep **separately** for:

1. Protein → save as **4PH9_protein.mol2**  
2. IBP ligand → save as **4PH9_IBP.mol2**

Use default parameters:

- Add hydrogens  
- Assign Gasteiger charges /Amber 
- Fix missing atoms if needed  

Reopen both mol2 files and visually verify correctness.

---

# 8. Docking Using AutoDock Vina (Chimera GUI)

Go to:

**Tools → Surface/Binding Analysis → AutoDock Vina**

Fill inputs:

- **Receptor:** 4PH9_protein.mol2  
- **Ligand:** 4PH9_IBP.mol2  
- **Center:** X = 12.92, Y = 23.35, Z = 25.29 (example)  
- **Box Size:** 20 Å (good default for small organic ligands)

Run docking.

Vina outputs:

- **Docking score (kcal/mol)**  
- **RMSD values**  
- Multiple poses ranked by energy  

Choose the best pose based on lowest score and sensible orientation.

---

# 9. Understanding AutoDock Vina Scoring Function  


Docking has two steps:

1. **Sampling** → testing different ligand orientations  
2. **Scoring** → estimating binding energy for each pose  

AutoDock Vina uses a **physics-inspired empirical scoring function**.

---

## 9.1 What Vina Estimates
**Always understand the scores, do not use it as black box**
Simplified score for understanding is given as following.

$$\[
\Delta G_{\text{bind}} \approx 
\text{(Attractive interactions)} - \text{(Penalties)}
\]$$

Lower (more negative) energies imply more favorable interactions.
For original score please refer the [Original work.](https://pmc.ncbi.nlm.nih.gov/articles/PMC3041641/) 



---

## 9.2 Components of the Vina Scoring Function

| Scoring Term | Description | What It Means in Practice |
|--------------|-------------|----------------------------|
| **Steric Repulsion** | Prevents atom overlaps | Avoids unrealistic poses |
| **Steric Attraction (vdW)** | Favors optimal distances | Good pocket fit |
| **Hydrogen Bonds** | Directional polar interactions | Strengthens binding |
| **Hydrophobic Contacts** | Nonpolar groups clustering | Important in COX-2 |
| **Rotatable Bond Penalty** | Loss of ligand entropy | Rigid ligands bind better |
| **Internal Strain Penalty** | Avoids unrealistic ligand strain | Ensures physical conformations |

---

## 9.3 Simple Analogy for Students

Docking is like a **handshake**:

- Good alignment → hydrogen bonds  
- Palm contact → hydrophobic  
- Fingers not colliding → steric repulsion  
- Rigid wrist → stable (low energy)  
- Floppy wrist → unstable (penalty)

---

## 9.4 Important Warning (for exam purposes)

> **Docking scores cannot predict IC50 or Ki.**  
They are useful only for **ranking poses**, not for absolute binding strength.

---

# 10. Evaluating Docking Results

Use:

**PLIP – Protein Ligand Interaction Profiler**  
https://plip-tool.biotec.tu-dresden.de/plip-web/plip/index

Upload the docked complex and visualize:

- Hydrogen bonds  
- Hydrophobic contacts  
- Salt bridges  
- π-π interactions  
- Key residues involved  

This helps verify if the docking pose is chemically reasonable(*Conservation of sites are important if we want to obstruct the interaction*).

---

# 11. Next Steps that are done in general

Docked poses can be refined by:

### Molecular Dynamics (MD)
Assess stability over time.

###  MM/PBSA or MM/GBSA
Compute more accurate free energies.

### Structure-Based Drug Design
Optimize ligand by improving interactions.

---

# 12. Summary Workflow

1. Select high-quality PDB  
2. Validate ligand position using EDIA  
3. Remove unwanted chains & residues  
4. Prepare protein and ligand using DockPrep  
5. Identify grid center  
6. Run docking using Vina  
7. Understand scoring terms  
8. Evaluate interactions using PLIP  
9. (Later) run MD or free energy calculations  

**Untill you validate experimentally you should not believe any simulation but it is a help to reduce chemical space search only**

---

# 13. Final Notes for Students

- Docking predicts **possible poses**, not **experimental affinity**.  
- Always examine **structure quality** before running docking.  
- Use docking results as **starting points**, not conclusions.  

---
