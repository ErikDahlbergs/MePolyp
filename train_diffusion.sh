#!/bin/bash

# -----------------------------------------------------------------------------------------------
#           SCRIPT FOR FULL IMAGE DIFFUSSION TRAINING
# -----------------------------------------------------------------------------------------------

# -----------------------------------------------------------------------------------------------
#   Creating Flags
# -----------------------------------------------------------------------------------------------

# Define flags (batch size originally 128)
# MODEL_FLAGS="--image_size 64 --num_channels 128 --num_res_blocks 3"
# DIFFUSION_FLAGS="--diffusion_steps 1000 --noise_schedule linear"
# # TRAIN_FLAGS="--lr 1e-4 --batch_size 1"
# TRAIN_FLAGS="--iterations 100 --anneal_lr True --batch_size 1 --lr 1e-4 --save_interval 10 --weight_decay 0.05"
# CLASSIFIER_FLAGS="--image_size 64 --classifier_attention_resolutions 32,16,8 --classifier_depth 2 --classifier_width 64 --classifier_pool attention --classifier_resblock_updown True --classifier_use_scale_shift_norm True"

source config.sh

# -----------------------------------------------------------------------------------------------
#   Training
# -----------------------------------------------------------------------------------------------
if [$TRAIN_WITH_CLASSIFIER -eq 1]; then
    gtimeout 2h python Guided-Diffusion/scripts/classifier_train.py --data_dir "Data/Clinic CVB/Original" $MODEL_FLAGS $DIFFUSION_FLAGS $TRAIN_FLAGS $CLASSIFIER_FLAGS
else
# Execute training script with a timeout 
    gtimeout 2h python Guided-Diffusion/scripts/image_train.py --data_dir "Data/Clinic CVB/Original" $MODEL_FLAGS $DIFFUSION_FLAGS $TRAIN_FLAGS
fi

# Check if training was successful
if [ $? -eq 124 ]; then
    echo "Training terminated due to timeout."
    
else
    echo "Training completed successfully."
fi

# -----------------------------------------------------------------------------------------------
#   Automatic Sampling
# -----------------------------------------------------------------------------------------------

    # Find the checkpoint file with the highest number in the filename
latest_model=$(ls Guided-Diffusion/scripts/logs/ema_0.9999_*.pt | sort -V | tail -n 1)

if [ -z "$latest_model" ]; then
    echo "No model checkpoint files found."
else
    # Create Samples (ema model gives best results)
    python Guided-Diffusion/scripts/image_sample.py --model_path "$latest_model" $MODEL_FLAGS $DIFFUSION_FLAGS
fi

# make executable with: chmod +x train_diffusion.sh