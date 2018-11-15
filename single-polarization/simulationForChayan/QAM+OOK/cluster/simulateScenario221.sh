#!/usr/bin/env bash
#SBATCH -p glenn
#SBATCH -A C3SE2018-1-15
#SBATCH -J simulateScenario221
#SBATCH -N 1
#SBATCH -t 0-10:00:00
#SBATCH -o simulateScenario221.stdout
#SBATCH -e simulateScenario221.stderr


module load matlab

cp  -r $SLURM_SUBMIT_DIR/* $TMPDIR
cd $TMPDIR

array=(  "3;10;64000000000;150000000000" "4;10;64000000000;150000000000" "5;10;64000000000;150000000000" "6;10;64000000000;150000000000" "7;10;64000000000;150000000000" "8;10;64000000000;150000000000" "9;10;64000000000;150000000000" "10;10;64000000000;150000000000" "-10;-10;32000000000;200000000000" "-9;-10;32000000000;200000000000" "-8;-10;32000000000;200000000000" "-7;-10;32000000000;200000000000" "-6;-10;32000000000;200000000000" "-5;-10;32000000000;200000000000" "-4;-10;32000000000;200000000000" "-3;-10;32000000000;200000000000" )
for i in "${array[@]}"
do
    arr=(${i//;/ })
    echo ${arr[0]} ${arr[1]} ${arr[2]} ${arr[3]}
    RunMatlab.sh -o "-nodesktop -nosplash -singleCompThread -r \"simulateScenario(${arr[0]},${arr[1]},${arr[2]},${arr[3]});\"" & 
    sleep 0.1
done

wait

mkdir $SLURM_SUBMIT_DIR/simulateScenario221
cp -rf $TMPDIR/results/* $SLURM_SUBMIT_DIR/simulateScenario221
rm -rf $TMPDIR/*

#End of script

