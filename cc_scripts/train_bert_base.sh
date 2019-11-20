#!/bin/bash
#SBATCH --account=def-jimmylin
#SBATCH --time=4-00:00:00
#SBATCH --gres=gpu:v100:2
#SBATCH --cpus-per-task=4
#SBATCH --output=mt_dnn_bert_base.out
#SBATCH --mem=64G

conda activate brandon_mt-dnn

bash scripts/run_mt_dnn.sh bert_base 8 0,1
