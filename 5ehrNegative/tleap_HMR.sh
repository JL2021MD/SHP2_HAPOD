current=`pwd`
mkdir $current/Tleap
cd  $current/Tleap
##To address file name difference in Amber22 from previous versions. The one that exists will be linked over. Using cp instead of ln will not create the link if the source file doesn't exist
cp -s $AMBERHOME/dat/leap/parm/frcmod.ions1lm_126_iod_opc frcmod.ions1lm_126_iod_opc -v
cp -s $AMBERHOME/dat/leap/parm/frcmod.ionslm_126_iod_opc frcmod.ions1lm_126_iod_opc -v

cat > tleap.build.in <<EOF
#### tleap -f tleap.build.in


source leaprc.protein.ff19SB
source leaprc.gaff2

source leaprc.water.opc
loadamberparams $current/Tleap/frcmod.ions1lm_126_iod_opc

set default PBradii mbondi2

rec=loadpdb ../protein.pdb

###Load Ligand frcmod/prep

loadamberparams ../ligand.frcmod
lig=loadmol2 ../ligand_gaff2.mol2

gascomplex= combine {rec lig}

savepdb gascomplex complex.gas.pdb
saveamberparm gascomplex complex.gas.prmtop complex.gas.rst7

solvcomplex= combine {rec lig}
solvateoct solvcomplex OPCBOX 5

###Neutralize system (it will add either Na or Cl depending on net charge)
addions solvcomplex Cl- 0
addions solvcomplex Na+ 0

###Write solvated pdb file
savepdb solvcomplex complex.opc.pdb

charge solvcomplex

###Write Solvated topology and coord file
saveamberparm solvcomplex complex.opc.prmtop complex.opc.rst7

quit

EOF

cat > parmed1.in<<EOF
HMassRepartition
outparm complex.HMR.opc.prmtop
EOF
cat > parmed2.in<<EOF
HMassRepartition
outparm complex.HMR.gas.prmtop
EOF
tleap -f tleap.build.in


parmed -p complex.opc.prmtop -i parmed1.in
