#!/usr/bin/env bash
#SBATCH -p glenn
#SBATCH -A C3SE2018-1-15
#SBATCH -J simulateScenario110
#SBATCH -N 1
#SBATCH -t 0-10:00:00
#SBATCH -o simulateScenario110.stdout
#SBATCH -e simulateScenario110.stderr


module load matlab

cp  -r $SLURM_SUBMIT_DIR/* $TMPDIR
cd $TMPDIR

array=(  "-16;0;29000000000;200000000000" "-15;0;29000000000;200000000000" "-14;0;29000000000;200000000000" "-13;0;29000000000;200000000000" "-12;0;29000000000;200000000000" "-11;0;29000000000;200000000000" "-10;0;29000000000;200000000000" "-9;0;29000000000;200000000000" )
for i in "${array[@]}"
do
    arr=(${i//;/ })
    echo ${arr[0]} ${arr[1]} ${arr[2]} ${arr[3]}
    RunMatlab.sh -o "-nodesktop -nosplash -singleCompThread -r \"simulateScenario(${arr[0]},${arr[1]},${arr[2]},${arr[3]});\"" & 
    sleep 0.1
done

wait

mkdir $SLURM_SUBMIT_DIR/simulateScenario110
cp -rf $TMPDIR/results/* $SLURM_SUBMIT_DIR/simulateScenario110
rm -rf $TMPDIR/*

#End of script
