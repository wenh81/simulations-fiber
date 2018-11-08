#!/usr/bin/env bash
#SBATCH -p glenn
#SBATCH -A C3SE2018-1-15
#SBATCH -J simulateScenario76
#SBATCH -N 1
#SBATCH -t 0-02:00:00
#SBATCH -o simulateScenario76.stdout
#SBATCH -e simulateScenario76.stderr


module load matlab

cp  -r $SLURM_SUBMIT_DIR/* $TMPDIR
cd $TMPDIR

array=(  "-7;5;32000000000;100000000000" "-6;5;32000000000;100000000000" "-5;5;32000000000;100000000000" "-4;5;32000000000;100000000000" "-3;5;32000000000;100000000000" "-2;5;32000000000;100000000000" "-1;5;32000000000;100000000000" "0;5;32000000000;100000000000" "1;5;32000000000;100000000000" "2;5;32000000000;100000000000" "3;5;32000000000;100000000000" "4;5;32000000000;100000000000" "5;5;32000000000;100000000000" "6;5;32000000000;100000000000" "7;5;32000000000;100000000000" "8;5;32000000000;100000000000" )
for i in "${array[@]}"
do
    arr=(${i//;/ })
    echo ${arr[0]} ${arr[1]} ${arr[2]} ${arr[3]}
    RunMatlab.sh -o "-nodesktop -nosplash -singleCompThread -r \"simulateScenario(${arr[0]},${arr[1]},${arr[2]},${arr[3]});\"" & 
    sleep 0.1
done

wait

mkdir $SLURM_SUBMIT_DIR/simulateScenario76
cp -rf $TMPDIR/* $SLURM_SUBMIT_DIR/simulateScenario76
rm -rf $TMPDIR/*

#End of script

