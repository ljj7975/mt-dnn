#!/bin/bash
#SBATCH --account=ctb-ontario
#SBATCH --partition=c-ontario
#SBATCH --time=2-00:00:00
#SBATCH --gres=gpu:v100:4
#SBATCH --cpus-per-task=4
#SBATCH --output=mt_dnn_base.out
#SBATCH --mem=64G

bash scripts/run_mt_dnn.sh roberta_base 16 0,1,2,3
