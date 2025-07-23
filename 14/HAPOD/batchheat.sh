current=`pwd`
for i in 1 ; do
	cd PMEMD$i
	cp ../inputs.in .
	cp ../heat.sh .
	bash heat.sh
	cd $current
done
