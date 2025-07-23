import sys

occuThres=3.5
disThres=4
rejoinThres=3
RMSDcol=2
#First column is 0

### rawFrames is a dictionary of {frame:RMSD}.
rawFrames={}
### finalFrames is a dictionary of {frame:movingaverageRMSD} going from 10 to 491
finalFrames={}
file=open(sys.argv[1],"r")
output=open('HAPOD.out', "w")
lines=file.readlines()

for line in lines[1:]:
    frame=int(line.split()[0])
    RMSD=float(line.split()[RMSDcol])
    rawFrames[frame]=RMSD


a=int(list(rawFrames)[-1])   ## this reads the last frame number
print("A total of ",a, "frames read.", file=output)
print("A total of ",a, "frames read.")
eqFrames=7

for i in range((10+eqFrames),a+1):
    newFrame=0
    for k in range(0,10):
        one=(rawFrames[i-k])
        newFrame=one+newFrame

    outFrame=round(newFrame/10,4)
    finalFrames[i-eqFrames]=outFrame

rawOccupany=0
for i in range(10,a-eqFrames+1):
    if finalFrames[i]<occuThres:
        rawOccupany=rawOccupany+1
occupancy=(rawOccupany+9)/5      # +9 because the new frame starts at 10 frames after the eq ends.
print("Occupancy Score: ", occupancy, file=output)
print("Occupancy Score: ", occupancy)

dissociation={}
counter=0
dis=0
k=0
print("Dissociation frames:", file=output)
print("Dissociation frames:")
for i in range(10,a-eqFrames+1):
    if finalFrames[i]>disThres and dis==0:
        k=i+k
        print(i, file=output)
        print(i)
        dis=1
        counter=counter+1
    elif finalFrames[i]<rejoinThres and dis==1:
        dis=0
    if i==a-eqFrames and finalFrames[i] <disThres and dis==0:
        k=k+i+50
        print(k, file=output)
        print(k)
        counter=counter+1

dissocation=round((k/counter)/5+310,1)
print("Temperature Score: ",dissocation, file=output)
print("Temperature Score: ",dissocation)
print( "OccupancyThres= ",occuThres, "DissociateThres=",disThres )

