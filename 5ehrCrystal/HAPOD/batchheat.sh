current=`pwd`
for i in {5..10} ; do
	cd PMEMD$i
	cp ../heat.sh .
	cp ../inputs.in .
	bash heat.sh
	cd $current
done
