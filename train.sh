#!/usr/bin/env bash
DEVICE=0
echo ""
echo "-------------------------------------------------"
echo "| Train EfficientNetB4 on DFDC                   |"
echo "-------------------------------------------------"
# put your DFDC source directory path for the extracted faces and Dataframe and uncomment the following line
DFDC_FACES_DIR=faces/output/directory
DFDC_FACES_DF=faces/df/output/directory/faces_df.pkl
python train_binclass.py --net EfficientNetB4 --traindb dfdc-35-5-10 --valdb dfdc-35-5-10 --dfdc_faces_df_path $DFDC_FACES_DF --dfdc_faces_dir $DFDC_FACES_DIR --face scale --size 224 --batch 32 --lr 1e-5 --valint 500 --patience 10 --maxiter 30000 --seed 41 --attention --device $DEVICE