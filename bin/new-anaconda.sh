#!/bin/sh

# update as new versions are released
URL=https://repo.anaconda.com/archive/Anaconda3-2026.07-1-Linux-x86_64.sh
#URL=https://repo.anaconda.com/archive/Anaconda3-2025.06-0-Linux-x86_64.sh
#URL=https://repo.anaconda.com/archive/Anaconda3-2024.10-1-Linux-x86_64.sh
#URL=https://repo.anaconda.com/archive/Anaconda3-2023.07-2-Linux-x86_64.sh
#URL=https://repo.anaconda.com/archive/Anaconda3-2023.03-Linux-x86_64.sh
#URL=https://repo.anaconda.com/archive/Anaconda3-2022.05-Linux-x86_64.sh

PREFIX=${HOME}/anaconda3

# this will automatically rotate anaconda3.{N} directories to anaconda3.{N+1}
# keeping MAXV versions beyond the currently installed version

MAXV=2

for n in $(seq $((MAXV-1)) -1 1); do
    if [ -d ${PREFIX}.$n ]; then
	mv ${PREFIX}.$n ${PREFIX}.$((n+1))
	echo mv ${PREFIX}.$n ${PREFIX}.$((n+1))	
    fi
done
if [ -d ${PREFIX} ]; then
    mv ${PREFIX} ${PREFIX}.1
fi

if [ ! -f $(basename ${URL}) ]; then
    wget ${URL}
fi

# download and install Anaconda
bash $(basename ${URL}) -b -p ${PREFIX}

# install requirement packages
conda install --file conda-requirements.txt
pip install -r requirements.txt
