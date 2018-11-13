#!/usr/bin/env bash
#SBATCH -p glenn
#SBATCH -A C3SE2018-1-15
#SBATCH -J simulateScenario74
#SBATCH -N 1
#SBATCH -t 0-02:00:00
#SBATCH -o simulateScenario74.stdout
#SBATCH -e simulateScenario74.stderr


module load matlab

cp  -r $SLURM_SUBMIT_DIR/* $TMPDIR
cd $TMPDIR

array=(  "3;3;32000000000;100000000000" "4;3;32000000000;100000000000" "5;3;32000000000;100000000000" "6;3;32000000000;100000000000" "7;3;32000000000;100000000000" "8;3;32000000000;100000000000" "9;3;32000000000;100000000000" "10;3;32000000000;100000000000" "-10;4;32000000000;100000000000" "-9;4;32000000000;100000000000" "-8;4;32000000000;100000000000" "-7;4;32000000000;100000000000" "-6;4;32000000000;100000000000" "-5;4;32000000000;100000000000" "-4;4;32000000000;100000000000" "-3;4;32000000000;100000000000" )
for i in "${array[@]}"
do
    arr=(${i//;/ })
    echo ${arr[0]} ${arr[1]} ${arr[2]} ${arr[3]}
    RunMatlab.sh -o "-nodesktop -nosplash -singleCompThread -r \"simulateScenario(${arr[0]},${arr[1]},${arr[2]},${arr[3]});\"" & 
    sleep 0.1
done

wait

mkdir $SLURM_SUBMIT_DIR/simulateScenario74
cp -rf $TMPDIR/results/* $SLURM_SUBMIT_DIR/simulateScenario74
rm -rf $TMPDIR/*

#End of script

