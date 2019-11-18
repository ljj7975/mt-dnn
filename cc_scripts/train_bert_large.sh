#!/bin/bash
#SBATCH --account=def-jimmylin
#SBATCH --time=4-00:00:00
#SBATCH --gres=gpu:v100:4
#SBATCH --cpus-per-task=4
#SBATCH --output=mt_dnn_bert_large.out
#SBATCH --mem=64G

bash scripts/run_mt_dnn.sh bert_large 16 0,1,2,3
