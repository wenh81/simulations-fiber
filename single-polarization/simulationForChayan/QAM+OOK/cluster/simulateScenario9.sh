#!/usr/bin/env bash
#SBATCH -p glenn
#SBATCH -A C3SE2018-1-15
#SBATCH -J simulateScenario9
#SBATCH -N 1
#SBATCH -t 0-02:00:00
#SBATCH -o simulateScenario9.stdout
#SBATCH -e simulateScenario9.stderr


module load matlab

cp  -r $SLURM_SUBMIT_DIR/* $TMPDIR
cd $TMPDIR

array=(  "-8;-4;32000000000;50000000000" "-7;-4;32000000000;50000000000" "-6;-4;32000000000;50000000000" "-5;-4;32000000000;50000000000" "-4;-4;32000000000;50000000000" "-3;-4;32000000000;50000000000" "-2;-4;32000000000;50000000000" "-1;-4;32000000000;50000000000" "0;-4;32000000000;50000000000" "1;-4;32000000000;50000000000" "2;-4;32000000000;50000000000" "3;-4;32000000000;50000000000" "4;-4;32000000000;50000000000" "5;-4;32000000000;50000000000" "6;-4;32000000000;50000000000" "7;-4;32000000000;50000000000" )
for i in "${array[@]}"
do
    arr=(${i//;/ })
    echo ${arr[0]} ${arr[1]} ${arr[2]} ${arr[3]}
    RunMatlab.sh -o "-nodesktop -nosplash -singleCompThread -r \"simulateScenario(${arr[0]},${arr[1]},${arr[2]},${arr[3]});\"" & 
    sleep 0.1
done

wait

mkdir $SLURM_SUBMIT_DIR/simulateScenario9
cp -rf $TMPDIR/* $SLURM_SUBMIT_DIR/simulateScenario9
rm -rf $TMPDIR/*

#End of script

