#!/bin/bash
if [[ $# -ne 3 ]]; then
  echo "train.sh <model_type> <batch_size> <gpu>"
  exit 1
fi
prefix="mt-dnn-rte"
MODEL_TYPE=$1
BATCH_SIZE=$2
gpu=$3
echo "export CUDA_VISIBLE_DEVICES=${gpu}"
export CUDA_VISIBLE_DEVICES=${gpu}
tstr=$(date +"%FT%H%M")

train_datasets="mnli,rte,qqp,qnli,mrpc,sst,cola,stsb"
test_datasets="mnli_matched,mnli_mismatched,rte"
MODEL_ROOT="checkpoints"
if [ $MODEL_TYPE == "BERT_LARGE" ]
then
    BERT_PATH="mt_dnn_models/bert_model_large_uncased.pt"
elif [ $MODEL_TYPE == "BERT_BASE" ]
    BERT_PATH="mt_dnn_models/bert_model_base_uncased.pt"
elif [ $MODEL_TYPE == "ROBERTA_LARGE" ]
    BERT_PATH="mt_dnn_models/roberta.base/model.pt"
elif [ $MODEL_TYPE == "ROBERTA_BASE" ]
    BERT_PATH="mt_dnn_models/roberta.large/model.pt"
fi

DATA_DIR="data/canonical_data/bert_uncased_lower"

answer_opt=1
optim="adamax"
grad_clipping=0
global_grad_clipping=1
lr="5e-5"

model_dir="checkpoints/${MODEL_TYPE}_${tstr}"
log_file="${model_dir}/log.log"
python train.py --data_dir ${DATA_DIR} --init_checkpoint ${BERT_PATH} --batch_size ${BATCH_SIZE} --output_dir ${model_dir} --log_file ${log_file} --answer_opt ${answer_opt} --optimizer ${optim} --train_datasets ${train_datasets} --test_datasets ${test_datasets} --grad_clipping ${grad_clipping} --global_grad_clipping ${global_grad_clipping} --learning_rate ${lr} --multi_gpu_on
