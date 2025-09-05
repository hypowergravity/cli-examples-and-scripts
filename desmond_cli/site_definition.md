# Schrödinger Site Definition

## Residue Selection Syntax

### Single Residue Selection
```
((chain.name A)) AND (res.num 54)
```

### Multiple Residues and Chains
```
((chain.name A)) and (res.num 54,57,61-63) OR ((chain.name F)) and (res.num 54,57,61-63)
```
