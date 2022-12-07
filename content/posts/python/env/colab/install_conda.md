---
title: "[Colab] Colab에서 Conda 사용하기"
url: python/how_to_install_conda_in_colab
date: 2023-04-08T07:32:15Z
draft: false
mermaid: true
math: true
menu:
  sidebar:
    name: "[Colab] Colab에서 Conda 사용하기"
    identifier: python-colab-install-conda
    parent: python
    weight: 10
tags: ["Colab", "Anaconda", "Conda", "Python"]
categories: [""]
---

## 목표

> Colab에서 conda 명령어를 사용하여 Package를 설치할 수 있다.

&nbsp;

----

아래의 명령어를 Colab의 코드 셀에 복사 붙여넣기를 하면 conda 명령어를 사용하여 package를 설치해서 사용할 수 있다.

```shell
# conda install

# unset python path
%env PYTHONPATH= 

# print python path
!echo $PYTHONPATH

# install miniconda
!wget https://repo.anaconda.com/miniconda/Miniconda3-py37_4.12.0-Linux-x86_64.sh
!chmod +x Miniconda3-py37_4.12.0-Linux-x86_64.sh
!bash ./Miniconda3-py37_4.12.0-Linux-x86_64.sh -b -f -p /usr/local/
```

출처: https://www.linkedin.com/pulse/how-install-run-conda-google-colab-ambu-vijayan