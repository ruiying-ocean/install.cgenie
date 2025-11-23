#!/bin/bash -e

# Generate a timestamp in the format: YYYYMMDD-HH:MM:SS
TIMESTAMP=$(date '+%Y%m%d-%H:%M:%S')

# Define the SBATCH script filename
FILENAME=~/cgenie.jobs/muffin.sbatch.$TIMESTAMP

COMPLEXITY=1 #10 for KPG run, 1 for LGM run 
TIME_MINUTES=$(( $COMPLEXITY * $4 ))

# Convert minutes to HH:MM:SS format
TIME_HHMMSS=$(printf "%02d:%02d:00" $((TIME_MINUTES / 60)) $((TIME_MINUTES % 60)))

# Create and write the SBATCH script
printf "#!/bin/sh

#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --time=$TIME_HHMMSS
#SBATCH --job-name=geniejob
#SBATCH --output=$HOME/cgenie_log/slurm-%%j.out
#SBATCH --partition=compute

# Initialize Conda for some necessary dependencies
# e.g., python2, bc
source /gpfs/home/vhf24tbu/miniforge3/etc/profile.d/conda.sh
conda activate py2

export PATH=$HOME/.local/bin:$PATH
export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH

cd ~/cgenie.muffin/genie-main

## if you want to re-compile, uncomment this
## make cleanall &> ~/cgenie_log/cleanall_trash.txt;

./runmuffin.sh $1 $2 $3 $4 $5
" > "$FILENAME"

# Submit the job
sbatch "$FILENAME"

rm -f "$FILENAME"
