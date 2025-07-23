antechamber -i *Ligand.pdb -fi pdb -o ligand_gaff2.mol2 -fo mol2 -c bcc -nc 0 -at gaff2 

rm *.AC *.INF *.AC0 sqm.pdb sqm.in sqm.out
parmchk2 -i ligand_gaff2.mol2 -f mol2 -s 2 -o ligand.frcmod
