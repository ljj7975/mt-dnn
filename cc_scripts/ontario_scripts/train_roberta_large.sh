#!/bin/bash
#SBATCH --account=ctb-ontario
#SBATCH --partition=c-ontario
#SBATCH --time=4-00:00:00
#SBATCH --gres=gpu:v100:4
#SBATCH --cpus-per-task=4
#SBATCH --output=mt_dnn_roberta_large.out
#SBATCH --mem=64G

conda activate brandon_mt-dnn

bash scripts/run_mt_dnn.sh roberta_large 8 0,1,2,3
