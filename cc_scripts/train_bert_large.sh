#!/bin/bash
#SBATCH --account=def-jimmylin
#SBATCH --time=6-00:00:00
#SBATCH --gres=gpu:v100:2
#SBATCH --cpus-per-task=4
#SBATCH --output=mt_dnn_bert_large.out
#SBATCH --mem=64G

conda activate brandon_mt-dnn

bash scripts/run_mt_dnn.sh bert_large 8 0,1
