#!/bin/bash

inpdir=/mnt/scratch/asalomatov/SSC_rerun/denovo_analysis/rerun200fam
snpsift='java -jar /mnt/xfs1/bioinfo/software/installs/bcbio_nextgen/150607/Cellar/snpeff/4.1g/libexec/SnpSift.jar'
fam=$1
for m in $(echo HC JHC FB PL)
do
    zcat ${inpdir}/${fam}-${m}-pm50-ann.vcf.gz | \
        $snpsift filter -c /mnt/scratch/asalomatov/data/b37/snpEff/snpEff.config  \
        "( GEN[0].GT = '1/1' ) & ( GEN[1].GT = '1/1' )  & ( GEN[2].GT = '0/0' )  \
        &  ( GEN[0].DP > 5 ) & ( GEN[1].DP > 5 )  & ( GEN[2].DP > 5 ) " \
        > ${fam}-${m}-pm50-ann-p1.vcf 
#        $snpsift filter -c /mnt/scratch/asalomatov/data/b37/snpEff/snpEff.config "( ( GEN[0].GT = '1/1' ) & ( GEN[1].GT = '1/1' ) ) & (( GEN[2].GT = '0/0' ) | (GEN[2].GT = '0/1') ) ) | ( ( ( (GEN[0].GT = '1/1') & (GEN[1].GT = '0/1') ) | ( (GEN[0].GT = '0/1') & (GEN[1].GT = '1/1') ) ) & (GEN[2].GT = '0/0') )" > ${fam}-${m}-pm50-ann-p1.vcf 
#        " ( GEN[0].DP > 5 ) & ( GEN[1].DP > 5 )  & ( GEN[2].DP > 5 ) " > ${fam}-${m}-pm50-ann-p1.vcf
#        bgzip -c > ${fam}-${m}-pm50-ann-p1.vcf.gz
#        tabix -p ${fam}-${m}-pm50-ann-p1.vcf.gz
done

#m='PL'
#zcat ${inpdir}/${fam}-${m}-pm50-ann.vcf.gz | \
#        $snpsift filter -c /mnt/scratch/asalomatov/data/b37/snpEff/snpEff.config \
#        " ( GEN[0].GT != '0/0' ) & ( GEN[0].GT != '0|0' ) & ( GEN[0].GT != './.' ) & ( GEN[0].GT != '.|.' )" | \
#        $snpsift filter -c /mnt/scratch/asalomatov/data/b37/snpEff/snpEff.config \
#        " ( GEN[1].GT != '0/0' ) & ( GEN[1].GT != '0|0' ) & ( GEN[1].GT != './.' ) & ( GEN[1].GT != '.|.' )" | \
#        $snpsift filter -c /mnt/scratch/asalomatov/data/b37/snpEff/snpEff.config \
#        " ( GEN[2].GT = '0/0' ) | ( GEN[2].GT = '0|0' ) " | \
#        $snpsift filter -c /mnt/scratch/asalomatov/data/b37/snpEff/snpEff.config \
#        " ( GEN[0].NR > 5 ) & ( GEN[1].NR > 5 )  & ( GEN[2].NR > 5 ) " > ${fam}-${m}-pm50-ann-p1.vcf
