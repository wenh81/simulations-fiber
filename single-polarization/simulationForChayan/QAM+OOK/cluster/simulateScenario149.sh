#!/usr/bin/env bash
#SBATCH -p glenn
#SBATCH -A C3SE2018-1-15
#SBATCH -J simulateScenario149
#SBATCH -N 1
#SBATCH -t 0-02:00:00
#SBATCH -o simulateScenario149.stdout
#SBATCH -e simulateScenario149.stderr


module load matlab

cp  -r $SLURM_SUBMIT_DIR/* $TMPDIR
cd $TMPDIR

array=(  "6;-3;64000000000;150000000000" "7;-3;64000000000;150000000000" "8;-3;64000000000;150000000000" "9;-3;64000000000;150000000000" "10;-3;64000000000;150000000000" "-10;-2;64000000000;150000000000" "-9;-2;64000000000;150000000000" "-8;-2;64000000000;150000000000" "-7;-2;64000000000;150000000000" "-6;-2;64000000000;150000000000" "-5;-2;64000000000;150000000000" "-4;-2;64000000000;150000000000" "-3;-2;64000000000;150000000000" "-2;-2;64000000000;150000000000" "-1;-2;64000000000;150000000000" "0;-2;64000000000;150000000000" )
for i in "${array[@]}"
do
    arr=(${i//;/ })
    echo ${arr[0]} ${arr[1]} ${arr[2]} ${arr[3]}
    RunMatlab.sh -o "-nodesktop -nosplash -singleCompThread -r \"simulateScenario(${arr[0]},${arr[1]},${arr[2]},${arr[3]});\"" & 
    sleep 0.1
done

wait

mkdir $SLURM_SUBMIT_DIR/simulateScenario149
cp -rf $TMPDIR/* $SLURM_SUBMIT_DIR/simulateScenario149
rm -rf $TMPDIR/*

#End of script
