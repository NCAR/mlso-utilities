#!/bin/sh

# run on dawn

URL=https://repo.anaconda.com/archive/Anaconda3-2023.03-Linux-x86_64.sh
#URL=https://repo.anaconda.com/archive/Anaconda3-2022.05-Linux-x86_64.sh
PREFIX=${HOME}/anaconda3

mv ${PREFIX} ${PREFIX}.old

wget ${URL}
bash $(basename ${URL}) -b -p ${PREFIX}

pip install rich
pip install watchfiles
pip install pre_commit
