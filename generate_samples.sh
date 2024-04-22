#!/bin/bash

# -----------------------------------------------------------------------------------------------
#   TOP LEVEL SCRIPT (no training involved)
# -----------------------------------------------------------------------------------------------

# This is the top script for generating new polyp data. The script:
# 1. Generates 100 new masks with FastGAN
# 2. Uses Guided diffusion to generate synthetic polyps
# 3. Inpaints synthetic polyps with RePaint algorithm

# -----------------------------------------------------------------------------------------------
#   Generate masks 
# -----------------------------------------------------------------------------------------------

echo "Starting mask generation"
# Should probably not be eval. Eval seems like an evaluation script rather than raw output
python Mask-Generation/eval.py

echo "Mask generation finished"

# -----------------------------------------------------------------------------------------------
#   Generate Polyps
# -----------------------------------------------------------------------------------------------

echo "Starting polyp generation"
pth="Polyp-Diffusion-Path.pt"

echo "Polyp generation finished"

# -----------------------------------------------------------------------------------------------
#   InPaint
# -----------------------------------------------------------------------------------------------
echo "Starting polyp inpainting"
pth="Polyp-Inpaint-Path.pt"

echo "Inpaint finished"
echo "Process finished!"

# make executable with: chmod +x generate_samples.sh