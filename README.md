# Deepfake Detection Project
### Video Face Manipulation Detection Through Ensemble of different experiemnetation technique
[![Build Status](https://travis-ci.org/polimi-ispl/icpr2020dfdc.svg?branch=master)](https://travis-ci.org/polimi-ispl/icpr2020dfdc)


The project has been inspired by the Kaggle Competition from the [Kaggle Deepfake Detection Challenge](https://www.kaggle.com/c/deepfake-detection-challenge/).
We used a base kernel for the solution, where Blazeface is used as a face detection technique, and Efficient NetB4 is used as a classification model to detect manipulated faces. We did several experiments on top of these base solutions, listed below:
- Convex Hull
- Sensory Augmentation
- Full Augmentation
- Side Blaze Face
- Blurring
- Face Angle Sampling
- Masking (polygon)
- Side Face Augmentation
- Ensemble of experiments above

With this implementation, we achieved best test score of 0.841 AUC

## Getting started

    
## Prerequisites  
### Downloading Dataset
The existing work is performed on a dataset from the [Kaggle Deepfake Detection Challenge](https://www.kaggle.com/c/deepfake-detection-challenge)

Otherwise, to download the dataset from Kaggle, you can use any method [listed in the discussion here](https://www.kaggle.com/c/deepfake-detection-challenge/discussion/121695) to suit your requirements


### Train
In [train_all.sh](scripts/train_all.sh) you can find a comprehensive list of all the commands to train the models presented in the paper. 
Please refer to the comments in the script for hints on their usage. 

#### Training a single model
If you want to train some models without lunching the script:
- for the **non-siamese** architectures (e.g. EfficientNetB4, EfficientNetB4Att), you can simply specify the model in [train_binclass.py](train_binclass.py) with the *--net* parameter;
- for the **siamese** architectures (e.g. EfficientNetB4ST, EfficientNetB4AttST), you have to:
  1. train the architecture as a feature extractor first, using the [train_triplet.py](train_triplet.py) script and being careful of specifying its name with the *--net* parameter **without** the ST suffix. For instance, for training the EfficientNetB4ST you will have to first run `python train_triplet.py --net EfficientNetB4 --otherparams`;
  2. finetune the model using [train_binclass.py](train_binclass.py), being careful this time to specify the architecture's name **with** the ST suffix and to insert as *--init* argument the path to the weights of the feature extractor trained at the previous step. You will end up running something like `python train_binclass.py --net EfficientNetB4ST --init path/to/EfficientNetB4/weights/trained/with/train_triplet/weights.pth --otherparams`



## Datasets
- [Facebook's DeepFake Detection Challenge (DFDC) train dataset](https://www.kaggle.com/c/deepfake-detection-challenge/data) | [arXiv paper](https://arxiv.org/abs/2006.07397)
- [FaceForensics++](https://github.com/ondyari/FaceForensics/blob/master/dataset/README.md) | [arXiv paper](https://arxiv.org/abs/1901.08971)

## References
- [EfficientNet PyTorch](https://github.com/lukemelas/EfficientNet-PyTorch)
- [Xception PyTorch](https://github.com/tstandley/Xception-PyTorch)

## Credits
- Adarsh Agrawal
- Adeem Jassani
- Sai Pokkunuri
