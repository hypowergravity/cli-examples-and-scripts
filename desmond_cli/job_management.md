# Desmond Job Management

## Job Status Commands

### List All Jobs
```bash
$SCHRODINGER/jobcontrol -list
```

### Check Job Status
```bash
# Method 1: Check status by job ID
$SCHRODINGER/jobcontrol -list -c status bioinfo-0-5a56ce50

# Method 2: Show system information
$SCHRODINGER/jobcontrol -showsys bioinfo-0-5a56ce50

# Method 3: Combined status check
$SCHRODINGER/jobcontrol -showsys -c status bioinfo-Z10PE-D16-WS-0-5e9d287a
```

### Monitor Job Logs
```bash
tail -f /tmp/bionfo/desmond_md_3KQ0-1.1/desmond_md_3KQ0-1.log
```

## Analysis Commands

### Simulation Analysis
```bash
$SCHRODINGER/run analyze_simulation.py desmond_md_job_1-out.cms desmond_md_job_1_trj desmond_md_job_1_out.eaf EAF_tmp1.eaf
```

### AMBER to CMS Conversion
```bash
$SCHRODINGER/run -FROM mmshare amber_prm2cms.py -p complex_dry.prmtop -c complex_dry.inpcrd -o
```

### Trajectory Analysis with AMBER Format
```bash
$SCHRODINGER/run -FROM mmshare analyze_trajectories.py output.cms last_fit_10.xtc desmond_md_job_1_out.eaf EAF_tmp1.eaf
```

### Trajectory Manipulation
```bash
$SCHRODINGER/run -FROM desmond manipulate_trj.py
```