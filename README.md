# SHP2_HAPOD
This repo contains the scripts and data for Structure-Guided Expansion Strategy Unveils Potent Allosteric SHP2 Inhibitors with Synergistic Efficacy Against AML through MCL-1 Co-Targeting.
Eur. J. Med. Chem. 2025, 298, 117988. https://doi.org/10.1016/j.ejmech.2025.117988.

Each of the 5 directories contains the code and data of 1 receptor-ligand complex (excluding trajectories). If one were to rerun them, the overall workflow is 

1.preparing and creating the system
scripts to use:
addchargefrcmod.sh
tleap_HMR.sh

2.refine the complex and get the representative pose
scripts to use:
batchrefine.sh
5.clusterAndPrepareHAPOD.sh

and 3.in the HAPOD folder, running HAPOD-based MD.
scripts to use:
tleap_HMR.sh
batchheat.sh


This is also the first time HAPOD-scoring is applied on single protein-ligand complexes, and different ligands are compared of their binding. Previously, HAPOD has been used on molecular glue systems comparing the poses of the molecular glue, and also for the poses of PROTAC ternary systems in the founding publication.

For a more detailed description of the method itself, you may see the PROTACModeling repo(https://github.com/JL2021MD/PROTACModeling), in which a 15-minute tutorial is also available (assuming prerequistes already installed).

For any questions, please happily email liaojunzhuo AT gmail.com or leave a comment.
