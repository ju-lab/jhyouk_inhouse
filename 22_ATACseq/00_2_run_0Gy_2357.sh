
cd /home/users/jhyouk/06_mm10_SNUH_radiation/22_ATACseq

mkdir -p 0Gy_2357
cd 0Gy_2357

for sample in 0Gy_2357; do
	INPUT=/home/users/jhyouk/06_mm10_SNUH_radiation/22_ATACseq/${sample}.json
	PIPELINE_METADATA=metadata.json
	cromwell=/home/users/jhyouk/tools/atac-seq-pipeline/cromwell-34.jar
	atac_wdl=/home/users/jhyouk/tools/atac-seq-pipeline/atac.wdl
	backend=/home/users/jhyouk/tools/atac-seq-pipeline/backends/backend.conf
mkdir -p $sample
pushd $sample
cat <<EOF | qsub -N atac-seq-pipeline_youk -o /dev/null -e /dev/null -l nodes=1:ppn=6 -l mem=12000mb -q long -V > wdl.jobid
cd \$PBS_O_WORKDIR
rm -f wdl.done
source activate encode-atac-seq-pipeline # IMPORTANT!
java -jar -Dconfig.file=$backend $cromwell run $atac_wdl -i ${INPUT} -m ${PIPELINE_METADATA} > wdl.stdout &> wdl.stderr
echo $? > wdl.done
EOF
popd
done
