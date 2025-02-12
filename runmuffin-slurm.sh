#!/bin/bash -e
#
#####################################################################
### SCIPT TO RUN ./RUNMUFFIN.SH ON REDHAT HPC #######################
#####################################################################
# export LD_LIBRARY_PATH=$HOME/.local/lib

## create a sbatch file to cgenie.job directory
printf "#!/bin/sh

#SBATCH --nodes=1                # Number of nodes requested
#SBATCH --time=48:00:00
#SBATCH --job-name=geniejob
#SBATCH --output=runmuffin.out

export PATH=$HOME/.local/bin:$PATH
export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH

cd ~/cgenie.muffin/genie-main

make cleanall &> ~/cgenie_log/cleanall_trash.txt;

./runmuffin.sh $1 $2 $3 $4 $5 &> ~/cgenie_log/cgenie.output_$(date '+%F_%H.%M').log
" > ~/cgenie.jobs/muffin.sbatch

# submit a job
sbatch ~/cgenie.jobs/muffin.sbatch

