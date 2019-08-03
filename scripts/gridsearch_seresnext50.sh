#!/usr/bin/env bash

# Pretrain model to start with something more or less accurate
python train_classifier_baseline.py -m seresnext50_avg -a light -f 0 -b 60 --fp16 -o AdamW -lr 1e-4 -wd 1e-4\
  -e 50 --warmup 10 -v --use-aptos2019 --use-idrid --use-messidor -x cls_seresnext50_avg_pretrain
sleep 5

# Medium augmentation
python train_classifier_baseline.py -m seresnext50_avg -a medium -f 0 -b 60 --fp16 -o AdamW -lr 5e-5 -wd 1e-4\
  -e 50 -v --use-aptos2019 --use-idrid --use-messidor -t cls_seresnext50_avg_pretrain.pth
sleep 5

# Hard augmentation
python train_classifier_baseline.py -m seresnext50_avg -a hard -f 0 -b 60 --fp16 -o AdamW -lr 5e-5 -wd 1e-4\
  -e 50 -v --use-aptos2019 --use-idrid --use-messidor -t cls_seresnext50_avg_pretrain.pth
sleep 5

# Regression
python train_regression_baseline.py -m seresnext50_avg -a light -f 0 -b 60 --fp16 -o AdamW -lr 1e-4 -wd 1e-4\
  -e 50 --warmup 10 -v --use-aptos2019 --use-idrid --use-messidor -t seresnext50_avg_pretrain.pth -x reg_seresnext50_avg_pretrain
sleep 5

python train_regression_baseline.py -m seresnext50_avg -a medium -f 0 -b 60 --fp16 -o AdamW -lr 5e-5 -wd 1e-4\
  -e 50  -v --use-aptos2019 --use-idrid --use-messidor -t reg_seresnext50_avg_pretrain.pth
sleep 5

python train_regression_baseline.py -m seresnext50_avg -a hard -f 0 -b 60 --fp16 -o AdamW -lr 5e-5 -wd 1e-4\
  -e 50  -v --use-aptos2019 --use-idrid --use-messidor -t reg_seresnext50_avg_pretrain.pth
sleep 5

# Losses (cls)
python train_classifier_baseline.py -m seresnext50_avg -a medium -f 0 -b 60 --fp16 -o AdamW -lr 5e-5 -wd 1e-4\
  -e 50 -v --use-aptos2019 --use-idrid --use-messidor --criterion-cls hybrid_kappa -t cls_seresnext50_avg_pretrain.pth
sleep 5

python train_classifier_baseline.py -m seresnext50_avg -a medium -f 0 -b 60 --fp16 -o AdamW -lr 5e-5 -wd 1e-4\
  -e 50 -v --use-aptos2019 --use-idrid --use-messidor --criterion-cls focal -t cls_seresnext50_avg_pretrain.pth
sleep 5

python train_classifier_baseline.py -m seresnext50_avg -a medium -f 0 -b 60 --fp16 -o AdamW -lr 5e-5 -wd 1e-4\
  -e 50 -v --use-aptos2019 --use-idrid --use-messidor  --criterion-cls soft_ce -t cls_seresnext50_avg_pretrain.pth
sleep 5

# Losses (regressioN)
python train_regression_baseline.py -m seresnext50_avg -a medium -f 0 -b 60 --fp16 -o AdamW -lr 5e-5 -wd 1e-4\
  -e 50  -v --use-aptos2019 --use-idrid --use-messidor --criterion-reg clipped_wing_loss -t reg_seresnext50_avg_pretrain.pth
sleep 5

python train_regression_baseline.py -m seresnext50_avg -a medium -f 0 -b 60 --fp16 -o AdamW -lr 5e-5 -wd 1e-4\
  -e 50  -v --use-aptos2019 --use-idrid --use-messidor --criterion-reg clipped_mse -t reg_seresnext50_avg_pretrain.pth
sleep 5

