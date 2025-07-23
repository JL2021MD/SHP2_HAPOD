current=`pwd`
for i in {1..10}; do
	cd PMEMD$i
	cp ../HAPOD.py .
	python3 HAPOD.py RMSDresults.csv
	echo ""
	cd $current
done
