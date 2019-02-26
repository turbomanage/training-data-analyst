#!/bin/bash
rm -rf taxifare.tar.gz taxi_trained
export PYTHONPATH=${PYTHONPATH}:${PWD}/taxifare
python -m trainer.task \
  --train_data_paths=${PWD}/taxifare/preproc/20k/train.csv \
  --eval_data_paths=${PWD}/taxifare/preproc/20k/valid.csv  \
  --output_dir=${PWD}/taxi_trained \
  --train_batch_size=128 \
  --hidden_units="144 89 55" \
  --nbuckets=20 \
  --train_steps=121393 \
  --job-dir=/tmp
