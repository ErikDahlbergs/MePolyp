#!/bin/bash
# config.sh


# FROM TRAIN DIFFUSION
MODEL_FLAGS="--image_size 64 --num_channels 128 --num_res_blocks 3"
DIFFUSION_FLAGS="--diffusion_steps 1000 --noise_schedule linear"
TRAIN_FLAGS="--iterations 100 --anneal_lr True --batch_size 1 --lr 1e-4 --save_interval 10 --weight_decay 0.05"

# FROM SAMPLE DIFFUSION
SAMPLE_FLAGS="--batch_size 1 --num_samples 1 --timestep_respacing ddim25 --use_ddim True "
# SAMPLE_FLAGS="--batch_size 1 --num_samples 1 --timestep_respacing 1000"

TRAIN_WITH_CLASSIFIER = 0

# make executable with: chmod +x config.sh