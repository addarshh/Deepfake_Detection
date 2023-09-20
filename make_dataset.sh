echo ""
echo "-------------------------------------------------"
echo "| Index DFDC dataset                            |"
echo "-------------------------------------------------"
DFDC_SRC=datasets/dfdc_train_part_12
python index_dfdc.py --source $DFDC_SRC

echo ""
echo "-------------------------------------------------"
echo "| Extract faces from DFDC                        |"
echo "-------------------------------------------------"
DFDC_SRC=datasets/dfdc_train_part_12
VIDEODF_SRC=data/dfdc_videos.pkl
FACES_DST=faces/output/directory
FACESDF_DST=faces/df/output/directory
CHECKPOINT_DST=tmp/per/video/outputs
python extract_faces.py --source $DFDC_SRC --videodf $VIDEODF_SRC --facesfolder $FACES_DST --facesdf $FACESDF_DST --checkpoint $CHECKPOINT_DST