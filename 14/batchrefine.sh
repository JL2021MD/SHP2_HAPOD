current=`pwd`
for i in {1..5} ; do
       mkdir refine$i
	cd refine$i
	cp ../refine.sh .
	cp ../inputs.in .
	bash refine.sh
	cd $current
done
