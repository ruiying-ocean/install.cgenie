#!/bin/bash -e

# Generate a timestamp in the format: YYYYMMDD-HH:MM:SS
TIMESTAMP=$(date '+%Y%m%d-%H:%M:%S')

# Define the SBATCH script filename
FILENAME=~/cgenie.jobs/muffin.sbatch.$TIMESTAMP

# Create and write the SBATCH script
printf "#!/bin/sh

#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --time=120:00:00
#SBATCH --job-name=geniejob
#SBATCH --output=muffin.out
#SBATCH --partition=compute-64-512 

export PATH=$HOME/.local/bin:$PATH
export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH

cd ~/cgenie.muffin/genie-main

## if you want to re-compile, uncomment this
## make cleanall &> ~/cgenie_log/cleanall_trash.txt;

./runmuffin.sh $1 $2 $3 $4 $5 &> ~/cgenie_log/cgenie.output_$TIMESTAMP.log
" > "$FILENAME"

# Submit the job
sbatch "$FILENAME"
