#!/bin/bash

# -----------------------------------------------------------------------------------------------
#   SCRIPT FOR SAMPLING FROM DIFFUSION MODEL
# -----------------------------------------------------------------------------------------------

# -----------------------------------------------------------------------------------------------
#   Creating Flags (Make sure same as in Config)
# -----------------------------------------------------------------------------------------------

source config.sh

# MODEL_FLAGS="--attention_resolutions 32,16,8 --class_cond True --image_size 128 --learn_sigma True --num_channels 256 --num_heads 4 --num_res_blocks 2 --resblock_updown True --use_fp16 True --use_scale_shift_norm True"
# CLASSIFIER_FLAGS="--image_size 64 --classifier_attention_resolutions 32,16,8 --classifier_depth 2 --classifier_width 64 --classifier_pool attention --classifier_resblock_updown True --classifier_use_scale_shift_norm True --classifier_scale 1.0 --classifier_use_fp16 True"
# SAMPLE_FLAGS="--batch_size 4 --num_samples 3 --timestep_respacing ddim25 --use_ddim True"

# -----------------------------------------------------------------------------------------------
#   Script
# -----------------------------------------------------------------------------------------------

latest_model=$(ls Guided-Diffusion/scripts/logs/ema_0.9999_*.pt | sort -V | tail -n 1)

if [$TRAIN_WITH_CLASSIFIER -eq 1]; then
    mpiexec -n N python scripts/classifier_sample.py \
        --model_path "$latest_model" \
        --classifier_path path/to/classifier.pt \
        $MODEL_FLAGS $CLASSIFIER_FLAGS $SAMPLE_FLAGS
else
    if [ -z "$latest_model" ]; then
        echo "No model checkpoint files found."
    else
        # Create Samples (ema model gives best results)
        python Guided-Diffusion/scripts/image_sample.py --model_path "$latest_model" $MODEL_FLAGS $DIFFUSION_FLAGS
    fi
fi
# make executable with: chmod +x sample_diffusion.sh