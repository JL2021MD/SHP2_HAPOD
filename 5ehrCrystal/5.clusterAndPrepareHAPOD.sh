#for i in {1..5}; do
#cd $i
mkdir clustering
cd clustering
current=`pwd`
printf "\n\n#############\n#############\n#############\nINFO: Current working directory is: \n $current \n\n"

cat >cpptraj.clustering.in<<EOF

parm ../Tleap/complex.gas.prmtop [1]

trajin ../refine1/2-10.align.nc 6 last parm [1] #0
trajin ../refine2/2-10.align.nc 6 last parm [1] #1
trajin ../refine3/2-10.align.nc 6 last parm [1] #2
trajin ../refine4/2-10.align.nc 6 last parm [1] #3
trajin ../refine5/2-10.align.nc 6 last parm [1] #4

# calls the cluster command and sets the data set name\

# residues for clustering the same as in the inputs.in file for CRBN and CRBNlig RMSD measurement.
cluster c1 \
 dbscan minpoints 1 epsilon 0.6 sievetoframe \
 rms :522&!@H= nofit \
 out cnumvtime.dat \
 summary summary.dat \
 info info.dat \
 cpopvtime cpopvtime.agr normframe \
 repout rep repfmt pdb \
 singlerepout singlerep.nc singlerepfmt netcdf
run

EOF
cpptraj cpptraj.clustering.in
current=`pwd`
printf "INFO: Finished clustering of refinement frames for $current, and representative pose from most populous cluster being used.\n\n\n"
cd ..
mkdir HAPOD
cd HAPOD
pwd
ln -s ../clustering/rep.c0.pdb .

## To avoid rerunning antechamber for generating AM1-BCC charges, cpptraj is used to extract the ligand in ready-to-use mol2 format. Change the ligand residue number according.
cat >cpptraj.genGaffLig.in<<EOF
parm ../Tleap/complex.gas.prmtop
trajin rep.c0.pdb
strip :1-521
trajout ligand_gaff2.mol2
EOF
cpptraj cpptraj.genGaffLig.in -o cpptraj.log.temp

cat >cpptraj.protein.in<<EOF
parm ../Tleap/complex.gas.prmtop
trajin rep.c0.pdb
strip :522
trajout protein.pdb
EOF
cpptraj cpptraj.protein.in -o cpptraj.log.temp
printf "\n\nINFO: Tleap input structures for pose $i generated.\n\n"

rm cpptraj*in
ln -s ../ligand.frcmod .
ln -s ../tleap_HMR.sh .
bash tleap_HMR.sh
mkdir PMEMD{1..10}
cd ../..
#done


