#!/usr/bin/env bash
############################################################## 
# This script is used to download resources for MT-DNN experiments
############################################################## 

BERT_DIR=${SCRATCH_DIR}/mt_dnn_models
if [ ! -d ${BERT_DIR}  ]; then
  echo "Create a folder BERT_DIR"
  mkdir ${BERT_DIR}
fi

## Download bert models
wget https://mrc.blob.core.windows.net/mt-dnn-model/bert_model_base_v2.pt -O "${BERT_DIR}/bert_model_base_uncased.pt"
wget https://mrc.blob.core.windows.net/mt-dnn-model/bert_model_large_v2.pt -O "${BERT_DIR}/bert_model_large_uncased.pt"
wget https://mrc.blob.core.windows.net/mt-dnn-model/bert_base_chinese.pt -O "${BERT_DIR}/bert_model_base_chinese.pt"

## Download MT-DNN models
wget https://mrc.blob.core.windows.net/mt-dnn-model/mt_dnn_base.pt -O "${BERT_DIR}/mt_dnn_base_uncased.pt"
wget https://mrc.blob.core.windows.net/mt-dnn-model/mt_dnn_large.pt -O "${BERT_DIR}/mt_dnn_large_uncased.pt"

## MT-DNN-KD
wget https://mrc.blob.core.windows.net/mt-dnn-model/mt_dnn_kd_large_cased.pt -O "${BERT_DIR}/mt_dnn_kd_large_cased.pt"

## Download XLNet model
wget https://storage.googleapis.com/xlnet/released_models/cased_L-24_H-1024_A-16.zip -O "xlnet_cased_large.zip"
unzip xlnet_cased_large.zip 
mv xlnet_cased_L-24_H-1024_A-16/spiece.model "${BERT_DIR}/xlnet_large_cased_spiece.model"
rm -rf *.zip xlnet_cased_L-24_H-1024_A-16
## download converted xlnet pytorch model
wget https://mrc.blob.core.windows.net/mt-dnn-model/xlnet_model_large_cased.pt -O "${BERT_DIR}/xlnet_model_large_cased.pt"


## download ROBERTA
wget https://dl.fbaipublicfiles.com/fairseq/models/roberta.base.tar.gz -O "roberta.base.tar.gz"
wget https://dl.fbaipublicfiles.com/fairseq/models/roberta.large.tar.gz -O "roberta.large.tar.gz"
tar xvf roberta.base.tar.gz
mv "roberta.base" "${BERT_DIR}/"
tar xvf roberta.large.tar.gz
mv "roberta.large" "${BERT_DIR}/"
rm "roberta.base.tar.gz"
rm "roberta.large.tar.gz"

mkdir "${BERT_DIR}/roberta"
wget -N 'https://dl.fbaipublicfiles.com/fairseq/gpt2_bpe/encoder.json' -O "${BERT_DIR}/roberta/encoder.json"
wget -N 'https://dl.fbaipublicfiles.com/fairseq/gpt2_bpe/vocab.bpe' -O "${BERT_DIR}/roberta/vocab.bpe"
wget -N 'https://dl.fbaipublicfiles.com/fairseq/gpt2_bpe/dict.txt' -O "${BERT_DIR}/roberta/ict.txt"
