#!/bin/bash
if [[ $# -ne 3 ]]; then
  echo "train.sh  <'bert_base'/'bert_large'/'roberta_base'/'roberta_large'> <batch_size> <gpu>"
  exit 1
fi
prefix="mt-dnn-rte"
BATCH_SIZE=$2
gpu=$3
echo "export CUDA_VISIBLE_DEVICES=${gpu}"
export CUDA_VISIBLE_DEVICES=${gpu}
tstr=$(date +"%FT%H%M")

train_datasets="mnli,rte,qqp,qnli,mrpc,sst,cola,stsb"
test_datasets="mnli_matched,mnli_mismatched,rte"
MODEL_ROOT="checkpoints"

echo $1
if [ $1 == "bert_base" ]
then
    BERT_PATH="${SCRATCH_DIR}/mt_dnn_models/bert_model_base_uncased.pt"
    ENCODER_TYPE=1
elif [ $1 == "bert_large" ]
then
    BERT_PATH="${SCRATCH_DIR}/mt_dnn_models/bert_model_large_uncased.pt"
    ENCODER_TYPE=1
elif [ $1 == "roberta_base" ]
then
    BERT_PATH="${SCRATCH_DIR}/mt_dnn_models/roberta.base"
    ENCODER_TYPE=2
elif [ $1 == "roberta_large" ]
then
    BERT_PATH="${SCRATCH_DIR}/mt_dnn_models/roberta.large"
    ENCODER_TYPE=2
else
    echo "INCORRECT MODEL NAME"
    exit 1
fi

DATA_DIR="${SCRATCH_DIR}/data/canonical_data/bert_uncased_lower"

answer_opt=1
optim="adamax"
grad_clipping=0
global_grad_clipping=1
lr="5e-5"

model_dir="${SCRATCH_DIR}/checkpoints/${1}_${tstr}"
log_file="${model_dir}/log.log"
python -W error train.py --encoder_type ${ENCODER_TYPE} --data_dir ${DATA_DIR} --init_checkpoint ${BERT_PATH} --batch_size ${BATCH_SIZE} --output_dir ${model_dir} --log_file ${log_file} --answer_opt ${answer_opt} --optimizer ${optim} --train_datasets ${train_datasets} --test_datasets ${test_datasets} --grad_clipping ${grad_clipping} --global_grad_clipping ${global_grad_clipping} --learning_rate ${lr} --multi_gpu_on