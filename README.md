# 1. Acknowledgements

This repo is the code for the master thesis of Erik Dahlberg, Lund University and based on the github repos:

https://github.com/odegeasslbc/FastGAN-pytorch/tree/main
https://github.com/openai/improved-diffusion
https://github.com/andreas128/RePaint/tree/main

and the paper by Alexander K. Pishva , Vajira Thambawita , Jim Torresen , and Steven A. Hicks on "RePolyp: A Framework for Generating Realistic Colon Polyps with Corresponding Segmentation Masks using Diffusion Models" who utilised the above repos to create image synthesis for polyp segmentation. 

# 2. Model Setup

FAST-GAN: Used to generate polyp masks
GUIDED DIFFUSION: Used to train a stable diffusion polyp generator. Polyps are generated with masks applied, i.e only the polyps are visible.
REPAINT: Inpaint algorithm trained on colon data to inpaint. Used to generate surrounding of polyps.

# 3. Data and Resources
Training data was a mix of HyperKvasir's open data-set and classified colonoscopy images property of.

A 2080Ti 16Gb was used for training. 

# 4. Instructions
## 4.1 Generate Samples
To create samples based on our pretrained model, simply run the sample script by:

    ./generate_samples.sh

## 4.2 Pre-trained models
Models created in this project are available through. 

Load them by adding their model path to the ./train_diffusion.sh script. 

# Results

