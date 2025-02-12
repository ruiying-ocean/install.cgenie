#!/bin/bash -e
#
#####################################################################
### SCIPT TO RUN ./RUNMUFFIN.SH ON REDHAT HPC #######################
#####################################################################

## create a sbatch file to cgenie.job directory
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

make cleanall &> ~/cgenie_log/cleanall_trash.txt;

./runmuffin.sh $1 $2 $3 $4 $5 &> ~/cgenie_log/cgenie.output_$(date '+%F_%H.%M').log
" > ~/cgenie.jobs/muffin.sbatch

# submit a job
sbatch ~/cgenie.jobs/muffin.sbatch

