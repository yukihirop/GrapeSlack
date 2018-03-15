FROM ubuntu:xenial

USER root
# rootパスワードを削除する
RUN passwd -d root

# パッケージなどのインストール
# インタラクティブな設定をしなくなる（＝入力待ちでブロックしなくなる）
RUN export DEBIAN_FRONTED=noninteractive \
  && apt-get update \
  && apt-get install -y python \
  && apt-get install -y software-properties-common \
  && apt-get install -y python-pip make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
  # 公式にansibleのパッケージはないのでppa(PrivatePackagesActive)を使う
  && apt-add-repository -y ppa:ansible/ansible \
  && apt-get update \
  && apt-get install -y ansible \
  && apt-get install -y openssh-server \
  # pipのupgrade
  && pip install --upgrade pip \
  && pip install apache-libcloud \
  && pip install pycrpto \
  # https://github.com/rethinkdb/rethinkdb/issues/4683
  && pip install backports.ssl_match_hostname \
  # pythonでインタラクティブシェル
  && pip install IPython==5.0 --user

COPY sshd_config /etc/ssh/sshd_config

# ansibleの設定
RUN /bin/mkdir -p /.gcp/ansible
#ADD ./credentials/MyProject-ansible.json /.gcp/ansible.json
#ADD ./credentials/secrets.py /.gcp/secrets.py
#ADD ../gce.yml ~/.gcp/gce.yml
