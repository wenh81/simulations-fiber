#!/usr/bin/env bash
#SBATCH -p glenn
#SBATCH -A C3SE2018-1-15
#SBATCH -J simulateScenario124
#SBATCH -N 1
#SBATCH -t 0-02:00:00
#SBATCH -o simulateScenario124.stdout
#SBATCH -e simulateScenario124.stderr


module load matlab

cp  -r $SLURM_SUBMIT_DIR/* $TMPDIR
cd $TMPDIR

array=(  "5;-1;32000000000;150000000000" "6;-1;32000000000;150000000000" "7;-1;32000000000;150000000000" "8;-1;32000000000;150000000000" "9;-1;32000000000;150000000000" "10;-1;32000000000;150000000000" "-10;0;32000000000;150000000000" "-9;0;32000000000;150000000000" "-8;0;32000000000;150000000000" "-7;0;32000000000;150000000000" "-6;0;32000000000;150000000000" "-5;0;32000000000;150000000000" "-4;0;32000000000;150000000000" "-3;0;32000000000;150000000000" "-2;0;32000000000;150000000000" "-1;0;32000000000;150000000000" )
for i in "${array[@]}"
do
    arr=(${i//;/ })
    echo ${arr[0]} ${arr[1]} ${arr[2]} ${arr[3]}
    RunMatlab.sh -o "-nodesktop -nosplash -singleCompThread -r \"simulateScenario(${arr[0]},${arr[1]},${arr[2]},${arr[3]});\"" & 
    sleep 0.1
done

wait

mkdir $SLURM_SUBMIT_DIR/simulateScenario124
cp -rf $TMPDIR/* $SLURM_SUBMIT_DIR/simulateScenario124
rm -rf $TMPDIR/*

#End of script
