# Desmond Python API Usage

## 1. Setting up Schrödinger Virtual Environment

```bash
$SCHRODINGER/run schrodinger_virtualenv.py schrodinger.ve
source schrodinger.ve/bin/activate
```

## 2. Trajectory Analysis with Python API

```python
from schrodinger.application.desmond.packages import analysis, traj, topo

# Load CMS model and trajectory
msys_model, cms_model = topo.read_cms('/home/user/work/rosetta/DOPA_hyb/DOPA_HYB/desmond_md_job_1/desmond_md_job_1-out.cms')
tr = traj.read_traj('/home/user/work/rosetta/DOPA_hyb/DOPA_HYB/desmond_md_job_1/desmond_md_job_1_trj')  # dtr format trajectory

# Initialize analyzers
analyzer1 = analysis.ProtLigInter(msys_model, cms_model, 'protein')
analyzer2 = analysis.Gyradius(msys_model, cms_model, 'protein')
analyzer3 = analysis.RMSD(msys_model, cms_model, 'protein')
analyzer4 = analysis.RMSF(msys_model, cms_model, 'protein')
analyzer5 = analysis.SecondaryStructur(msys_model, cms_model, 'protein')

# Run analysis
results = analysis.analyze(tr, analyzer1, analyzer2, analyzer3, analyzer4, analyzer5)
```