#!/usr/bin/env bash
#SBATCH -p glenn
#SBATCH -A C3SE2018-1-15
#SBATCH -J simulateScenario112
#SBATCH -N 1
#SBATCH -t 0-02:00:00
#SBATCH -o simulateScenario112.stdout
#SBATCH -e simulateScenario112.stderr


module load matlab

cp  -r $SLURM_SUBMIT_DIR/* $TMPDIR
cd $TMPDIR

array=(  "2;-10;32000000000;150000000000" "3;-10;32000000000;150000000000" "4;-10;32000000000;150000000000" "5;-10;32000000000;150000000000" "6;-10;32000000000;150000000000" "7;-10;32000000000;150000000000" "8;-10;32000000000;150000000000" "9;-10;32000000000;150000000000" "10;-10;32000000000;150000000000" "-10;-9;32000000000;150000000000" "-9;-9;32000000000;150000000000" "-8;-9;32000000000;150000000000" "-7;-9;32000000000;150000000000" "-6;-9;32000000000;150000000000" "-5;-9;32000000000;150000000000" "-4;-9;32000000000;150000000000" )
for i in "${array[@]}"
do
    arr=(${i//;/ })
    echo ${arr[0]} ${arr[1]} ${arr[2]} ${arr[3]}
    RunMatlab.sh -o "-nodesktop -nosplash -singleCompThread -r \"simulateScenario(${arr[0]},${arr[1]},${arr[2]},${arr[3]});\"" & 
    sleep 0.1
done

wait

mkdir $SLURM_SUBMIT_DIR/simulateScenario112
cp -rf $TMPDIR/* $SLURM_SUBMIT_DIR/simulateScenario112
rm -rf $TMPDIR/*

#End of script
