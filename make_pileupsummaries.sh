#!/bin/bash
#SBATCH --mem 8000

module load gatk/4.0.1.2

##Configuration variables

genpopf="/home/dmalload/ppipilot/gpop/af_gnomad2.0.2_vcontaminant_minAF0.05.vcf.gz"

usage="$0 tumor_bam"

if [[ $# -lt 1 ]] || [[ ! -f $1 ]]
then
    echo -e $usage
    exit
fi

limits=""
if [[ $# -gt 1 ]] && [[ $2 != "" ]]
then
    limits="-L "$(readlink -e $2)
fi

gatk GetPileupSummaries \
-I $1 \
-V $genpopf \
-O $(echo $1 | sed "s/^\(.*\)\/[^/]*$/\1/g")/$(echo $1 | sed "s/.*\/\([^/]*\)$/\1/g")_pileup.table ${limits}
