#!/usr/bin/env bash
#SBATCH -p glenn
#SBATCH -A C3SE2018-1-15
#SBATCH -J simulateScenario101
#SBATCH -N 1
#SBATCH -t 0-02:00:00
#SBATCH -o simulateScenario101.stdout
#SBATCH -e simulateScenario101.stderr


module load matlab

cp  -r $SLURM_SUBMIT_DIR/* $TMPDIR
cd $TMPDIR

array=(  "-6;3;64000000000;100000000000" "-5;3;64000000000;100000000000" "-4;3;64000000000;100000000000" "-3;3;64000000000;100000000000" "-2;3;64000000000;100000000000" "-1;3;64000000000;100000000000" "0;3;64000000000;100000000000" "1;3;64000000000;100000000000" "2;3;64000000000;100000000000" "3;3;64000000000;100000000000" "4;3;64000000000;100000000000" "5;3;64000000000;100000000000" "6;3;64000000000;100000000000" "7;3;64000000000;100000000000" "8;3;64000000000;100000000000" "9;3;64000000000;100000000000" )
for i in "${array[@]}"
do
    arr=(${i//;/ })
    echo ${arr[0]} ${arr[1]} ${arr[2]} ${arr[3]}
    RunMatlab.sh -o "-nodesktop -nosplash -singleCompThread -r \"simulateScenario(${arr[0]},${arr[1]},${arr[2]},${arr[3]});\"" & 
    sleep 0.1
done

wait

mkdir $SLURM_SUBMIT_DIR/simulateScenario101
cp -rf $TMPDIR/* $SLURM_SUBMIT_DIR/simulateScenario101
rm -rf $TMPDIR/*

#End of script
