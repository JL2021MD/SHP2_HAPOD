current=`pwd`
for i in {1..10} ; do
	cd PMEMD$i
	cp ../heat.sh .
	cp ../inputs.in .
	bash heat.sh
	cd $current
done
